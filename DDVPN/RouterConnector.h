//
//  DDRouterLink.h
//  DDVPN
//
//  Created by Timur Yanberdin on 27.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDConnection.h"

@interface RouterConnector : NSObject

@property (strong) NSString *ip;
@property (strong) NSString *login;
@property (strong) NSString *password;

- (id)initWithIpString: (NSString *) ip
        andLoginString: (NSString *) login
     andPasswordString: (NSString *) password;

- (void)switchVPN: (DDConnection *) newDDConnection;
- (void)stopVPN;

@end
