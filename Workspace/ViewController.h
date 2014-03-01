//
//  ViewController.h
//  Workspace
//
//  Created by Amit on 1/03/2014.
//  Copyright (c) 2014 Amit. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (assign) IBOutlet NSTableView *tableOutlet;
@property (strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *tableDataFiltered;
@property (nonatomic, weak) NSString *search;
@property (weak) IBOutlet NSButton *openButton;

- (void) setInitalTableData:(NSMutableArray *) data;

@end
