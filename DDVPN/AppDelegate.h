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

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *menu;
    NSStatusItem *statusItem;
}

- (IBAction)stopVPN:(id)sender;
- (IBAction)createConnection:(id)sender;
- (IBAction)removeConnection:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *titleTextBox;
@property (weak) IBOutlet NSTextField *ipTextBox;
@property (weak) IBOutlet NSTableView *tableView;

@property (strong) RouterConnector *rc;

@end