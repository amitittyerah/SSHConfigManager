//
//  ViewController.m
//  Workspace
//
//  Created by Amit on 1/03/2014.
//  Copyright (c) 2014 Amit. All rights reserved.
//

#import "ViewController.h"
#import "SSHConfigItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void) setInitalTableData:(NSMutableArray *) data
{
    _tableData = data;
    _tableDataFiltered = data;
}

- (void)awakeFromNib {
    _search = @"";
    [_tableOutlet setTarget:self];
    [_tableOutlet setDoubleAction:@selector(doubleClick:)];
    [_openButton setTarget:self];
    [_openButton setAcceptsTouchEvents:YES];
    [_openButton setAction:@selector(openButtonClicked:)];
    [self.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
}

- (void)filterData
{
    _tableDataFiltered = [[NSMutableArray alloc] init];
    if([_search length] == 0)
    {
        _tableDataFiltered = _tableData;
    }
    else
    {
        for (SSHConfigItem *item in _tableData)
        {
            if ([item.host rangeOfString:_search].location != NSNotFound ||
                [item.hostname rangeOfString:_search].location != NSNotFound ||
                [item.identityFile rangeOfString:_search].location != NSNotFound)
            {
                [_tableDataFiltered addObject:item];
            }
        }
    }
    
}

- (void) openTerminal:(NSInteger)position
{
    SSHConfigItem *sshConfigItem = [_tableDataFiltered objectAtIndex:position];
    
    NSAppleScript *run = [[NSAppleScript alloc] initWithSource:[NSString
                                                                stringWithFormat:@"tell application \"Terminal\" to do script \"ssh %@\"", [sshConfigItem getSSHCommandForSSHConfigItem]]];
	[run executeAndReturnError:nil];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.tableDataFiltered count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex
{
    SSHConfigItem *sshConfigItem = [_tableDataFiltered objectAtIndex:rowIndex];
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if ([tableColumn.identifier isEqualToString:@"Host"])
    {
        cellView.textField.stringValue = [NSString stringWithFormat:@"%@",sshConfigItem.host];
    }
    else if([tableColumn.identifier isEqualToString:@"Hostname"])
    {
        cellView.textField.stringValue = [NSString stringWithFormat:@"%@",sshConfigItem.hostname];
    }
    else
    {
        cellView.textField.stringValue = [NSString stringWithFormat:@"%@",sshConfigItem.identityFile];
    }
    
    return cellView;
}

- (void)doubleClick:(id)object {

    NSInteger rowNumber = [_tableOutlet clickedRow];
    [self openTerminal:rowNumber];
    
}

- (void)openButtonClicked:(id)object
{
    NSIndexSet *selected = [_tableOutlet selectedRowIndexes];
    NSUInteger currentIndex = [selected firstIndex];
    while (currentIndex != NSNotFound) {
        [self openTerminal:(int)currentIndex];
        currentIndex = [selected indexGreaterThanIndex: currentIndex];
    }
}

- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];
    _search = [textField stringValue];
    [self filterData];
    [_tableOutlet reloadData];
}

@end
