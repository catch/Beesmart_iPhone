//
//  MoreViewController.m
//  Gardening
//
//  Created by maesinfo on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "GardeningAppDelegate.h"


@implementation MoreViewController


-(void) loadView
{
	[super loadView];

/*	[btn setTitle:@"Search" forState:UIControlStateNormal];
	btn.titleLabel.textColor = [UIColor blackColor];
	[btn setBackgroundColor:[UIColor grayColor]];
	[btn addTarget:self action:@selector(doSearch:) forControlEvents:UIControlEventTouchUpInside];
*/
//
//	buttonZone = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 120, 40)];
//	[buttonZone setTitle:@"Select Zone" forState:UIControlStateNormal];
//	buttonZone.backgroundColor = [UIColor grayColor];
//	buttonZone.titleLabel.textColor = [UIColor blackColor];
//	[buttonZone addTarget:self action:@selector(goZoneView:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:buttonZone];
//	[buttonZone release];

	buttonFeedback = [[UIButton alloc]initWithFrame:CGRectMake(100, 130, 120, 40)];
	[buttonFeedback setTitle:@"About" forState:UIControlStateNormal];
	buttonFeedback.backgroundColor = [UIColor grayColor];
	buttonFeedback.titleLabel.textColor = [UIColor blackColor];
	[buttonFeedback addTarget:self action:@selector(goAbout:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonFeedback];
	[buttonFeedback release];
	
	UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 210, 120, 40)];
	[btn setTitle:@"Donate" forState:UIControlStateNormal];
	btn.backgroundColor = [UIColor grayColor];
	btn.titleLabel.textColor = [UIColor blackColor];
	[btn addTarget:self action:@selector(goDonate:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	[btn release];
	

	btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 290, 120, 40)];
	[btn setTitle:@"Help" forState:UIControlStateNormal];
	btn.backgroundColor = [UIColor grayColor];
	btn.titleLabel.textColor = [UIColor blackColor];
	[btn addTarget:self action:@selector(goHelp:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	[btn release];


	self.view.backgroundColor = colorBackground;
}

- (void) initNavigation
{
	if(nil == navController)
	{
		UINavigationController *tmpNav = [[UINavigationController alloc]initWithRootViewController: self];
		tmpNav.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, MAIN_VIEW_HEIGHT);
		[tmpNav setNavigationBarHidden:YES animated:NO];
		//	tmpNav.navigationBar.font = colorText;
		tmpNav.view.backgroundColor = colorBackground;
		
		self.navController = tmpNav;
		[tmpNav release];
	}
	self.title = @"Info";
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.navController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)goAbout:(id)sender
{
	if(nil == aboutController)
	{
		//	[listView setMode:indexPath.row-3];
		aboutController = [[aboutViewController alloc]init];
	}
	
	if(self.navigationController.topViewController == self)
	    [self.navigationController pushViewController :aboutController animated:YES];
	[self.navController setNavigationBarHidden:NO animated:NO];

	
}

- (IBAction)goHelp:(id)sender
{
	if(nil == helpController)
	{
		//	[listView setMode:indexPath.row-3];
		helpController = [[helpViewController alloc]init];
	}
	
	if(self.navigationController.topViewController == self)
	    [self.navigationController pushViewController :helpController animated:YES];
	[self.navController setNavigationBarHidden:NO animated:NO];

}

- (IBAction)goDonate:(id)sender
{
	if(nil == donateController)
	{
		//	[listView setMode:indexPath.row-3];
		donateController = [[DonateViewController alloc]init];
	}
	
	if(self.navigationController.topViewController == self)
	    [self.navigationController pushViewController :donateController animated:YES];
	[self.navController setNavigationBarHidden:NO animated:NO];
	
}



- (void) dealloc
{
	SAFE_RELEASE(donateController);
	SAFE_RELEASE(aboutController);
	SAFE_RELEASE(helpController);
	[buttonZone release];
    [buttonFeedback release];
	[super dealloc];
}

@end
