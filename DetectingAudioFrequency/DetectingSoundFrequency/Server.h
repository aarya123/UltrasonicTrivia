//
//  Server.h
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject
+(NSData*)getQuestion:(Float32)freq;
+(int)submitCorrectAnswer:(NSString*)show;
@end
