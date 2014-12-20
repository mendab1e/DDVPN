//
//  Notifier.m
//  DDVPN
//
//  Created by Timur Yanberdin on 20/12/14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "Notifier.h"

@implementation Notifier

- (void) notifyOnSwitch: (DDConnection *) connection {
    [self notify:@"VPN is connected" andInfromation:connection.ip];
}

- (void) notifyOnStop {
    [self notify:@"VPN is disconnected" andInfromation:@""];
}


- (void) notify:(NSString *) title
 andInfromation:(NSString *) information {
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = title;
    notification.informativeText = information;
    notification.soundName = NSUserNotificationDefaultSoundName;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

@end
