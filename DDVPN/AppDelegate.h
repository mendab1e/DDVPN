//
//  AppDelegate.h
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *menu;
    NSStatusItem *statusItem;
}

- (IBAction)stopVPN:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
