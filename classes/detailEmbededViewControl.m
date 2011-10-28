//
//  detailEmbededViewController.m
//  Gardening
//
//  Created by maesinfo on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "detailEmbededViewControl.h"
#import "GardeningAppDelegate.h"


@implementation DetailLineView

-(id)initWithArgs:(CGRect)externalFrame :(NSString*)iconName :(UIColor*)textColor :(UIColor*)bgColor
{
	[self initWithFrame:externalFrame];
	self.backgroundColor = bgColor;

	float iconWidth = 24;
	float iconHeight= iconWidth;
	CGRect frame = CGRectMake(10, (externalFrame.size.height - iconHeight)/2, iconWidth, iconHeight);
	UIImageView  *icon = [[UIImageView alloc] initWithFrame:frame];
	icon.image = [UIImage imageNamed:iconName];

	frame.origin.x = frame.origin.x + frame.size.width +5;
	frame.origin.y = 0;
	frame.size.width = externalFrame.size.width - frame.origin.x;
	frame.size.height= externalFrame.size.height;
	info = [[UILabel alloc] initWithFrame:frame];
	info.textColor = textColor;
	info.backgroundColor = bgColor;


	[self addSubview:icon];
	[self addSubview:info];
	[icon release];

	return self;
}

-(id)initAsTextInfo:(CGRect)externalFrame :(NSString*)titleText :(UIColor*)textColor :(UIColor*)bgColor
{
	[self initWithFrame:externalFrame];
	self.backgroundColor = bgColor;
	
	float iconWidth = titleText.length*10;
	float iconHeight= iconWidth;
	CGRect frame = CGRectMake(10, (externalFrame.size.height - iconHeight)/2, iconWidth, iconHeight);
	UILabel  *title = [[UILabel alloc] initWithFrame:frame];
	title.textColor = textColor;
	title.backgroundColor = bgColor;
	title.font = [UIFont boldSystemFontOfSize:18.0f];
	title.text = titleText;
	
	frame.origin.x = frame.origin.x + frame.size.width +5;
	frame.origin.y = 0;
	frame.size.width = externalFrame.size.width - frame.origin.x;
	frame.size.height= externalFrame.size.height;
	info = [[UILabel alloc] initWithFrame:frame];
	info.textColor = textColor;
	info.backgroundColor = bgColor;


	[self addSubview:title];
	[self addSubview:info];
	[title release];

	return self;
}

- (void) update:(NSString *)text
{
	info.text = text;
}

- (NSString*) getText
{
	return info.text;
}


- (void) dealloc
{
	SAFE_RELEASE(info);
	[super dealloc];
}

@end


@implementation DetailEmbededViewControl

- (id) initWithFrame:(CGRect) frame
{
	[super initWithFrame:frame];
	self.contentStretch = CGRectMake(0, 0, 10, 10);
	
	self.backgroundColor = [UIColor blackColor];
	
	int i;
	for(i=0;i<NUM_OF_DETAIL_EMBEDED;i++)
	{
		[self initControls:i];
	}
	
	
	[self setMode:DETAIL_EMBEDED_INFO];

	return self;
}


-(void) initControls:(int)mode
{
	switch (mode) {
		case DETAIL_EMBEDED_INFO:
			infoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DETAIL_EMBEDED_WIDTH, DETAIL_EMBEDED_HEIGHT)];
			infoImage.image = [UIImage imageNamed:@"loading.png"];// forState:UIControlStateNormal];
			infoIconButton = [[UIButton alloc]initWithFrame:CGRectMake(DETAIL_EMBEDED_WIDTH-DETAIL_ICONBUTTON_WIDTH, DETAIL_EMBEDED_HEIGHT-DETAIL_ICONBUTTON_HEIGHT, DETAIL_ICONBUTTON_WIDTH, DETAIL_ICONBUTTON_HEIGHT)];
			[infoIconButton setImage:[UIImage imageNamed:@"iconButton.png"] forState:UIControlStateNormal];
			[infoIconButton addTarget:self action:@selector(goInfoTable:) forControlEvents:UIControlEventTouchUpInside];
			infoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DETAIL_EMBEDED_WIDTH, DETAIL_EMBEDED_HEIGHT)];
			[infoTable setDataSource:self];
			[infoTable setDelegate:self];
//			[self addSubview:infoTable];
			[self addSubview:infoImage];
			[self addSubview:infoIconButton];

			break;
			
		case DETAIL_EMBEDED_NEIGHBOR:
			neighborTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DETAIL_EMBEDED_WIDTH, DETAIL_EMBEDED_HEIGHT)];
			[neighborTable setDataSource:self];
			[neighborTable setDelegate:self];
//			[self addSubview:infoTable];
			
			break;
			
		case DETAIL_EMBEDED_HABIT:
			
			break;
			
		default:
			break;
	}

}

- (void) releaseControls:(int)mode
{
	switch (mode) {
		case DETAIL_EMBEDED_INFO:
			if(infoImage)
				[infoImage release];
			if(infoIconButton)
				[infoIconButton release];
			if(infoTable)
				[infoTable release];
			
			break;
			
		case DETAIL_EMBEDED_NEIGHBOR:
			if (neighborTable) {
				[neighborTable release];
			}

			break;
			
		case DETAIL_EMBEDED_HABIT:
			
			break;
			
		default:
			break;
	}
		}


- (void) setMode:(int)mode
{
	switch (mode) {
		case DETAIL_EMBEDED_INFO:
		case DETAIL_EMBEDED_HABIT:			[self addSubview:infoImage];
			infoImage.backgroundColor = [UIColor blackColor];
			[self addSubview:infoIconButton];

			break;

		case DETAIL_EMBEDED_NEIGHBOR:
			[self addSubview:neighborTable];
			
			break;


			
		default:
			break;
	}
}

- (void) dealloc
{
	int i;
	for(i=0; i< NUM_OF_DETAIL_EMBEDED; i++)
	{
		[self releaseControls:i];
	}

	[super dealloc];
}


- (IBAction) goInfoTable:(id)sender
{
	[self addSubview:infoTable];
}





#pragma mark 
#pragma mark - TableView Datasource Implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//	
	//	NSInteger count = [delegate.dataHandler getSectionCount];
	//	if(0 == count)
	//	{
	return 1;
	//	}
	//	else {
	//		return count;
	//	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//	return [delegate.dataHandler getSectionTitle:section];
	
	return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//	if(0 == [delegate.dataHandler getSectionCount] )
	//	{
	return 3;
	//	}
	//	else
	//	{
	//		return [delegate.dataHandler getCountInSection:section];
	//	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	static NSString *RootViewControllerCell = @"RootViewControllerCell";
	NSString *str=[NSString stringWithFormat:@"RootViewCon%d-%d",indexPath.section,indexPath.row];
	UITableViewCell *cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:str];
//	GardeningAppDelegate  *delegate = [[UIApplication sharedApplication] delegate];
	
	// insure the cell exist, or create it
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:str];
		
		if(tableView == infoTable)
		{
			UILabel *label = [[UILabel alloc]initWithFrame:cell.frame];
			label.text = [NSString stringWithFormat:@"Photo%d",indexPath.row];
			[cell addSubview:label];
		}
		else {
			UILabel *label = [[UILabel alloc]initWithFrame:cell.frame];
			label.text = [NSString stringWithFormat:@"Image%d  Neighbor%d",indexPath.row,indexPath.row];
			[cell addSubview:label];
			// add image and name,the data retrieved from delegate
		}


		//		
		//		UIWebView  *webImage = [[UIWebView alloc]initWithFrame:CGRectMake(BROWSE_CELL_IMAGE_MARGIN, BROWSE_CELL_IMAGE_MARGIN, BROWSE_CELL_HEIGHT-8,BROWSE_CELL_HEIGHT-8)];
		//		UILabel    *label = [[UILabel alloc]initWithFrame:CGRectMake(BROWSE_CELL_TITLE_X, BROWSE_CELL_TITLE_Y, BROWSE_CELL_TITLE_WIDTH, BROWSE_CELL_TITLE_HEIGHT)];
		//		UILabel    *label2= [[UILabel alloc]initWithFrame:CGRectMake(BROWSE_CELL_TITLE_X, BROWSE_CELL_TITLE_Y+BROWSE_CELL_TITLE_HEIGHT, BROWSE_CELL_TITLE_WIDTH, BROWSE_CELL_TITLE_HEIGHT)];
		//		
		//		//		FavoriteButton   *favorite = [FavoriteButton buttonWithType:UIButtonTypeInfoDark];
		//		FavoriteButton   *favorite = [[FavoriteButton alloc]init];
		//		[favorite setFrame:CGRectMake(BROWSE_CELL_TITLE_X, BROWSE_CELL_FAVORITE_Y, BROWSE_CELL_FAVORITE_HEIGHT, BROWSE_CELL_FAVORITE_HEIGHT)];
		//		favorite.itemSection = indexPath.section;
		//		favorite.itemIndex = indexPath.row;
		//
		//
		//		//cell.imageView.frame = webImage.frame;
		//		cell.webImage = webImage;
		//		cell.labelBotanicalName = label;
		//		cell.labelCommonName = label2;
		//		cell.buttonFavorite = favorite;
		//		[webImage release];
		//		[label    release];
		//		[label2   release];
		//		[favorite release];
		//		
		//		[cell addSubview:webImage];
		//		[cell addSubview:label];
		//		[cell addSubview:label2];
		//		[cell addSubview:favorite];
		//		
		//		[webImage release];
		//		[label    release];
		//		[label2   release];
		//		[favorite release];
		//		//	[[cell imageView] setImage:[UIImage imageNamed:@"http://plants.usda.gov/gallery/pubs/acma3_001_php.jpg"]];
		//		
		//		// Configure the cell.
		//		cell.webImage.scalesPageToFit = TRUE;
		//
		//		UIColor *textColor = [UIColor whiteColor];//:self.textWhite alpha:1.0f];
		//		UIColor *bgColor   = [UIColor blackColor];//WithWhite:self.bgWhite alpha:1.0f];
		//		cell.labelBotanicalName.textColor = textColor;
		//		cell.labelBotanicalName.backgroundColor = bgColor;
		//		cell.labelBotanicalName.font = [UIFont boldSystemFontOfSize:BROWSE_CELL_TITLE_FONTSIZE];
		//		cell.labelCommonName.textColor = textColor;
		//		cell.labelCommonName.backgroundColor = bgColor;
		//		cell.labelCommonName.font = [UIFont italicSystemFontOfSize:BROWSE_CELL_TITLE2_FONTSIZE];
		//		
		//		cell.buttonFavorite.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.4f];
		//		[cell.buttonFavorite setImage:[UIImage imageNamed:FAVORITE_DEFAULT] forState:UIControlStateNormal];
		//		[cell.buttonFavorite setImage:[UIImage imageNamed:FAVORITE_SELECTED] forState:UIControlStateSelected];
		//		[cell.buttonFavorite addTarget:self action:@selector(switchFavorite:) forControlEvents:UIControlEventTouchUpInside];
		//		
		//		
		//		// set cell's value
		//		GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		//		if([delegate.dataHandler getSectionCount] > 0)
		//		{
		//			[cell.labelBotanicalName setText:[delegate.dataHandler getDataAtIndexByID:indexPath :BOTANICAL_NAME]];
		//			[cell.labelCommonName setText:[delegate.dataHandler getDataAtIndexByID:indexPath:PREFERED_COMMON_NAME]];
		//			NSString *url = [delegate.dataHandler getDataAtIndexByID:indexPath :URL];
		//			NSString* urlEncoding = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		//			NSURLRequest* urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEncoding] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
		//			//if(FALSE == cell.webImage.loading)
		//			{
		//				[cell.webImage loadRequest:urlrequest];
		//			}
	}
	else 
	{
//		[cell.labelBotanicalName setText:@"loading"];
//		[cell.labelCommonName setText:@"loading"];
//
//		NSString *path = [[NSBundle mainBundle] pathForResource:@"loading.png" ofType:nil];
//		NSURL *url = [NSURL fileURLWithPath:path];
//		NSURLRequest *request = [NSURLRequest requestWithURL:url];
//		[cell.webImage loadRequest:request];
		
		//		[[webImage addSubview:[UIImageView alloc]initWithFrame:webImage.frame]autorelease] = [UIImage imageNamed:@"loading.png"];
	}    
	//	}
	
	//	[[cell textLabel] setText:[self textAtSectionAndRow:indexPath.section :indexPath.row];
	//	[[cell imageView] setImage:[UIImage imageNamed:@"test.png"]];
	
    return cell;
}




#pragma mark 
#pragma mark - TableView Delegate Implementation


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DETAIL_CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
	UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DETAIL_CELL_WIDTH,DETAIL_CELLHEADER_HEIGHT)];
	[headerView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:1.0f]];

	UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(4,0, DETAIL_CELL_WIDTH-4, DETAIL_CELLHEADER_HEIGHT)];
	if(tableView == infoTable)
	{
		titleText.text =  @"Select Photo";
	}
	else {
		titleText.text = @"Good Neighbor";
	}

	titleText.backgroundColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
	titleText.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
	
	[headerView addSubview:titleText];
	
	return headerView;
}

// adjust whether can be selected
- (NSIndexPath *)tableView:(UITableView *)tableView 
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	if(indexPath.row < 3)
	//    	return nil;
	//	else {
	return indexPath;
	//	}
	
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//	if(nil == delegate.detailShowViewController)
	//	{
	//		//	[listView setMode:indexPath.row-3];
	//		DetailShowViewController *tmpController = [[DetailShowViewController alloc]init];
	//		delegate.detailShowViewController = tmpController;
	//		[tmpController release];
	//		
	//	}
	//	[browseNav setNavigationBarHidden:NO animated:NO];
	//	[self.navigationController pushViewController :delegate.detailShowViewController animated:YES];
	//	
	//	//	[self goDetailShow];
	//	
	//	//	[delegate.currentController goNavigationController:browseNav 
	//	//											controller:delegate.detailShowViewController];/*delegate.searchNav]*/;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];//the color will disappear
}






@end
