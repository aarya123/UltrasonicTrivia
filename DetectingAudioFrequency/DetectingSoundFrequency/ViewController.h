#import <UIKit/UIKit.h>
#import "mo_audio.h"
#import "FFTHelper.h"
@interface ViewController : UIViewController {
    #define SAMPLE_RATE 44100  //22050 //44100
    #define FRAMESIZE  512
    #define NUMCHANNELS 2
    #define kOutputBus 0
    #define kInputBus 1
}
@end
