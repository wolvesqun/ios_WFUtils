//
//  WFAudioPlayer.m
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFAudioPlayer.h"

@interface WFAudioPlayer ()

@end

@implementation WFAudioPlayer

- (instancetype)initWithURL:(NSURL *)aURL
{
    if(self = [super init])
    {
        _aURL = [aURL copy];
    }
    return self;
}

- (void)play
{
    [self openReadStream];
}

- (BOOL)openReadStream
{
    CFStringRef httpMethod = CFSTR("GET");
    CFURLRef requestURL = (__bridge CFURLRef)(self.aURL);
    CFHTTPMessageRef message = CFHTTPMessageCreateRequest(kCFAllocatorDefault,httpMethod, requestURL, kCFHTTPVersion1_0);
    
    return YES;
}

- (void)test
{
    

}

@end
