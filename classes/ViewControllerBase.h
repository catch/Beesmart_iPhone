//
//  ViewControllerBase.h
//  Gardening
//
//  Created by maesinfo on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuration.h"


@interface ViewControllerBase :  UIViewController{
	UINavigationController    *navController;

	BOOL   bShowToolbar;
	float  startY;
//	float          bgWhite;
	
	UIColor  *colorText;
	UIColor  *colorBackground;
	NSUInteger  screen_rate;

	//memory control
	NSAutoreleasePool *memPool;
	// UIView controls
	NSMutableArray  *uiArray;
}

@property  (nonatomic, retain)  UINavigationController   *navController;
@property  (nonatomic, readonly) UIColor  *colorText;
@property  (nonatomic, readonly) UIColor  *colorBackground;


- (void) willLoadView;
- (void) initHeader;
- (void) initLogo:(float)x :(float)y;
- (void) showView:(ViewControllerBase*)controller;

///////////////// for subclass: implement optionally ///////////////
- (void) initNavigation;
///////////////// for subclass: implement optionally ///////////////

- (void) setFavoirte:(NSString*)strKeyName :(BOOL)bFavoirte;

/*set view and all subviews enable to usr interactivity or not */
- (void) setUserInteractivityEnableForAllView:(BOOL) enable;
/*view tranfrom animation did stop callback function*/
- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;


- (IBAction) showDashboard:(id)sender;



- (void) addUIObject:(UIView*)obj;
- (void) freeUIArray;


/*go next view controller*/
//- (void) goNextViewController:(UIViewController*) controller;
//- (void) goNavigationController:(UINavigationController*)nav controller:(ViewControllerBase*)controller;

/*back previous view controller*/
//- (void) backpreviousViewController;
//
///*go back main view*/
//- (void) backMainView;

/* set state , such as button state... */
//-(void) setState;

//- (void) show;

//-(void) goBrowseView;
//-(void) goSearchView;
//-(void) goFavoriteView;
//-(void) goMoreView;
//
//// 
//-(void) goDetailShow;

@end
