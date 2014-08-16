//
//  AppDelegate.m
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate() <NSTableViewDataSource, NSTableViewDelegate>
@property (strong, nonatomic) NSMutableArray *connectionsList;
@end


@implementation AppDelegate

@synthesize titleTextBox;
@synthesize ipTextBox;

- (void)awakeFromNib
{
    statusItem = [[NSStatusBar systemStatusBar]
                  statusItemWithLength:NSVariableStatusItemLength];
    
    [statusItem setTitle:@"VPN"];
    [statusItem setMenu:menu];
    
    self.connectionsList = [NSMutableArray array];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.rc = [[RouterConnector alloc]
               initWithIpString:@"192.168.1.1"
               andLoginString:@"root"
               andPasswordString:@"testpass"];
}

- (IBAction)stopVPN:(id)sender {
    [self.rc stopVPN];
}

- (IBAction)createConnection:(id)sender {
    NSString *ip = ipTextBox.stringValue;
    NSString *title = titleTextBox.stringValue;
    
    if ([self searchForConenction:title] == nil) {
        DDConnection *connection = [[DDConnection alloc]
                                    initWithTitleString:title
                                    andIpString:ip];
        [self.connectionsList addObject:connection];
        [self.tableView reloadData];
        [self insertConnectionToMenu:title];
        [self saveConnectionsInFile];
    } else {
        [self showAllert:@"Connection with this title already exists"];
    }
}

- (void) showAllert:(NSString *) message {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:message];
    [alert runModal];
    alert = nil;
}

- (void) insertConnectionToMenu:(NSString *) title {
    NSMenuItem *menuItem = [menu
                            insertItemWithTitle:title
                            action:@selector(connectionCallback:)
                            keyEquivalent:@""
                            atIndex:0];
    [menuItem setTarget:self];
}

- (void) saveConnectionsInFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"ddconfig.plist"];
    [NSKeyedArchiver archiveRootObject:self.connectionsList toFile:filepath];
}

// Switch connection on menuitem click
- (void) connectionCallback:(id)sender {
    NSString *title = ((NSMenuItem *) sender).title;
    DDConnection *connection = [self searchForConenction:title];
    if (connection != nil) {
        [self.rc switchVPN:connection];
    }
}

- (DDConnection *) searchForConenction:(NSString *) title {
    for (DDConnection *connection in self.connectionsList) {
        if (connection.title == title) {
            return connection;
        }
    }
    
    return nil;
}

#pragma mark - NSTableViewDataSource NSTableViewDelegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.connectionsList.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row
{
    if ([tableColumn.identifier  isEqual: @"title"]) {
        return [[self.connectionsList objectAtIndex:row] title];
    } else if ([tableColumn.identifier  isEqual: @"ip"]) {
        return [[self.connectionsList objectAtIndex:row] ip];
    }
    
    return nil;
}

@end
