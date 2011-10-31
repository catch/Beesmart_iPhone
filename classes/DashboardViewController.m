//
//  DashboardViewController.m
//  Gardening
//
//  Created by maesinfo on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DashboardViewController.h"
#import "GardeningAppDelegate.h"
#import "CatchNotesLauncher.h"

@implementation DashboardViewController

- (void) initHeader
{
	
}

- (void) willLoadView
{
	[super willLoadView];

	bShowToolbar = FALSE;
}

- (void) loadView
{
	[super loadView];

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	self.view.backgroundColor = [UIColor whiteColor];
    // add header logo
	UIImageView  *header = [[UIImageView alloc] initWithFrame:CGRectMake(HEADER_LOGO_X, HEADER_LOGO_Y, HEADER_LOGO_WIDTH,HEADER_LOGO_HEIGHT)];
	header.image = [UIImage imageNamed:@"logo_beesmart.png"];
	[self.view addSubview:header];
	[header release];

//	float margin = 0.12;
//	UIImageView  *header2 = [[UIImageView alloc] initWithFrame:CGRectMake(HEADER_LOGO_WIDTH+(SCREEN_WIDTH*margin), HEADER_LOGO_Y, (1-margin)*SCREEN_WIDTH-HEADER_LOGO_WIDTH-HEADER_LOGO_X,HEADER_LOGO2_HEIGHT)];
	float width = 124;
	float height= 38;
	UIImageView  *header2 = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-width)/2, MAIN_VIEW_HEIGHT-height-3, width,height)];
	header2.image = [UIImage imageNamed:@"logo_pp.png"];
	[self.view addSubview:header2];
	[header2 release];

	// add search
	UIButton  *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50,5,48,48)];
	[searchBtn setImage:[UIImage imageNamed:@"search_dashboard.png"] forState: UIControlStateNormal];
	[searchBtn addTarget:self action:@selector(goSearch:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:searchBtn];
	[searchBtn release];


	// Plants
	CGRect frame = CGRectMake(UNIT_OFFSET_X, UNIT_START_Y, UNIT_WIDTH,UNIT_HEIGHT );
	unit[0] = [[UnitControl alloc] initWithArgs:frame :@"main_allleaves.png" :@"Plants" :@selector(goPlants:)];

	// Map
	frame.origin.y += UNIT_HEIGHT + UNIT_OFFSET_Y ;
	unit[1] = [[UnitControl alloc] initWithArgs:frame :@"main_ecoregions.png" :@"Ecoregions" :@selector(goMap:)];

	// Info
	frame.origin.y += UNIT_HEIGHT + UNIT_OFFSET_Y ;
	unit[2] = [[UnitControl alloc] initWithArgs:frame :@"main_info.png" :@"Info"  :@selector(goInfo:)];

	// Favorite
	frame.origin.y = UNIT_START_Y;
	frame.origin.x = (SCREEN_WIDTH - UNIT_WIDTH - UNIT_OFFSET_X);
	unit[3] = [[UnitControl alloc] initWithArgs:frame :@"main_catchnotes.png" :@"Notes" :@selector(goNote:)];

	// Note
	frame.origin.y += UNIT_HEIGHT + UNIT_OFFSET_Y ;
	unit[4] = [[UnitControl alloc] initWithArgs:frame :@"main_favorites.png" :@"Favorites" :@selector(goFavorites:)];

	// Zip
	frame.origin.y += UNIT_HEIGHT  + UNIT_OFFSET_Y;
	unit[5] = [[UnitControl alloc] initWithArgs:frame :@"main_zipcode.png" :@"Zip Code" :@selector(goZip:)];


	for(int i=0; i<6; i++)
	{
		[self.view addSubview:unit[i]];
		[unit[i] release];
	}

	[pool release];
}


- (IBAction)  goPlants:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.plantsController)
	{
		PlantsViewController *plantsController = [[PlantsViewController alloc]init];

		delegate.plantsController = plantsController;
		[plantsController   release];
	}
	
	[delegate.plantsController showView:delegate.currentController];

}


- (IBAction)  goMap:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.mapController)
	{
		EcoregionMapController *controller = [[EcoregionMapController alloc]init];

		delegate.mapController = controller;
		[controller   release];
	}
	[delegate.mapController showView:delegate.currentController];
//	[delegate.mapController requestFusionData];
	[delegate.mapController showInWeb];
}



- (IBAction)  goZip:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.zipController)
	{
		ZipViewController *controller = [[ZipViewController alloc]init];

		delegate.zipController = controller;
		[controller   release];
	}
	[delegate.zipController showView:delegate.currentController];
}


- (IBAction)  goFavorites:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.favoriteViewController)
	{
		FavoriteViewController *controller = [[FavoriteViewController alloc]init];

		delegate.favoriteViewController = controller;
		[controller   release];
	}
	
	[delegate.favoriteViewController showView:delegate.currentController];
}

- (IBAction)  goNote:(id)sender
{
	NSString *tag = @"BeeSmart";
	
	[CatchNotesLauncher showNotesWithTag:tag fromViewController:self];
}


- (IBAction)  goInfo:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.moreViewController)
	{
		MoreViewController *controller = [[MoreViewController alloc]init];

		delegate.moreViewController = controller;
		[controller   release];
	}
	
	[delegate.moreViewController showView:delegate.currentController];
}

- (IBAction)  goSearch:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.searchViewController)
	{
		SearchViewController *controller = [[SearchViewController alloc]init];
		
		delegate.searchViewController = controller;
		[controller   release];
	}
	
	[delegate.searchViewController showView:delegate.currentController];
}



- (void) dealloc
{
	SAFE_RELEASE(alertDialog);
	[super dealloc];
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(0 == buttonIndex)
	{
		NSString* urlString = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/catch-notes/id355424047?mt=8"];

		// An the final magic ... openURL!
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
	}
}


@end
