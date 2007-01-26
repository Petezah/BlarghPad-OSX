//
//  MyDocumentController.h
//  Blarghpad
//
//  Created by Pete Dunshee on 1/25/07.
//  Copyright Pete Dunshee 2007 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyDocumentController : NSDocumentController
{
}
- (IBAction)closeDocument:(id)sender;
- (IBAction)showPreferences:(id)sender;
@end
