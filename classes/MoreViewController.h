//
//  MoreViewController.h
//  Gardening
//
//  Created by maesinfo on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerBase.h"
#import "aboutViewController.h"
#import "helpViewController.h"
#import "DonateViewController.h"


@interface MoreViewController : ViewControllerBase {
	aboutViewController  *aboutController;
	helpViewController   *helpController;
	DonateViewController *donateController;
	
	UIButton  *buttonZone;
	UIButton  *buttonFeedback;
}


-(void) dealloc;

- (IBAction)goAbout:(id)sender;
- (IBAction)goHelp:(id)sender;
- (IBAction)goDonate:(id)sender;

@end
