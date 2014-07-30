//
//  DDConnection.m
//  DDVPN
//
//  Created by Timur Yanberdin on 22.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "DDConnection.h"

@interface DDConnection() <NSCoding>

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *ip;

@end


@implementation DDConnection

- (id) initWithTitleString: (NSString *) title
               andIpString: (NSString *) ip {    
    self = [super init];
    self.title = title;
    self.ip = ip;
    
    return self;
}

- (NSString *) getConnectionString {
    return [NSString stringWithFormat:@"/tmp/ibvpn/vpn start %@", self.ip];
}

#pragma mark NSCoding Protocol

- (void)encodeWithCoder:(NSCoder *) encoder {
    [encoder encodeObject:[self title] forKey:@"title"];
    [encoder encodeObject:[self ip] forKey:@"ip"];
}

- (id)initWithCoder:(NSCoder *) decoder {
    self = [super init];
    self.title = [decoder decodeObjectForKey:@"title"];
    self.ip = [decoder decodeObjectForKey:@"ip"];
    
    return self;
}


@end
