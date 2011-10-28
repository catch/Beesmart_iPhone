//
//  ToolbarView.m
//  Gardening
//
//  Created by maesinfo on 11-8-2.
//  Copyright 2011 MaesInfo Corporation. All rights reserved.
//

#import "ToolbarView.h"
#import "Configuration.h"
#import "GardeningAppDelegate.h"
//#import "FoodSearch.h"

@implementation ToolBarButton
@synthesize bottomLabel;
@synthesize topImage;
/*
-(void)initButton
{
}*/

-(id) initWithFrame:(CGRect)frame
{
	[super initWithFrame:frame];

	bgRed   = 0.5f;
	bgGreen = 0.7f;
	bgBlue  = 0.13f;
	bgRed_Selected   = 0.99f;
	bgGreen_Selected = 0.99f;
	bgBlue_Selected  = 0.99f;

	return self;
}

-(void)setSelected:(bool)bSelected
{
	UIColor *color;
	if(bSelected)
	{
		color = [UIColor whiteColor];//[UIColor colorWithRed:bgRed_Selected green:bgGreen_Selected blue:bgBlue_Selected alpha:0.5f];
		topImage.highlighted = YES;
	    self.backgroundColor = color;
	    bottomLabel.backgroundColor = color;//[UIColor colorWithWhite:TOOLBAR_COLOR_SELECTED alpha:0.0f];
	}
	else
	{
		color = [UIColor colorWithRed:bgRed green:bgGreen blue:bgBlue alpha:1.0f];
		topImage.highlighted = NO;
		self.backgroundColor = color;
		bottomLabel.backgroundColor = color;
	}

}

-(void) dealloc
{
	[topImage    release];
	[bottomLabel release];
	[super dealloc];
}

@end




@implementation ToolbarView

@synthesize toolBarItems;
 
- (void)  willInit
{
	textRed   = 0.7f;
	textGreen = 1.0f;
	textBlue  = 0.7f;
}


-(void) initToolbarItem:(NSInteger)pos :(SEL)itemAction :(NSString*)image_default :(NSString*)image_selected :(NSString*)title
{
	CGFloat buttonWidth = (SCREEN_WIDTH - (TOOLBAR_BUTTON_COUNT +1) * TOOLBAR_BUTTON_OFFSET)/TOOLBAR_BUTTON_COUNT;
	static int count=0;
	
	ToolBarButton* tmpButton = [[[ToolBarButton alloc] initWithFrame:CGRectMake(count*buttonWidth, 0.0f, buttonWidth, TOOLBAR_HEIGHT)]autorelease];
	count++;

	// 1. load image view
	UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((buttonWidth-TOOLBAR_IMAGE_WIDTH)/2, 0, TOOLBAR_IMAGE_WIDTH, TOOLBAR_IMAGE_HEIGHT)];
	image.image = [UIImage imageNamed:image_default];
	image.highlightedImage = [UIImage imageNamed:image_selected];
	[tmpButton addSubview:image];
	tmpButton.topImage = image;
	[image release];
	[image release];

	// 2. load label
	UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, TOOLBAR_HEIGHT-TOOLBAR_TITLE_HEIGHT, buttonWidth, TOOLBAR_TITLE_HEIGHT)];
	label.text = title;
	label.backgroundColor = [UIColor colorWithWhite:TOOLBAR_COLOR_NORMAL alpha:0.0f];
	label.textColor = [UIColor colorWithRed:textRed green:textGreen blue:textBlue alpha:1.0f];
	label.font = [UIFont systemFontOfSize: 12.0f];
	label.textAlignment =   UITextAlignmentCenter;
	tmpButton.bottomLabel = label;
	[tmpButton addSubview:label];
	[label release];
	[label release];

	// 3. button addTarget
	[tmpButton addTarget:self action:itemAction forControlEvents:UIControlEventTouchUpInside];


	[self addSubview:tmpButton];
	if(nil == toolbarViews)
	{
		toolbarViews = [[NSMutableArray alloc]init];
	}
	[toolbarViews addObject:tmpButton];

}


-(ToolbarView*) initToolbar
{
	[super initWithFrame:CGRectMake(0, MAIN_VIEW_HEIGHT - TOOLBAR_HEIGHT + STATUS_BAR_HEIGHT, SCREEN_WIDTH, TOOLBAR_HEIGHT)]; 
	super.barStyle = UIBarStyleBlack;
	
	NSMutableArray* tmpToolBarItems = [[NSMutableArray alloc]init];
	self.toolBarItems = tmpToolBarItems;
	[tmpToolBarItems release];

	[self initToolbarItem:0 :@selector(goMoreView:)   :DASHBOARD_DEFAULT   :DASHBOARD_SELECTED :@"Dashboard"];
	[self initToolbarItem:1 :@selector(goBrowseView:) :BROWSE_DEFAULT :BROWSE_SELECTED :@"Plants"];
	[self initToolbarItem:2 :@selector(goSearchView:) :SEARCH_DEFAULT :SEARCH_SELECTED :@"Search"];
	[self initToolbarItem:3 :@selector(goFavoriteView:) :FAVORITE_DEFAULT :FAVORITE_SELECTED :@"Favorites"];

	indexSelected = -1;
	
	return self;
}


-(IBAction) goBrowseView:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.plantsController)
	{
		PlantsViewController *plantsController = [[PlantsViewController alloc]init];

		delegate.plantsController = plantsController;
		[plantsController   release];
	}
	if(! [self setSelectedUI:1])
	{
		return ;
	}

	[delegate.plantsController showView:delegate.currentController];

}

-(IBAction) goSearchView:(id)sender
{
	//init search view
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.searchViewController)
	{
		SearchViewController *searchController = [[SearchViewController alloc]init];
		
		delegate.searchViewController = searchController;
		[searchController   release];
	}

	if(! [self setSelectedUI:2])
	{
		return ;
	}
	

	[delegate.searchViewController showView:delegate.currentController];

}

-(IBAction) goFavoriteView:(id)sender
{
	//init favorite view
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.favoriteViewController)
	{
		FavoriteViewController *controller = [[FavoriteViewController alloc]init];
		
		delegate.favoriteViewController = controller;
		[controller   release];
	}

	if(! [self setSelectedUI:3])
	{
		return ;
	}


	[delegate.favoriteViewController showView:delegate.currentController];
}

-(IBAction) goMoreView:(id)sender
{
	//init More view
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.dashboardController)
	{
		DashboardViewController *controller = [[DashboardViewController alloc]init];
		
		delegate.dashboardController = controller;
		[controller   release];
	}

	if(! [self setSelectedUI:0])
	{
		return ;
	}


	[delegate.dashboardController showView:delegate.currentController];
}


- (bool) setSelectedUI:(int)index
{
	if(index == indexSelected)
		return NO;

	int i=0;
	ToolBarButton *item;
	for(i=0;i < toolbarViews.count; i++)
	{
		item = [toolbarViews objectAtIndex:i];
		if(i == index)
		{
			[item setSelected:YES];
		}
		else 
		{
			[item setSelected:NO];
		}
	}

	indexSelected = index;
	
	return YES;
}

- (void) enabledAll:(bool)bEnabled
{
	int i;
	ToolBarButton *button;
	for (i=0; i< toolbarViews.count; i++) 
	{
		button = [toolbarViews objectAtIndex:i];
		[button setEnabled: bEnabled];
	}
}

//- (void) buttonEnable:(int) index
//{
//	UIButton* button = [self.toolBarItems objectAtIndex:index];
//	button.enabled = YES;
//}
//
//- (void) buttonDisable:(int) index
//{
//	UIButton* button = [self.toolBarItems objectAtIndex:index];
//	button.enabled = NO;
//}
//
//- (IBAction) backPreviousView: (id) sender
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	if(delegate.currentController != nil)
//	{
//		[delegate.currentController backpreviousViewController];
//	}
//	
//}
//
//- (IBAction) gotoFavoriteView: (id) sender
//{
////	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
////	
////	if(delegate.favoriteTableView ==nil)
////	{
////		
////		delegate.favoriteTableView = [[TableView alloc] init];
////		
////	}	
////
//////	[delegate.viewStack push:delegate.currentController];
////	[delegate.currentController goNextViewController:delegate.favoriteTableView];
////	
////
////	if(delegate.favoriteData==nil){
////		
////			 delegate.favoriteData=[[NSMutableArray alloc] init];
////		
////	}
////
//////	NSString* str =@"收藏夹";
////	
//////	[delegate.favoriteTableView createFoodData:str:delegate.favoriteData];
//////	[delegate.favoriteTableView.table reloadData];
////
////	
////	[self buttonDisable:2];
////	
//	
//}
//
//- (IBAction) gotoSearchView: (id) sender
//{	
///*	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
//	
//	if(delegate.searchNav == nil)
//	{
//	    FoodSearch* c =[[FoodSearch alloc]init];
//    	delegate.searchNav = [[UINavigationController alloc] initWithRootViewController:c];
//        CGRect rc= delegate.searchNav.view.frame;
//		rc.origin.y -= 20;
//		[delegate.searchNav.view setFrame:rc];
//
//		delegate.searchViewController = c;
//	
//		[delegate.currentController goNavigationController:delegate.searchNav 
//												controller:delegate.searchViewController];
//		//	[c release];
//	}
//	else {
//		[delegate.currentController goNavigationController:delegate.searchNav 
//												controller:delegate.searchViewController];
//	}
//
//	[delegate.searchViewController setState];
//	*/
//}
//
//- (IBAction) gotoMainView: (id) sender
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	if(delegate.currentController != nil)
//	{
//		[delegate.currentController backMainView];
//	}
////	if(0 == [delegate.viewStack count])
//	{
////		[self buttonDisable:0];
//		//[self buttonDisable:2];
////		[self buttonDisable:3];
//	}
//}

- (void) dealloc
{
	indexSelected = -1;
	[toolbarViews removeAllObjects];
	[toolbarViews release];
	[super dealloc];
}
@end
