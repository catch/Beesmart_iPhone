    //
//  MainMenuViewController.m
//  Gardening
//
//  Created by maesinfo on 11-8-2.
//  Copyright 2011 MaesInfo Corporation. All rights reserved.
//

#import "BrowseViewController.h"
#import "GardeningAppDelegate.h"



@implementation BrowseViewController


//@synthesize segmentCtrl;
//@synthesize navBrowse;

//@synthesize recommendationImages;




#pragma mark 
#pragma mark - UIViewController Management


- (void) willInit
{
	[super willInit];

	beginHeight += MAINSEG_HEIGHT + MAINSEG_MARGIN;

	segRed   =   0.3f;
	segGreen =   0.7f;
	segBlue  =   0.2f;
}




//- (void) initNavigation
//{
////	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
//
//	UINavigationController *tmpNav = [[UINavigationController alloc]initWithRootViewController: self];
//	tmpNav.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT);
//	[tmpNav setNavigationBarHidden:NO animated:NO];
//	tmpNav.view.backgroundColor = colorBackground; //[UIColor colorWithWhite:bgWhite alpha:1.0f];
////	tmpNav.navigationBar.barStyle = UIBarStyleBlack;
//	self.navController = tmpNav;
//	[tmpNav release];
//
//	self.title = @"Browse";
////	[self goNavigationController:browseNav controller:self];/*delegate.searchNav]*/;
//
////	[pool release];
//}

- (void) initHeaderButtons
{
	int i;
	for (i=0; i<COUNT_OF_HEADER_BUTTONS; i++) {
		buttons[i] = [[UIButton alloc]initWithFrame:CGRectMake(i*(SCREEN_WIDTH/COUNT_OF_HEADER_BUTTONS), startY, SCREEN_WIDTH/COUNT_OF_HEADER_BUTTONS, MAINSEG_HEIGHT)];
		[self.view addSubview:buttons[i]];
		[buttons[i] release];

		[buttons[i] addTarget:self action:@selector(onSelectSegmented:) forControlEvents:UIControlEventTouchUpInside];

//		buttons[i].selected = FALSE;
	}
	i =0;
	[buttons[i] setBackgroundImage:[UIImage imageNamed:@"header_back.png" ] forState:UIControlStateNormal];
	[buttons[i] setBackgroundImage:nil forState:UIControlStateSelected];
	[buttons[i] setTitleColor:colorBackground forState:UIControlStateNormal];
	[buttons[i] setTitleColor:colorText forState:UIControlStateSelected];
	[buttons[i++] setTitle:@"All" forState:UIControlStateNormal];

	[buttons[i] setBackgroundImage:[UIImage imageNamed:@"header_back.png" ] forState:UIControlStateNormal];
	[buttons[i] setImage:[UIImage imageNamed:@"seg0.png" ] forState:UIControlStateNormal];
	[buttons[i++] setImage:[UIImage imageNamed:@"seg0_.png" ] forState:UIControlStateSelected];
	[buttons[i] setBackgroundImage:[UIImage imageNamed:@"header_back.png" ] forState:UIControlStateNormal];
	[buttons[i] setImage:[UIImage imageNamed:@"seg2.png" ] forState:UIControlStateNormal];
	[buttons[i++] setImage:[UIImage imageNamed:@"seg2_.png" ] forState:UIControlStateSelected];
	[buttons[i] setBackgroundImage:[UIImage imageNamed:@"header_back.png" ] forState:UIControlStateNormal];
	[buttons[i] setImage:[UIImage imageNamed:@"seg3.png" ] forState:UIControlStateNormal];
	[buttons[i++] setImage:[UIImage imageNamed:@"seg3_.png" ] forState:UIControlStateSelected];
	[buttons[i] setBackgroundImage:[UIImage imageNamed:@"header_back.png" ] forState:UIControlStateNormal];
	[buttons[i] setImage:[UIImage imageNamed:@"seg4.png" ] forState:UIControlStateNormal];
	[buttons[i++] setImage:[UIImage imageNamed:@"seg4_.png" ] forState:UIControlStateSelected];
	[buttons[i] setBackgroundImage:[UIImage imageNamed:@"header_back.png" ] forState:UIControlStateNormal];
	[buttons[i] setImage:[UIImage imageNamed:@"seg5.png" ] forState:UIControlStateNormal];
	[buttons[i++] setImage:[UIImage imageNamed:@"seg5_.png" ] forState:UIControlStateSelected];

	[self onSelectSegmented:buttons[0]];
}


- (void) loadView
{
	[super loadView];

	[self initHeaderButtons];

	[secDatas retrieveDataAll_OneSection];
}


- (void) reloadTable
{
	[secDatas retrieveDataAll_OneSection];
	
	[table reloadData];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)viewWillAppear:(BOOL)animated
{
	if(navController.visibleViewController == self)
    	[navController setNavigationBarHidden:YES animated:NO];

	[super viewWillAppear:animated];
}

//- (void) changeFavoirte:(NSIndexPath*)indexPath :(BOOL)bSelected
//{
//	UIBrowseCell *cell = (UIBrowseCell*)[table cellForRowAtIndexPath:indexPath];
//
//	if(cell)
//	{
//		cell.buttonFavorite.selected = bSelected;
//	}
//}


//- (void)didReceiveMemoryWarning {
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//    
//    // Release any cached data, images, etc that aren't in use.
//}
//
//- (void)viewDidUnload {
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}


- (void)dealloc {
	
//	if(navController)
//		[navController release];

//	[self.segmentCtrl removeFromSuperview];
//	[self.segmentCtrl release];
	
	[self.view release];
    [super dealloc];
}

/*
 - (void) setUserInteractivityEnableForAllView:(BOOL) enable
 {
 for(UIView* subView in self.view.subviews)
 {
 [subView setUserInteractionEnabled:enable];
 }
 [self.view setUserInteractionEnabled:enable];
 }*/



#pragma mark 
#pragma mark - UI Operations

- (IBAction) onSelectSegmented: (id) sender{

//	UIColor *color = [UIColor colorWithRed:segRed green:segGreen blue:segBlue alpha:1.0f];
	int i=0;
	for(i=0;i<COUNT_OF_HEADER_BUTTONS;i++)
	{
		if(buttons[i] == sender)
		{
			buttons[i].backgroundColor = colorBackground;
			buttons[i].selected = TRUE;
			[buttons[i] setBackgroundImage:nil forState:UIControlStateNormal];
		}
		else 
		{
//			buttons[i].backgroundColor = color;
			buttons[i].selected = FALSE;
			[buttons[i] setBackgroundImage :[UIImage imageNamed:@"header_back.png"] forState:UIControlStateNormal];
		}
	}

}

@end
