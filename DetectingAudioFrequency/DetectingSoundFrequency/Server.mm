//
//  Server.m
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "Server.h"

@implementation Server
NSString * const questionUrl=@"http://sonic.test.hulu.com/question/%0.3f";
NSString * const answerUrl=@"http://sonic.test.hulu.com/score/%@/%@";
+(NSData*)getQuestion:(Float32)freq{
    NSString *requestUrl=[NSString stringWithFormat:questionUrl,freq];
    NSLog(@"Request URL: %@",[NSURL URLWithString:requestUrl]);
    return [Server getData:requestUrl];
}
+(int)submitCorrectAnswer:(NSString*)show{
    NSString *requestUrl=[NSString stringWithFormat:answerUrl,show,[[NSUserDefaults standardUserDefaults] stringForKey:@"user"]];
    NSLog(@"Request URL: %@",[NSURL URLWithString:requestUrl]);
    NSData* response= [Server getData:requestUrl];
    NSError *localError = nil;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&localError];
    return [[responseDict valueForKey:@"score"]intValue];
    
}
+(NSData*)getData:(NSString *)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
}
@end
