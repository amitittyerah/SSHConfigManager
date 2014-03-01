//
//  SSHConfigItem.m
//  Workspace
//
//  Created by Amit on 1/03/2014.
//  Copyright (c) 2014 Amit. All rights reserved.
//

#import "SSHConfigItem.h"

@implementation SSHConfigItem

+ (SSHConfigItem *) parse:(NSMutableArray *)sshConfigLines
{
    SSHConfigItem *newSSHConfigItem = [SSHConfigItem alloc];
    for (NSString *item in sshConfigLines)
    {
        //NSLog(@"%@", item);
        if([item length] > 5 && [[item substringToIndex:5] isEqual: @"Host "])
        {
            newSSHConfigItem.host = item;
            //NSLog(@">>Adding to host");
        }
        else if([item length] > 5 && [[item substringToIndex:5] isEqual: @"User "])
        {
            newSSHConfigItem.user = item;
            //NSLog(@">>Adding to user");
        }
        else if([item length] > 9 && [[item substringToIndex:9] isEqual: @"Hostname "])
        {
            newSSHConfigItem.hostname = item;
            //NSLog(@">>Adding to hostname");
        }
        else if([item length] > 25 && [[item substringToIndex:15] isEqual: @"PreferredAuthentications "])
        {
            newSSHConfigItem.preferredAuthentications = item;
            //NSLog(@">>Adding to preferredAuthentications");
        }
        else if([item length] > 13 && [[item substringToIndex:13] isEqual: @"IdentityFile "])
        {
            newSSHConfigItem.identityFile = item;
            //NSLog(@">>Adding to identityFile");
        }
        else if([item length] > 5 && [[item substringToIndex:5] isEqual: @"Port "])
        {
            newSSHConfigItem.port = item;
            //NSLog(@">>Adding to port");
        }
        else if([item length] > 12 && [[item substringToIndex:12] isEqual: @"ProxyCommand "])
        {
            newSSHConfigItem.proxyCommand = item;
            //NSLog(@">>Adding to proxyCommand");
        }
        else if([item length] > 12 && [[item substringToIndex:12] isEqual: @"ForwardAgent "])
        {
            newSSHConfigItem.forwardAgent = item;
            //NSLog(@">>Adding to forwardAgent");
        }
        
    }
    //NSLog(@"Returning new config item");
    return newSSHConfigItem;
}

+ (NSMutableArray *) getSSHConfigItemObjects: (NSArray *) sshConfigParseResult
{
    NSMutableArray *sshConfigItems = [[NSMutableArray alloc] init];
    NSMutableArray *sshLines = [[NSMutableArray alloc] init];
    for (NSString *item in sshConfigParseResult)
    {
        //NSLog(@"%@", item);
        if([item length] > 5)
        {
            //NSLog(@"Item is greater than 5 characters");
            if ([[item substringToIndex:5] isEqual: @"Host "])
            {
                //NSLog(@"Starting to create a new array");
                if([sshLines count] > 0)
                {
                    //NSLog(@"Pushing the last array to be parsed");
                    [sshConfigItems addObject:[SSHConfigItem parse:sshLines]];
                }
                
                sshLines = [[NSMutableArray alloc] init];
            }
            
            
            [sshLines addObject:[item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        }
    }
    if([sshLines count] > 0)
    {
        [sshConfigItems addObject:[SSHConfigItem parse:sshLines]];
    }
    return sshConfigItems;
}

- (NSString *) getSSHCommandForSSHConfigItem
{
    NSArray *componentsOfTheHost = [self.host componentsSeparatedByString:@" "];
    return [componentsOfTheHost objectAtIndex:1];
}



@end
