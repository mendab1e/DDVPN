//
//  DDRouterLink.m
//  DDVPN
//
//  Created by Timur Yanberdin on 27.07.14.
//  Copyright (c) 2014 Timur Yanberdin. All rights reserved.
//

#import "RouterConnector.h"

@implementation RouterConnector

- (id)initWithIpString:(NSString *)ip
        andLoginString:(NSString *)login
     andPasswordString:(NSString *)password {
    self = [super init];
    self.ip = ip;
    self.login = login;
    self.password = password;
    
    return self;
}

- (void) switchVPN:(DDConnection *)newDDConnection {
    NMSSHSession *session = [self connectViaSSH];
    NSError *error = nil;
    NSString *response = [session.channel execute:[newDDConnection getConnectionString]
                                            error:&error];
    if (error == nil || error.code == 0) {
        NSLog(@"VPN is switched to %@. %@", newDDConnection.ip, response);
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"Error: %ld", (long)error.code];
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:errorMessage];
        [alert runModal];
        alert = nil;
    }
    
    [session disconnect];
}

- (void) stopVPN {
    [self connectViaSSH];
    NMSSHSession *session = [self connectViaSSH];
    NSError *error = nil;
    NSString *response = [session.channel execute:@"/tmp/ibvpn/vpn stop"
                                            error:&error];
    if (error == nil || error.code == 0) {
        NSLog(@"Disconnected from VPN. %@", response);
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"Error: %ld", (long)error.code];
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:errorMessage];
        [alert runModal];
        alert = nil;
    }
    
    [session disconnect];
}

- (NMSSHSession *) connectViaSSH {
    NSLog(@"Connectiong to %@", self.ip);
    NMSSHSession *session = [NMSSHSession connectToHost:self.ip
                                           withUsername:self.login];
    
    if (session.isConnected) {
        [session authenticateByPassword:self.password];
        
        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
            return session;
        }
    }
    
    return nil;
}


@end
