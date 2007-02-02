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
				[currentDoc setTabView:tabView withOwner:tab];
				[tabView addTabViewItem: tab];
				[tabView selectTabViewItem: tab];
			}
			else
			{
				[currentDoc setTabView:tabView withOwner: [tabView tabViewItemAtIndex:0] ];
				[[tabView tabViewItemAtIndex:0] setIdentifier: currentDoc];
			}
			
			if ([currentDoc needsNewData])
			{
				// I can't seem to get it to give me a valid empty document any other way
				[textView replaceCharactersInRange:
					NSMakeRange(0, [[textView string] length])
					withString: @""];
				[currentDoc setData: 
					[textView RTFFromRange: NSMakeRange(0, [[textView string] length]) ]
					];			[currentDoc setDocumentIndex: numDocuments];
				//
				
				[currentDoc setNeedsNewData: FALSE];
			}
			
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
	[mydoc setTabView:tabView withOwner:tab];
}

- (void)closeCurrentDocument
{
	NSTabViewItem *pTab = [tabView selectedTabViewItem];
	MyDocument *pDoc = (MyDocument*)[pTab identifier];

	// this will do the necessary logic to ask the user
	// if the document should be saved, etc, before closing
	[pDoc canCloseDocumentWithDelegate:self
		shouldCloseSelector:@selector(document:shouldClose:contextInfo:)
		contextInfo:NULL];
}

// this will be called due to (void)closeCurrentDocument;
// if the user said it was okay to close the document, shouldClose will be YES
- (void) document:(NSDocument*)doc shouldClose:(BOOL)shouldClose contextInfo:(void*)contextInfo
{
	if (YES == shouldClose) 
	{
		MyDocument* mydoc = (MyDocument*)doc;
		NSTabViewItem* pTab = [mydoc getTabOwner];
		[doc close];
		[tabView removeTabViewItem: pTab];
	}
}

- (void)syncDocumentWithCurrent: (NSDocument*)doc;
{
	if ([self document] == doc) // if they are the same document
	{
		// get the contents of the textView into the document
		MyDocument* currentDoc = (MyDocument*)[self document];
		[currentDoc setData: 
				[textView RTFFromRange: NSMakeRange(0, [[textView string] length]) ]
				];

	}
}

// delegate methods
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
	MyDocument *mydoc = [tabViewItem identifier];
	[mydoc addWindowController: self];
}

- (void)textDidChange:(NSNotification *)aNotification
{
	MyDocument* mydoc = (MyDocument*)[self document];

	[mydoc setEdited: YES];
}

/*
- (BOOL)windowShouldClose:(id)sender
{

}
*/

@end
