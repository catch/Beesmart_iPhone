//
//  zoneViewController.h
//  Gardening
//
//  Created by maesinfo on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerBase.h"

@interface ZoneViewController : ViewControllerBase {

	UITextField  *zipInput;
	UILabel  *zoneLabel;
	UIButton *ensureButton;
}

-(void) viewDidLoad;
-(void) dealloc;

-(IBAction) hideKeyboard:(id)sender;
-(IBAction) goZone:(id)sender;

@end
