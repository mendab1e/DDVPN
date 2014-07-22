//
//  DDConnection.m
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "DDConnection.h"

@implementation DDConnection

@synthesize title = _title;
@synthesize ip = _ip;

- (NSString*) title {
    return _title;
}

- (NSString*) ip {
    return _ip;
}

- (id) initWithTitleString: (NSString *) title andIpString:(NSString*) ip {
    self = [super init];
    self.title = title;
    self.ip = ip;
    
    return self;
}

- (void) connect {
    NSLog(@"Connecting to %@", self.ip);
}

@end
