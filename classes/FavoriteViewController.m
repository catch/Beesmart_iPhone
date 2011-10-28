//
//  FavoriteViewController.m
//  Gardening
//
//  Created by maesinfo on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoriteViewController.h"
#import "GardeningAppDelegate.h"


@implementation FavoriteViewController



//- (void) initHeader
//{
//}


- (void) initNavigation
{
	[super initNavigation];

	self.title = @"Favorites";
}



-(void) loadView
{
	[super loadView];

	// extract items from favorite array
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[secDatas retrieveDataByArray_OneSection:delegate.favoriteArray];
}

-(void) reloadTable
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[secDatas retrieveDataByArray_OneSection:delegate.favoriteArray];

	[table reloadData];
}

-(void) viewWillAppear:(BOOL)animated
{
	if(navController.visibleViewController == self)
    	[navController setNavigationBarHidden:YES animated:NO];

    [super viewWillAppear:animated];

	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(delegate.favoriteChanged)
	{
		[secDatas retrieveDataByArray_OneSection:delegate.favoriteArray];
		[self.table reloadData];
		delegate.favoriteChanged = NO;
	}
}



- (void) dealloc
{
	SAFE_RELEASE(headerView);
	[super dealloc];
}


- (void) initFavoriteButton:(UIButton*)button :(NSString*)strName
{
	button.selected = TRUE;
}


- (IBAction) switchFavorite: (id) sender
{
	
}





#pragma mark 
#pragma mark - TableView Delegate Implementation
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return MAINSEG_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
//	if(tableView != secondTable)
//	{
//		return nil;// [table viewForHeaderInSection:section]
//	}

	if(nil == headerView)
	{
		NSUInteger headerHeight = MAINSEG_HEIGHT;
		headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
	//	[headerView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:1.0f]];

	//	UILabel *titleText = [[UILabel alloc]initWithFrame:headerView.frame];
	//	titleText.text =  @"Favorites";
	//	titleText.font = [UIFont boldSystemFontOfSize:24.0f];
	//	titleText.textAlignment = UITextAlignmentCenter;
	//	titleText.backgroundColor = colorBackground;
	//	titleText.textColor = colorText;//[UIColor blackColor];

		UIButton  *bgButton = [[UIButton alloc] initWithFrame:headerView.frame];
		[bgButton setTitle:@"Favorites" forState:UIControlStateNormal];
		bgButton.titleLabel.textAlignment = UITextAlignmentCenter;
		bgButton.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
		bgButton.titleLabel.textColor = colorText;//[UIColor whiteColor];
//		bgButton.titleLabel.backgroundColor = colorBackground;
		[bgButton setBackgroundImage:[UIImage imageNamed:@"header_back.png" ] forState:UIControlStateNormal];
		[headerView addSubview:bgButton];
		[bgButton release];
	}

	return headerView;
}


@end
