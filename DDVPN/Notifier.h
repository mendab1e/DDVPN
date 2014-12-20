//
//  Notifier.h
//  DDVPN
//
//  Created by Timur Yanberdin on 20/12/14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDConnection.h"

@interface Notifier : NSObject

- (void) notifyOnSwitch: (DDConnection *) connection;
- (void) notifyOnStop;

@end
