//
//  DDRouterLink.m
//  DDVPN
//
//  Created by Timur Yanberdin on 27.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "RouterConnector.h"

@implementation RouterConnector

- (id)initWithIpString:(NSString *)ip
        andLoginString:(NSString *)login
     andPasswordString:(NSString *)password {
    self = [super init];
    self.ip = ip;
    self.login = login;
    self.password = password;
    
    return self;
}

- (void) connectViaSSH {
    NSLog(@"Connectiong to %@", self.ip);
}

@end
