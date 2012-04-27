//
//  ViewControllerBase.m
//  Gardening
//
//  Created by maesinfo on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerBase.h"
#import "Configuration.h"
#import "GardeningAppDelegate.h"


@implementation ViewControllerBase
@synthesize  navController;
@synthesize  colorText;
@synthesize  colorBackground;


- (void) initNavigation
{
	
}

- (void) viewWillAppear:(BOOL)animated
{

	if(navController)
	{
		if(navController.visibleViewController == self)
			[navController setNavigationBarHidden:YES animated:NO];
	}
	[super viewWillAppear:animated];
	
}


- (void) addUIObject:(UIView*)obj
{
	if(nil == uiArray)
		uiArray = [[NSMutableArray alloc] init];
	
	[uiArray addObject:obj];
}

- (void) freeUIArray
{
	if(uiArray)
	{
		while([uiArray count] >0)
		{
			UIView *ctrl = (UIView*)[uiArray objectAtIndex:0];
			[uiArray removeObjectAtIndex:0];
			
			NSLog(@"ViewControllerBase: ctrl retain:%d",[ctrl retainCount]);
			SAFE_RELEASE(ctrl);
		}
		SAFE_RELEASE(uiArray);
	}
}


- (void) willLoadView
{
	bShowToolbar = FALSE;
//	bgWhite = 0.9f;
	
	colorText = [[UIColor alloc]initWithRed:0.13f green:0.40f blue:0.10f alpha:1.0f];
//	[colorText retain];
	colorBackground = [[UIColor alloc]initWithWhite:0.95f alpha:1.0f];
}

- (void) initLogo:(float)x :(float)y
{
//	UILabel *label = [[UILabel alloc] initWithFrame:frame];
//	label.text = @"Bee Smart";
//	label.textAlignment      =  UITextAlignmentCenter; 
//	label.font = [UIFont italicSystemFontOfSize:14.0f];
//	label.backgroundColor = colorBackground;
//	[self.view addSubview:label];
//	[label release];
//

	UIView*  headerBack = [[UIView alloc]initWithFrame:CGRectMake(0,1,SCREEN_WIDTH,startY-2)];
	headerBack.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0f];
	[self.view addSubview:headerBack];
	UIView*  headerBack2 = [[UIView alloc]initWithFrame:CGRectMake(0,startY-1,SCREEN_WIDTH,1)];
	headerBack2.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
	[self.view addSubview:headerBack2];
	UIView*  headerBack3 = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,1)];
	headerBack3.backgroundColor = [UIColor colorWithWhite:0.88f alpha:1.0f];
	[self.view addSubview:headerBack3];
	//	[headerBack release];

	float offset = 4;
	float width = 133;
	float height= 24;
	CGRect frame = CGRectMake(x, y, width, height);
//	frame = CGRectMake(frame.origin.x + frame.size.width + offset*2, y, width, height);
	frame = CGRectMake(x, y, width, height);

	UIImageView*   bee = [[UIImageView alloc]initWithFrame:frame];
	bee.image = [UIImage imageNamed:@"logo_beesmart_small.png"];
	[self.view addSubview:bee];

	frame = CGRectMake(SCREEN_WIDTH -50, offset, startY-offset*2, startY-offset*2);
	UIButton* dashboard = [[UIButton alloc]initWithFrame:frame];
	[dashboard setImage:[UIImage imageNamed:@"home_default.png"] forState:UIControlStateNormal];
	[dashboard addTarget:self action:@selector(showDashboard:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:dashboard];


	[headerBack release];
	[headerBack2 release] ;
	[headerBack3 release];
	[bee release];
	[dashboard release];
}


- (void) initHeader
{
	startY += 44.0f;
	[self initLogo:10.0f :10.0f];
}


- (void) loadView
{
	screen_rate = SCREEN_WIDTH/320.0f +0.01;

	[self willLoadView];
	[super loadView];

	[self initHeader];
	[self  initNavigation];

	self.view.backgroundColor = colorBackground; //[UIColor colorWithWhite:bgWhite alpha:1.0f];

	CGRect frame = self.view.frame;
	frame.origin.y -= STATUS_BAR_HEIGHT;
	if(bShowToolbar)
	{
		frame.size.height -= TOOLBAR_HEIGHT;
	}
	self.view.frame = frame;
	
//	if(bShowToolbar)
//	{
//		GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//		[self.view addSubview:delegate.toolbarView];
//	}
}


-(void) showView:(ViewControllerBase*)controller
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	[controller viewWillDisappear: YES];
	[self viewWillAppear: YES];
	[controller.view removeFromSuperview];
	[delegate.mainView addSubview: self.view];
	[controller viewDidDisappear: YES];
	[self viewDidAppear: YES];

	if(navController)
	{
		[controller viewWillDisappear: YES];
		[navController viewWillAppear: YES];
		[controller.view removeFromSuperview];
		[delegate.mainView addSubview: navController.view];
		[controller viewDidDisappear: YES];
		[navController viewDidAppear: YES];
	}

	delegate.currentController = (ViewControllerBase*)self;

//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIVie+wAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:controller];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//	[UIView commitAnimations];
}


//- (void) goNavigationController:(UINavigationController*)nav controller:(ViewControllerBase*)controller
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
//	//	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:delegate.mainView cache:YES];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//	[self viewWillDisappear: YES];
//	[nav viewWillAppear: YES];
//	
//	[self.view removeFromSuperview];
//	
//	[delegate.mainView addSubview: nav.view];
//	
//	//	[delegate.viewStack push: self];
//	
//	[self viewDidDisappear: YES];
//	[nav viewDidAppear: YES];
//	
//	[UIView commitAnimations];
//	
//	delegate.currentController = (ViewControllerBase*)self;
//	
//}

//-(void) goDetailShow{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//	[self viewWillDisappear: YES];
//	[delegate.detailShowViewController viewWillAppear: YES];
//	
//	[self.view removeFromSuperview];
//	[delegate.mainView addSubview: delegate.detailShowViewController.view];
////	[delegate.viewStack push: self];
//	[self viewDidDisappear: YES];
//	[delegate.detailShowViewController viewDidAppear: YES];
//	[UIView commitAnimations];
//	
//	delegate.currentController = (ViewControllerBase*)delegate.detailShowViewController;
//}
//
//
//-(void) goBrowseView{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//	[self viewWillDisappear: YES];
//	[delegate.browseViewController viewWillAppear: YES];
//	
//	[self.view removeFromSuperview];
//	[delegate.mainView addSubview: delegate.browseViewController.view];
//	//[delegate.viewStack push: self];
//	[self viewDidDisappear: YES];
//	[delegate.browseViewController viewDidAppear: YES];
//	[UIView commitAnimations];
//
//	delegate.currentController = (ViewControllerBase*)delegate.browseViewController;
//
//	[delegate.currentController goNavigationController:delegate.browseViewController.browseNav 
//											controller:delegate.browseViewController];/*delegate.searchNav]*/;
//	
//	//[delegate.currentController setState];
//}
//
//-(void) goSearchView{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//	[self viewWillDisappear: YES];
//	[delegate.searchViewController viewWillAppear: YES];
//
//	[self.view removeFromSuperview];
//	[delegate.mainView addSubview: delegate.searchViewController.view];
////	[delegate.viewStack push: self];
//	[self viewDidDisappear: YES];
//	[delegate.searchViewController viewDidAppear: YES];
//	[UIView commitAnimations];
//
//	delegate.currentController = (ViewControllerBase*)delegate.searchViewController;
//
//	[delegate.currentController goNavigationController:delegate.searchViewController.searchNav 
//													controller:delegate.searchViewController];/*delegate.searchNav]*/;
//
//}
//-(void) goFavoriteView{
//}
//-(void) goMoreView{
//}

- (void) setUserInteractivityEnableForAllView:(BOOL) enable
{
	for(UIView* subView in self.view.subviews)
	{
		[subView setUserInteractionEnabled:enable];
	}
	[self.view setUserInteractionEnabled:enable];
}

//- (void) goNextViewController:(UIViewController*) controller
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
////	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:delegate.mainView cache:YES];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//	[self viewWillDisappear: YES];
//	[controller viewWillAppear: YES];
//
//	[self.view removeFromSuperview];
//	
//	[delegate.mainView addSubview: controller.view];
//	
////	[delegate.viewStack push: self];
//	
//	[self viewDidDisappear: YES];
//	[controller viewDidAppear: YES];
//	
//	[UIView commitAnimations];
//	
//	delegate.currentController = (ViewControllerBase*)controller;
//
////	[delegate.currentController setState];
///*	[delegate.toolbarView buttonEnable:0];
//	[delegate.toolbarView buttonEnable:1];
//	[delegate.toolbarView buttonEnable:2];
//	[delegate.toolbarView buttonEnable:3];*/
//}

//-(void) setState{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//
//	[delegate.toolbarView buttonEnable:0];
//	[delegate.toolbarView buttonEnable:1];
//	[delegate.toolbarView buttonEnable:2];
//	[delegate.toolbarView buttonEnable:3];
//}

//- (void) backpreviousViewController
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//
//		ViewControllerBase* previous;// = [delegate.viewStack pop];
//	UIViewController* previousController = [previous getActualController];
//
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
//	//[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:delegate.mainView cache:YES];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//
//	[self viewWillDisappear: YES];
//	[previousController viewWillAppear: YES];
//	
//	[self.view removeFromSuperview];
//	
//	[delegate.mainView addSubview: previousController.view];
//	
//	[self viewDidDisappear: YES];
//	[previousController viewDidAppear: YES];
//	[UIView commitAnimations];
//	
//	delegate.currentController = (ViewControllerBase*)previous;
//	
//	[previous setState];
//}
//
//- (void) backMainView
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
//	
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[UIView beginAnimations:ANIMIID_FOR_VIEW_TRANFORM context:context];
//	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:delegate.mainView cache:YES];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//	
//	[self viewWillDisappear: YES];
//	[delegate.browseViewController viewWillAppear: YES];
//	
//	[self.view removeFromSuperview];
//	
//	[delegate.mainView addSubview: delegate.browseViewController.view];
//	
//	[self viewDidDisappear: YES];
//	[delegate.browseViewController viewDidAppear: YES];
//	[UIView commitAnimations];
//
//	delegate.currentController = (ViewControllerBase*)delegate.browseViewController;
//
////	[delegate.viewStack clear];
//	
//	[delegate.browseViewController setState];
//}



- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
{
	if([finished boolValue] && [animationID isEqualToString : ANIMIID_FOR_VIEW_TRANFORM])
	{
		[self setUserInteractivityEnableForAllView: YES];
	}
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (void)viewDidUnload {
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}


- (void)dealloc {
	
	[self freeUIArray];

	SAFE_RELEASE(colorText);
	SAFE_RELEASE(colorBackground);

	if(navController)
	{
		[navController release];
	}
	
    [super dealloc];
}


- (void) setFavoirte:(NSString*)strKeyName :(BOOL)bFavoirte
{
	if(nil == strKeyName || [strKeyName length] == 0)
	{
		return ;
	}
	
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(bFavoirte)
	{
		if(! isStringInArray(strKeyName, delegate.favoriteArray))
		{
			[delegate.favoriteArray addObject:strKeyName];
		}
	}
	else {
		removeInArrayByText(delegate.favoriteArray, strKeyName );
	}

	[delegate archive:ARCHIVE_FAVORITE];
}


- (IBAction) showDashboard:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.dashboardController)
	{
		DashboardViewController *controller = [[DashboardViewController alloc] init];
		delegate.dashboardController = controller;
		[controller release];
	}
	[delegate.dashboardController showView:delegate.currentController];
}

@end
