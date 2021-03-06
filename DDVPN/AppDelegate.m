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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self initializeConnectionList ];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *routerIp = [userDef stringForKey:@"routerIp"];
    if (routerIp == nil) {
        routerIp = @"";
    }
    
    NSString *routerUser = [userDef stringForKey:@"routerUser"];
    if (routerUser == nil) {
        routerUser = @"";
    }
    
    NSString *routerPassword = [userDef stringForKey:@"routerPassword"];
    if (routerPassword == nil) {
        routerPassword = @"";
    }
    
    self.rc = [[RouterConnector alloc]
               initWithIpString:routerIp
               andLoginString:routerUser
               andPasswordString:routerPassword];
    
    self.routerIpTextbox.stringValue = routerIp;
    self.routerPasswordTextbox.stringValue = routerPassword;
    self.routerUserTextbox.stringValue = routerUser;
    
    LaunchAtLoginController *launchController = [[LaunchAtLoginController alloc] init];
    BOOL launch = [launchController launchAtLogin];
    if (launch) {
        self.autoLaunchCheckBox.state = 1;
    }

}

- (IBAction)saveSettings:(id)sender {
    NSString *routerIp = self.routerIpTextbox.stringValue;
    NSString *routerUser = self.routerUserTextbox.stringValue;
    NSString *routerPassword = self.routerPasswordTextbox.stringValue;
    
    if (routerIp.length == 0 ||
        routerPassword.length == 0 ||
        routerUser.length == 0) {
        [self showAllert:@"Router ip or Password or User is not specified."];
        return;
    }
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:routerIp forKey:@"routerIp"];
    [userDef setObject:routerUser forKey:@"routerUser"];
    [userDef setObject:routerPassword forKey:@"routerPassword"];
    
    self.rc = [[RouterConnector alloc]
               initWithIpString:routerIp
               andLoginString:routerUser
               andPasswordString:routerPassword];
}

- (IBAction)removeConnection:(id)sender {
    int rowId = (int)[self.tableView selectedRow];
    if (rowId >= 0) {
        DDConnection *connection = [self.connectionsList objectAtIndex:rowId];
        NSString *title = connection.title;
        [self.connectionsList removeObjectAtIndex:rowId];
        [self saveConnectionsInFile];
        [self removeConnectionFromMenu:title];
    }
}

- (IBAction)switchAutoStart:(id)sender {
    LaunchAtLoginController *launchController = [[LaunchAtLoginController alloc] init];
    if (self.autoLaunchCheckBox.state == 1) {
        [launchController setLaunchAtLogin:YES];
    } else {
        [launchController setLaunchAtLogin:NO];
    }
}

- (IBAction)activateWindow:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [[self optionsWindow] makeKeyAndOrderFront:nil];
}

- (IBAction)stopVPN:(id)sender {
    [self.rc stopVPN];
}

- (IBAction)createConnection:(id)sender {
    NSString *ip = ipTextBox.stringValue;
    NSString *title = titleTextBox.stringValue;
    
    if (ip.length == 0 || title.length == 0) {
        [self showAllert:@"Ip or title is not specified."];
        return;
    }
    
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

- (void) removeConnectionFromMenu:(NSString*) title {
    int menuIndex = (int)[statusItem.menu indexOfItemWithTitle:title];
    [statusItem.menu removeItemAtIndex:menuIndex];
    [self.tableView reloadData];
}

- (void) saveConnectionsInFile {
    NSString *filepath = [self getConfigPath];
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

- (void) initializeConnectionList {
    NSString *filepath = [self getConfigPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filepath]) {
        self.connectionsList = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
        [self insertAllConnectionsToMenu];
    } else {
        self.connectionsList = [NSMutableArray array];
    }
}

- (void) insertAllConnectionsToMenu {
    for (DDConnection *connection in self.connectionsList) {
        [self insertConnectionToMenu:connection.title];
    }
}

- (NSString *) getConfigPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"ddconfig.plist"];
    
    return filepath;
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
