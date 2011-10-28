//
//  BrowseTableView.m
//  Gardening
//
//  Created by maesinfo on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "BrowseTableViewController.h"
#import "Configuration.h"
#import "GardeningAppDelegate.h"
#import <QuartzCore/QuartzCore.h>




@implementation FavoriteButton
@synthesize itemSection;
@synthesize itemIndex;


@end






@implementation UIBrowseCell

@synthesize imageView;
@synthesize label1;
@synthesize label2;
@synthesize buttonFavorite;


-(void)dealloc
{
	[buttonFavorite release];
	[imageView release];
	[label1    release];
	[label2    release];
	
	[super dealloc];
}

@end






@implementation BrowseTableViewController
@synthesize		table;
@synthesize		recordArray;
@synthesize     beginHeight;


#pragma mark 
#pragma mark - Implementation of UIViewController


- (void) willInit
{
	beginHeight =  startY;
//	bgWhite     = 0.95f;
	separateWhite = 0.85f;
}


- (void) reloadTable
{
}

-(void) initTable
{
	[self willInit];

	table =  [[UITableView alloc]initWithFrame:CGRectMake(0.0, beginHeight, SCREEN_WIDTH, MAIN_VIEW_HEIGHT-beginHeight ) 
											 style:UITableViewStylePlain];
	[table setDelegate:self];
	[table setDataSource:self];
	table.separatorColor = [UIColor colorWithWhite:separateWhite alpha:1.0f]; 
	[table setBackgroundColor:colorBackground];

	[self.view addSubview:table];
	
	secDatas = [[SectionDatas alloc]init];
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[secDatas setDataHandler:delegate.dataHandler];
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
		tmpNav.navigationBar.backgroundColor = [UIColor greenColor];

		self.navController = tmpNav;
		[tmpNav release];
	}
}

- (void) loadView
{
	[super loadView];

	[self initTable];
}

- (void) dealloc
{
//	[currentItems release];

	if (secDatas) {
		[secDatas release];
	}
	if(table)
	{
		[table release];
	}
    if(recordArray)
	{
		[recordArray release];
	}
	[super dealloc];
}


- (IBAction) switchFavorite: (id) sender
{
	FavoriteButton *button = sender;
	
	button.selected = !button.selected;
	
	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	FusionTableData *item = [secDatas getFusionTableData:button.itemSection :button.itemIndex];
	if(item)
	{
		[self setFavoirte:item->strBotanicalName :button.selected];
	}
}


- (void) initFavoriteButton:(UIButton*)button :(NSString*)strName
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(isStringInArray(strName,delegate.favoriteArray)) 
	{
		button.selected = TRUE;
	}
	else {
		button.selected = FALSE;
	}

}



- (UIBrowseCell *)  initPlantCell:(NSIndexPath*)indexPath :(NSString*)strIdentifier
{
	UIBrowseCell *cell;
	cell = [[UIBrowseCell alloc] initWithFrame:CGRectZero reuseIdentifier:strIdentifier];
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;	

	// create
	UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(BROWSE_CELL_IMAGE_MARGIN, BROWSE_CELL_IMAGE_MARGIN, BROWSE_CELL_IMAGE_WIDTH,BROWSE_CELL_IMAGE_WIDTH)];
	UILabel    *label1= [[UILabel alloc]initWithFrame:CGRectMake(BROWSE_CELL_TITLE_X, BROWSE_CELL_TITLE_Y, BROWSE_CELL_TITLE_WIDTH, BROWSE_CELL_TITLE_HEIGHT)];
	UILabel    *label2= [[UILabel alloc]initWithFrame:CGRectMake(BROWSE_CELL_TITLE_X, BROWSE_CELL_TITLE_Y+BROWSE_CELL_TITLE_HEIGHT, BROWSE_CELL_TITLE_WIDTH, BROWSE_CELL_TITLE_HEIGHT)];
	FavoriteButton   *favorite = [[FavoriteButton alloc]init];
	[favorite setFrame:CGRectMake(BROWSE_CELL_TITLE_X, BROWSE_CELL_FAVORITE_Y, BROWSE_CELL_FAVORITE_HEIGHT, BROWSE_CELL_FAVORITE_HEIGHT)];
	favorite.itemSection = indexPath.section;
	favorite.itemIndex = indexPath.row;

	// configure
	imageView.layer.cornerRadius = 8;
	imageView.layer.masksToBounds = YES;
	label1.textColor = colorText;
	label1.backgroundColor = colorBackground;
	label1.font = [UIFont boldSystemFontOfSize:BROWSE_CELL_TITLE_FONTSIZE];
	label2.textColor = colorText;
	label2.backgroundColor = colorBackground;
	label2.font = [UIFont italicSystemFontOfSize:BROWSE_CELL_TITLE2_FONTSIZE];

	favorite.backgroundColor = colorBackground;
	[favorite setImage:[UIImage imageNamed:FAVORITE_BUTTON] forState:UIControlStateNormal];
	[favorite setImage:[UIImage imageNamed:FAVORITE_SELECTED] forState:UIControlStateSelected];
	[favorite addTarget:self action:@selector(switchFavorite:) forControlEvents:UIControlEventTouchUpInside];

	cell.imageView = imageView;
	cell.label1 = label1;
	cell.label2 = label2;
	cell.buttonFavorite = favorite;
	[imageView release];
	[label1    release];
	[label2   release];
	[favorite release];
	
	[cell addSubview:cell.imageView];
	[cell addSubview:cell.label1];
	[cell addSubview:cell.label2];
	[cell addSubview:cell.buttonFavorite];

	return cell;
}


- (void) updateCellValue:(UIBrowseCell *)cell :(NSIndexPath*)indexPath;
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if([secDatas count] > 0)
	{
		FusionTableData *record = [secDatas getFusionTableData:indexPath];
		if(record)
		{
			[cell.label1 setText: [record->strPreferedCommonName capitalizedString]];
			[cell.label2 setText: [record->strBotanicalName capitalizedString]];

			NSString *localPath = [delegate.dataHandler.imageHandler getLocalPath:record->strBotanicalName];
			UIImage  *image=nil;
			if(nil != localPath)
			{
//				NSLog(@"image exist!");
//				NSLog(record->strBotanicalName);
//				NSLog(localPath);
//				NSLog(record->strURL);

				image = [UIImage imageWithContentsOfFile:localPath];
			}
			if(image)
			{
				[cell.imageView setImage: image];
			}
			else 
			{
				NSLog(@"image doesn't exist!");
				NSLog(@"%@",record->strBotanicalName);
				NSLog(@"%@",localPath);
				NSLog(@"%@",record->strURL);

				NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"png"];
				[cell.imageView setImage:[UIImage imageWithContentsOfFile:path]];//imageNamed:LOADING_IMAGE_FILE]];
			}

			[self initFavoriteButton:cell.buttonFavorite :record->strBotanicalName];
		}
		else 
		{
			[cell.label1 setText:@"loading"];
			[cell.label2 setText:@"loading"];

			[cell.imageView setImage:[UIImage imageNamed:@"loading.png"]];
			//			NSString *path = [[NSBundle mainBundle] pathForResource:@"loading.png" ofType:nil];
			//			NSURL *url = [NSURL fileURLWithPath:path];
			//			NSURLRequest *request = [NSURLRequest requestWithURL:url];
			//			[cell.webImage loadRequest:request];
		}
	}
}

- (void) showDetailView:(NSString*) bonanticalName
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.detailShowViewController)
	{
		//	[listView setMode:indexPath.row-3];
		DetailShowViewController *tmpController = [[DetailShowViewController alloc]init];
		delegate.detailShowViewController = tmpController;
		[tmpController release];
	}
	//	[delegate updateCurrentData:indexPath];

	[delegate.detailShowViewController updateDetail:bonanticalName];

	if(self.navigationController.topViewController == self)
	    [self.navigationController pushViewController :delegate.detailShowViewController animated:YES];
	
	[self.navController setNavigationBarHidden:NO animated:NO];

}



#pragma mark 
#pragma mark - TableView Datasource Implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [secDatas count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
////	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
////	return [delegate.dataHandler getSectionTitle:section];
//
//	return [secDatas getSectionTitle:section];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [secDatas getCountInSection:section];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	static NSString *RootViewControllerCell = @"RootViewControllerCell";
	NSString *str=[NSString stringWithFormat:@"RootViewCon%d-%d",indexPath.section,indexPath.row];
	UIBrowseCell *cell =(UIBrowseCell*) [tableView dequeueReusableCellWithIdentifier:str];

	NSLog(@"%@",str);
	// insure the cell exist, or create it
    if (cell == nil) 
	{
		cell = [self initPlantCell:indexPath :str];
	}

	[self updateCellValue:cell :indexPath];


    return cell;
}




#pragma mark 
#pragma mark - TableView Delegate Implementation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BROWSE_CELL_HEIGHT;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
//{
//	NSUInteger headerHeight = BROWSE_CELL_HEIGHT/4;
//	UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
//	[headerView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:1.0f]];
//	
//	UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(4,0, SCREEN_WIDTH-4, headerHeight)];
//	titleText.text =  [secDatas getSectionTitle:section];
//	titleText.backgroundColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
//	titleText.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
//	
//	[headerView addSubview:titleText];
//	
//	return headerView;
//}

// adjust whether can be selected
//- (NSIndexPath *)tableView:(UITableView *)tableView 
//  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	//	if(indexPath.row < 3)
//	//    	return nil;
//	//	else {
////	return indexPath;
//	//	}
//
//	return nil;
//}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	FusionTableData *record = [secDatas getFusionTableData:indexPath];
	if(record)
	{
		[self showDetailView:record->strBotanicalName];
	}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];//the color will disappear
}



@end
