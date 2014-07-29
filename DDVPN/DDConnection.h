//
//  DDConnection.h
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDConnection : NSObject

- (NSString *)title;
- (NSString *)ip;

- (id) initWithTitleString: (NSString *) title
               andIpString: (NSString*) ip;
- (NSString *) getConnectionString;

@end
