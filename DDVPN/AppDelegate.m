//
//  AppDelegate.m
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    NSBundle *bundle = [NSBundle mainBundle];
    [statusItem setTitle:@"VPN"];
    [statusItem setMenu:menu];
    
}



- (IBAction)stopVPN:(id)sender {
    NSLog(@"Stopping VNP");
}

@end
