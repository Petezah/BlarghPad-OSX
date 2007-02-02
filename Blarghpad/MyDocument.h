//
//  MyDocument.h
//  Blarghpad
//
//  Created by Pete Dunshee on 1/16/07.
//  Copyright Pete Dunshee 2007 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	IBOutlet id window;
    
    BOOL modified;
	BOOL needsNewTab;
	BOOL needsNewData;
    
    NSData *dataFromFile;
	NSTabView	  *tabView;
	NSTabViewItem *tabOwner;
	int documentIndex;
}
- (void)setEdited:(BOOL)edited;
- (void)setData:(NSData *)data;
- (NSData *)getData;
- (void)setDocumentIndex:(int)index;
- (int)getDocumentIndex;
- (void)setNeedsNewTab:(BOOL)state;
- (BOOL)needsNewTab;
- (void)setNeedsNewData:(BOOL)state;
- (BOOL)needsNewData;
- (void)setTabView:(NSTabView*)view withOwner:(NSTabViewItem*)owner;
- (NSTabViewItem*)getTabOwner;

@end
