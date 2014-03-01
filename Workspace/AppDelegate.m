//
//  AppDelegate.m
//  Workspace
//
//  Created by Amit on 1/03/2014.
//  Copyright (c) 2014 Amit. All rights reserved.
//

#import "AppDelegate.h"
#import "SSHConfigParser.h"
#import "SSHConfigItem.h"
#import "ViewController.h"


@interface AppDelegate()
@property (nonatomic,strong) IBOutlet ViewController *viewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    NSArray *configContents = [SSHConfigParser readConfigFileToNSArray];
    [self.viewController setInitalTableData:[SSHConfigItem getSSHConfigItemObjects:configContents]];
    
    [self.window.contentView addSubview:self.viewController.view];
    self.viewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end
