//
//  startViewController.h
//  Gardening
//
//  Created by maesinfo on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerBase.h"

enum  {
	ZIPCODE_INIT = 0,
	ZIPCODE_EDIT,
};


@interface ZipViewController : ViewControllerBase <UITextFieldDelegate> {
	UIButton     *returnButton;
	UITextField  *zipInput;
//	UILabel  *zoneLabel;
	UIButton *ensureButton;
	UIControl *bgView;
	
	BOOL  bCorrectZip;

	NSUInteger       currentMode;
}

- (void) setMode:(NSUInteger)mode;


-(void) dealloc;

-(IBAction) hideKeyboard:(id)sender;
-(IBAction) onValueChanged:(id) sender;
//-(IBAction) goDashboard:(id)sender;
- (IBAction)keyboardDidHide:(NSNotification *)note;

@end
