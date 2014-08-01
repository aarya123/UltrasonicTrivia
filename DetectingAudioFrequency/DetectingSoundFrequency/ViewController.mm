#import "ViewController.h"

/// Nyquist Maximum Frequency
const Float32 NyquistMaxFreq = SAMPLE_RATE/2.0;

/// caculates HZ value for specified index from a FFT bins vector
Float32 frequencyHerzValue(long frequencyIndex, long fftVectorSize, Float32 nyquistFrequency ) {
    return ((Float32)frequencyIndex/(Float32)fftVectorSize) * nyquistFrequency;
}

// The Main FFT Helper
FFTHelperRef *fftConverter = NULL;

//Accumulator Buffer=====================
const UInt32 accumulatorDataLength = 131072;  //16384; //32768; 65536; 131072;
UInt32 accumulatorFillIndex = 0;
Float32 *dataAccumulator = nil;
static void initializeAccumulator() {
    dataAccumulator = (Float32*) malloc(sizeof(Float32)*accumulatorDataLength);
    accumulatorFillIndex = 0;
}
static void destroyAccumulator() {
    if (dataAccumulator!=NULL) {
        free(dataAccumulator);
        dataAccumulator = NULL;
    }
    accumulatorFillIndex = 0;
}

static BOOL accumulateFrames(Float32 *frames, UInt32 lenght) { //returned YES if full, NO otherwise.
    //    float zero = 0.0;
    //    vDSP_vsmul(frames, 1, &zero, frames, 1, lenght);
    
    if (accumulatorFillIndex>=accumulatorDataLength) { return YES; } else {
        memmove(dataAccumulator+accumulatorFillIndex, frames, sizeof(Float32)*lenght);
        accumulatorFillIndex = accumulatorFillIndex+lenght;
        if (accumulatorFillIndex>=accumulatorDataLength) { return YES; }
    }
    return NO;
}

static void emptyAccumulator() {
    accumulatorFillIndex = 0;
    memset(dataAccumulator, 0, sizeof(Float32)*accumulatorDataLength);
}
//=======================================

//==========================Window Buffer
const UInt32 windowLength = accumulatorDataLength;
Float32 *windowBuffer= NULL;
//=======================================

/// max value from vector with value index (using Accelerate Framework)
static Float32 vectorMaxValueACC32_index(Float32 *vector, unsigned long size, long step, unsigned long *outIndex) {
    Float32 maxVal;
    vDSP_maxvi(vector, step, &maxVal, outIndex, size);
    return maxVal;
}

///returns HZ of the strongest frequency.
static Float32 strongestFrequencyHZ(Float32 *buffer, FFTHelperRef *fftHelper, UInt32 frameSize, Float32 *freqValue) {
    Float32 *fftData = computeFFT(fftHelper, buffer, frameSize);
    fftData[0] = 0.0;
    unsigned long length = frameSize/2.0;
    Float32 max = 0;
    unsigned long maxIndex = 0;
    max = vectorMaxValueACC32_index(fftData, length, 1, &maxIndex);
    if (freqValue!=NULL) { *freqValue = max; }
    Float32 HZ = frequencyHerzValue(maxIndex, length, NyquistMaxFreq);
    return HZ;
}

__weak UILabel *labelToUpdate = nil;

#pragma mark MAIN CALLBACK
void AudioCallback( Float32 * buffer, UInt32 frameSize, void * userData )
{
    
    
    //take only data from 1 channel
    Float32 zero = 0.0;
    vDSP_vsadd(buffer, 2, &zero, buffer, 1, frameSize*NUMCHANNELS);
    
    
    
    if (accumulateFrames(buffer, frameSize)==YES) { //if full
        
        //windowing the time domain data before FFT (using Blackman Window)
        if (windowBuffer==NULL) { windowBuffer = (Float32*) malloc(sizeof(Float32)*windowLength); }
        vDSP_blkman_window(windowBuffer, windowLength, 0);
        vDSP_vmul(dataAccumulator, 1, windowBuffer, 1, dataAccumulator, 1, accumulatorDataLength);
        //=========================================
        
        
        Float32 maxHZValue = 0;
        Float32 maxHZ = strongestFrequencyHZ(dataAccumulator, fftConverter, accumulatorDataLength, &maxHZValue);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{ //update UI only on main thread
            [ViewController staticHandleNewFreq:maxHZ];
        });
        
        emptyAccumulator(); //empty the accumulator when finished
    }
    memset(buffer, 0, sizeof(Float32)*frameSize*NUMCHANNELS);
}

@interface ViewController ()
@property (nonatomic, strong) UILabel* freqLabel;
@property (nonatomic, strong) UILabel* questionLabel;
@property (nonatomic, strong) UILabel* scoreLabel;
@property (nonatomic,strong)NSDictionary* currQuestion;
@property (nonatomic,strong)ChoiceController* choiceController;
@property(nonatomic)int score;
@end

@implementation ViewController
static ViewController *instance;


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.freqLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height/8)];
    [self.freqLabel setTextAlignment:NSTextAlignmentCenter];
    [self.freqLabel setText:@"No Frequency"];
    [self.view addSubview:self.freqLabel];
    
    self.questionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,self.freqLabel.frame.size.height, screenRect.size.width, screenRect.size.height/8)];
    [self.questionLabel setTextAlignment:NSTextAlignmentCenter];
    [self.questionLabel setText:@"No question"];
    [self.questionLabel setHidden:YES];
    [self.view addSubview:self.questionLabel];
    
    self.choiceButtons=[[UITableView alloc]initWithFrame:CGRectMake(0, self.questionLabel.frame.origin.y+self.questionLabel.frame.size.height, screenRect.size.width, screenRect.size.height-screenRect.size.height/4) style:UITableViewStylePlain];
    [self.choiceButtons setAllowsSelection:NO];
    self.choiceController=[[ChoiceController alloc]init:self];
    [self.view addSubview:self.choiceButtons];
    
    self.scoreLabel=[[UILabel alloc]initWithFrame:self.choiceButtons.frame];
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.scoreLabel setText:@"0"];
    [self.scoreLabel setHidden:YES];
    [self.view addSubview:self.scoreLabel];
    
    labelToUpdate = self.freqLabel;
    instance=self;
    //initialize stuff
    fftConverter = FFTHelperCreate(accumulatorDataLength);
    initializeAccumulator();
    [self initMomuAudio];
}

-(void) initMomuAudio {
    bool result = false;
    result = MoAudio::init( SAMPLE_RATE, FRAMESIZE, NUMCHANNELS, false);
    if (!result) { NSLog(@" MoAudio init ERROR"); }
    result = MoAudio::start( AudioCallback, NULL );
    if (!result) { NSLog(@" MoAudio start ERROR"); }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void) dealloc {
    destroyAccumulator();
    FFTHelperRelease(fftConverter);
}
-(void) handleQuestion:(NSData*) questionInfo{
    NSError *localError = nil;
    questionInfo = [@"{\"answer\": 2,\"choices\": [ \"40\",\"41\",\"42\",\"43\"],\"question\": \"What is the answer to the Ultimate Question of Life, the Universe, and Everything?\",\"show\": \"South_Park\"}" dataUsingEncoding:NSUTF8StringEncoding];
    self.currQuestion = [NSJSONSerialization JSONObjectWithData:questionInfo options:NSJSONReadingMutableContainers error:&localError];
    NSLog(@"%@",    self.currQuestion);
    if([self.currQuestion objectForKey:@"error"]==nil)
    {
        [self.questionLabel setText:[self.currQuestion valueForKey:@"question"]];
        [self.questionLabel setBackgroundColor:[UIColor whiteColor]];
        [self.questionLabel setHidden:NO];
        [self.choiceController setDataSource:self.currQuestion];
        [self.choiceButtons setHidden:NO];
        [self.scoreLabel setHidden:YES];
    }
    else{
        NSLog(@"Found no question");
        [self.questionLabel setHidden:YES];
        [self.choiceButtons setHidden:YES];
        [self.scoreLabel setHidden:NO];
    }
}
-(void) handleCorrectAnswer{
    [self.questionLabel setBackgroundColor:[UIColor greenColor]];
    self.score=[Server submitCorrectAnswer:[self.currQuestion valueForKey:@"show"]];
    [self.choiceButtons setHidden:YES];
    [self.scoreLabel setHidden:NO];
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",self.score]];
}
-(void) handleIncorrectAnswer{
    [self.questionLabel setBackgroundColor:[UIColor redColor]];
    [self.choiceButtons setHidden:YES];
    [self.scoreLabel setHidden:NO];
}
-(void) getQuestion:(Float32)freq{
    //    NSString *requestUrl=[NSString stringWithFormat:url,freq];
    //    NSLog(@"Request URL: %@",[NSURL URLWithString:requestUrl]);
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    //    [request setHTTPMethod: @"GET"];
    //    NSError *requestError;
    //    NSURLResponse *urlResponse = nil;
    //    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    //    if(responseData!=nil)
    //        [self handleQuestion:responseData];
    [self handleQuestion:nil];
}
double lastCheck=0;
-(void) instanceHandleNewFreq:(Float32) freq{
    [self.freqLabel setText:[NSString stringWithFormat:@"%0.3f HZ",freq]];
    if([[NSDate date] timeIntervalSince1970]-lastCheck>20){
        lastCheck=[[NSDate date] timeIntervalSince1970];
        [self getQuestion:freq];
    }
}
+(void) staticHandleNewFreq:(Float32) freq{
    [instance instanceHandleNewFreq:freq];
}

@end
