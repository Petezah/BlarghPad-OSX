//
//  MyWindowController.h
//  Blarghpad
//
//  Created by Pete Dunshee on 1/17/07.
//  Copyright Pete Dunshee 2007 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyWindowController : NSWindowController
{
    IBOutlet NSTabView *tabView;
    IBOutlet NSTextView *textView;
    IBOutlet id window;
	
	int numDocuments;
}
+ (MyWindowController*) instance;
- (void)loadtextViewWithData:(NSData *)data;
- (void)setNumDocuments:(int)num;
- (void)setTabAtIndex:(int)index withDocument:(NSDocument*)doc;
- (void)closeCurrentDocument;

@end
