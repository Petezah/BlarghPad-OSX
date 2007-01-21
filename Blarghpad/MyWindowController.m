//
//  MyWindowController.m
//  Blarghpad
//
//  Created by Pete Dunshee on 1/17/07.
//  Copyright Pete Dunshee 2007 . All rights reserved.
//

#import "MyDocument.h"
#import "MyWindowController.h"

@implementation MyWindowController

static MyWindowController *windowControllerInstance = nil;

+ (MyWindowController*) instance
{
	if (!windowControllerInstance)
	{
		windowControllerInstance = [MyWindowController alloc];
		[windowControllerInstance initWithWindowNibName: @"MyDocument"];
		[windowControllerInstance setNumDocuments: 0];
	}
	
	return windowControllerInstance;
}

- (void)setNumDocuments:(int)num
{
	numDocuments = num;
}

- (void)setDocument:(NSDocument *)document
{
	if (document)
	{
		MyDocument* currentDoc = [self document];

		if (currentDoc)
		{
			//file away the contents of the window into the current document, 
			[currentDoc setData: 
				[textView RTFFromRange: NSMakeRange(0, [[textView string] length]) ]
				];
		}
		 
		//call super,
		[super setDocument:document]; 
		
		//and then load the contents of the window with the new document.
		currentDoc = [self document];
		[self loadtextViewWithData: 
			[currentDoc getData]
			];
			
				
		if ([currentDoc needsNewTab])
		{
			if (numDocuments > 0)
			{
				NSTabViewItem *tab = [[NSTabViewItem alloc] init];
				[tab setLabel:[currentDoc displayName]];
				[tab setView: [[tabView tabViewItemAtIndex:0] view]];
				[tab setIdentifier: currentDoc];
				[tabView addTabViewItem: tab];
				[tabView selectTabViewItem: tab];
			}
			else
			{
				[[tabView tabViewItemAtIndex:0] setIdentifier: currentDoc];
			}
			
			// I can't seem to get it to give me a valid empty document any other way
			[textView replaceCharactersInRange:
				NSMakeRange(0, [[textView string] length])
				withString: @""];
			[currentDoc setData: 
				[textView RTFFromRange: NSMakeRange(0, [[textView string] length]) ]
				];			[currentDoc setDocumentIndex: numDocuments];
			//
			
			// already created a tab for this document
			[currentDoc setNeedsNewTab:FALSE];
			numDocuments ++;
		}
	}
}

- (void)windowDidLoad
{
	MyDocument* mydoc = [self document];
	[self setTabAtIndex:[mydoc getDocumentIndex] withDocument:mydoc];
}

- (void)loadtextViewWithData:(NSData *)data
{
    [textView replaceCharactersInRange:
                            NSMakeRange(0, [[textView string] length])
                            withRTF:data];
}

- (void)setTabAtIndex:(int)index withDocument:(NSDocument*)doc;
{
	MyDocument* mydoc = (MyDocument*)doc;
	NSTabViewItem *tab = [tabView tabViewItemAtIndex: 0];
	[tab setIdentifier:mydoc];
	[tab setLabel:[mydoc displayName] ];
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
	MyDocument *mydoc = [tabViewItem identifier];
	[mydoc addWindowController: self];
}

@end
