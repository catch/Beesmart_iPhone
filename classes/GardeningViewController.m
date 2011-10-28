//
//  GardeningViewController.m
//  Gardening
//
//  Created by maesinfo on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GardeningViewController.h"
#import "GardeningAppDelegate.h"

@implementation GardeningViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {


//	[self.view removeFromSuperview];

	//get application delegate
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];


	//***********init main_menu view, 4 buttons,toolBar,Picture ********************//
	//init main view
/*	UIView* tmpMainView = [[UIView alloc]initWithFrame:
						   CGRectMake(MAIN_MENU_VIEW_POINT_X, STATUS_BAR_HEIGHT, SCREEN_WIDTH, MAIN_VIEW_HEIGHT - TOOLBAR_HEIGHT)];
	delegate.mainView = tmpMainView;
	[tmpMainView release];
	[delegate.window addSubview:delegate.mainView];
	
	//init main menu view
	MainMenuViewController* mainMenu = [[MainMenuViewController alloc] init];
	delegate.mainMenuViewController = mainMenu;
	delegate.currentController = mainMenu;
	[mainMenu release];
	[delegate.mainView addSubview:delegate.mainMenuViewController.view];
*/	
	
	
	//[super viewDidLoad];
}



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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
