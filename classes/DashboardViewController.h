//
//  DashboardViewController.h
//  Gardening
//
//  Created by maesinfo on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerBase.h"
#import "unitControl.h"


@interface DashboardViewController : ViewControllerBase {
	UnitControl     *unit[6];

	UIAlertView *alertDialog;
}


- (IBAction)  goPlants:(id)sender;
- (IBAction)  goMap:(id)sender;
- (IBAction)  goZip:(id)sender;
- (IBAction)  goFavorites:(id)sender;
- (IBAction)  goNote:(id)sender;
- (IBAction)  goInfo:(id)sender;

@end
