//
//  AppDelegate.h
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RouterConnector.h"
#import "DDConnection.h"
#import "LaunchAtLoginController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *menu;
    NSStatusItem *statusItem;
}

- (IBAction)stopVPN:(id)sender;
- (IBAction)createConnection:(id)sender;
- (IBAction)removeConnection:(id)sender;
- (IBAction)switchAutoStart:(id)sender;
- (IBAction)activateWindow:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSWindow *optionsWindow;
@property (weak) IBOutlet NSTextField *titleTextBox;
@property (weak) IBOutlet NSTextField *ipTextBox;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSButtonCell *autoLaunchCheckBox;

@property (weak) IBOutlet NSTextField *routerIpTextbox;
@property (weak) IBOutlet NSTextField *routerUserTextbox;
@property (weak) IBOutlet NSSecureTextField *routerPasswordTextbox;

@property (strong) RouterConnector *rc;

@end