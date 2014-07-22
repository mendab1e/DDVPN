//
//  AppDelegate.m
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize titleTextBox;
@synthesize ipTextBox;

- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    [statusItem setTitle:@"VPN"];
    [statusItem setMenu:menu];
    
}

- (IBAction)stopVPN:(id)sender {
    NSLog(@"Stopping VNP");
}

- (IBAction)createConnection:(id)sender {
    NSString *ip = ipTextBox.stringValue;
    NSLog(@"Connecting ip: %@", ip);
}


@end
