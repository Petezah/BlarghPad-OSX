/* MyDocument */

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
    IBOutlet NSTextView *textView;
	IBOutlet id window;
    
    BOOL modified;
    
    NSData *dataFromFile;
}
- (void)loadtextViewWithData:(NSData *)data;

@end
