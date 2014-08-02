//
//  AppConstants.m
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "AppConstants.h"

@implementation AppConstants
+(UIColor*) blackFont
{
    static UIColor* blackFont = nil;
    if (blackFont == nil)
        blackFont = [UIColor colorWithRed:52/255.0f green:73/255.0f blue:94/255.0f alpha:1.0f];
    return blackFont;
}
+(UIColor*) green
{
    static UIColor* green = nil;
    if (green == nil)
        green = [UIColor colorWithRed:46/255.0f green:204/255.0f blue:113/255.0f alpha:1.0f];
    return green;
}
+(UIColor*) red
{
    static UIColor* red = nil;
    if (red == nil)
        red = [UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0f];
    return red;
}
+(UIColor*) whiteBackground
{
    static UIColor* whiteBackground = nil;
    if (whiteBackground == nil)
        whiteBackground = [UIColor colorWithRed:236/255.0f green:240/255.0f blue:241/255.0f alpha:1.0f];
    return whiteBackground;
}
@end
