//
//  MyDocumentController.m
//  Blarghpad
//
//  Created by Pete Dunshee on 1/25/07.
//  Copyright Pete Dunshee 2007 . All rights reserved.
//

#import "MyDocumentController.h"
#import "MyWindowController.h"

@implementation MyDocumentController

- (IBAction)closeDocument:(id)sender
{
	[[MyWindowController instance] closeCurrentDocument];
}

- (IBAction)showPreferences:(id)sender
{
}

@end
