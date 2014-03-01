//
//  SSHConfigItem.h
//  Workspace
//
//  Created by Amit on 1/03/2014.
//  Copyright (c) 2014 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSHConfigItem : NSObject
{
    
}

@property NSString *host;
@property NSString *user;
@property NSString *hostname;
@property NSString *preferredAuthentications;
@property NSString *identityFile;
@property NSString *port;
@property NSString *proxyCommand;
@property NSString *forwardAgent;

- (NSString *) getSSHCommandForSSHConfigItem;
+ (NSMutableArray *) getSSHConfigItemObjects: (NSArray *) sshConfigParseResult;

@end
