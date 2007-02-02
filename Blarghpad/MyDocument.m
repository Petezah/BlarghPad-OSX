//
//  MyDocument.m
//  Blarghpad
//
//  Created by Pete Dunshee on 1/16/07.
//  Copyright Pete Dunshee 2007 . All rights reserved.
//

#import "MyDocument.h"
#import "MyWindowController.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) 
	{
    
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
		

		needsNewTab = TRUE;    
		needsNewData = TRUE;
    }
    return self;
}

- (void)makeWindowControllers
{
	MyWindowController *controller = [MyWindowController instance];
	[self addWindowController: controller];
}


- (NSData *)dataRepresentationOfType:(NSString *)aType
{
	// sync the document, if this one is the current one
	[[MyWindowController instance] syncDocumentWithCurrent: self];
	[self setEdited: NO];

	return dataFromFile;
}

- (BOOL)loadDataRepresentation:(NSData *)data ofType:(NSString *)aType
{
	dataFromFile = [data retain];
	needsNewData = FALSE;
    
    return YES;
}

- (void)setData:(NSData *)data
{
	dataFromFile = [data retain];
}

- (NSData *)getData
{
	return dataFromFile;
}

- (void)setEdited:(BOOL)edited
{
	[[MyWindowController instance] setDocumentEdited: edited];
    modified = edited;
}

- (BOOL)isDocumentEdited
{
    return modified;
}

- (void)setDocumentIndex:(int)index
{
	documentIndex = index;
}

- (int)getDocumentIndex
{
	return documentIndex;
}

- (void)setNeedsNewTab:(BOOL)state
{
	needsNewTab = state;
}

- (BOOL)needsNewTab
{
	return needsNewTab;
}

- (void)setNeedsNewData:(BOOL)state
{
	needsNewData = state;
}

- (BOOL)needsNewData
{
	return needsNewData;
}

- (void)setTabView:(NSTabView*)view withOwner:(NSTabViewItem*)owner
{
	tabView = view;
	tabOwner = owner;
}

- (NSTabViewItem*)getTabOwner
{
	return tabOwner;
}

- (void)close
{
	MyWindowController *controller = [MyWindowController instance];
	[self removeWindowController: controller];
	
	[super close];
}

@end
