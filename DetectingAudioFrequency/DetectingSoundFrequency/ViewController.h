#import <UIKit/UIKit.h>
#import "mo_audio.h"
#import "FFTHelper.h"
#import "ChoiceController.h"
#import "Server.h"
#define SAMPLE_RATE 44100  //22050 //44100
#define FRAMESIZE  512
#define NUMCHANNELS 2
#define kOutputBus 0
#define kInputBus 1

@interface ViewController : UIViewController
-(void) handleCorrectAnswer;
-(void) handleIncorrectAnswer;
+(void) staticHandleNewFreq:(Float32) freq;
@property (nonatomic,strong)UITableView* choiceButtons;
@end
