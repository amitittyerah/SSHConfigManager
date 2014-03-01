//
//  SSHConfigParser.m
//  Workspace
//
//  Created by Amit on 1/03/2014.
//  Copyright (c) 2014 Amit. All rights reserved.
//

#import "SSHConfigParser.h"

@implementation SSHConfigParser
{
    
}

+ (NSString *) getSSHConfig
{
    return [NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), @".ssh", @"config"];
}

+ (NSArray *) readConfigFileToNSArray
{
    NSArray *sshFileContents = [[NSArray alloc] init];
    
    NSString *filePath = [SSHConfigParser getSSHConfig];
    
    bool sshFileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if(sshFileExists)
    {
        NSString *sshData= [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        sshFileContents = [sshData componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }
    else
    {
        NSLog(@"Error: %@ does not exist", filePath);
    }
    
    return sshFileContents;
}

@end
