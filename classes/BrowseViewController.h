//
//  MainMenuViewController.h
//  Gardening
//
//  Created by maesinfo on 11-8-2.
//  Copyright 2011 MaesInfo Corporation. All rights reserved.
//

#import "ViewControllerBase.h"
#import "BrowseTableViewController.h"



#define COUNT_OF_HEADER_BUTTONS 6

@interface BrowseViewController : BrowseTableViewController
{
//	UISegmentedControl  *segmentCtrl;
	UIButton    *buttons[6];

	float    segRed;
	float    segGreen;
	float    segBlue;
//	UINavigationController *navBrowse;
//	NSDictionary  *resDictionary;


}

//@property (nonatomic, retain) UISegmentedControl* segmentCtrl;
//@property (nonatomic, retain) UINavigationController *navBrowse;

- (void) initHeaderButtons;

// Google Fusion access

// UI operations
- (IBAction) onSelectSegmented: (id) sender;


/*
- (void) dinnerButtonPush: (id) sender;
- (void) snakeButtonPush: (id) sender;
- (void) hotpotButtonPush: (id) sender;
- (void) otherButtonPush: (id) sender;
*/
//- (void) becomeBigAnimation:(UIButton*) view selector:(SEL)selector animiID:(NSString*) animiID;
//- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
//- (void) restoreButtonAndAnimation:(UIView*) view;
//
//- (void) forwardNextView;

//- (void) setUserInteractivityEnableForAllView:(BOOL) enable;

//-(void) picturePush:(int) index;


@end
