//
//  MyDocument.m
//  Blarghpad
//
//  Created by Pete Dunshee on 1/16/07.
//  Copyright __MyCompanyName__ 2007 . All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
    
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
    
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];

    if (dataFromFile)
    {
        [self loadtextViewWithData:dataFromFile];
        [dataFromFile release];
        dataFromFile = nil;
    }
    
    [textView setFont: [NSFont userFixedPitchFontOfSize: 12]];
    [textView setAllowsUndo:YES];
}


- (NSData *)dataRepresentationOfType:(NSString *)aType
{
	return [textView RTFFromRange: NSMakeRange(0, [[textView string] length]) ];
}

- (BOOL)loadDataRepresentation:(NSData *)data ofType:(NSString *)aType
{
    if(textView)
    {
        [self loadtextViewWithData:data];
    }
    else
    {
        dataFromFile = [data retain];
    }
    
    return YES;
}

- (void)loadtextViewWithData:(NSData *)data
{
    [textView replaceCharactersInRange:
                            NSMakeRange(0, [[textView string] length])
                            withRTF:data];
}

- (void)setEdited:(BOOL)edited
{
    modified = edited;
    [window setDocumentEdited:edited];
}

- (BOOL)isDocumentEdited
{
    return modified;
}

@end
