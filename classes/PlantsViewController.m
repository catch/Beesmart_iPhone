//
//  SortedViewController.m
//  Gardening
//
//  Created by maesinfo on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlantsViewController.h"
#import "GardeningAppDelegate.h"


@implementation  UIImageButton
@synthesize selected;

-(void) initImages:(UIImage*)normal :(UIImage*)seled
{
	imageNormal   = normal;
	imageSelected = seled;
}

-(void) setState:(BOOL)bSelected
{
	selected = bSelected;
	if(selected)
		self.image = imageSelected;
	else {
		self.image = imageNormal;
	}
}


@end

@implementation SecondTableDelegate


#pragma mark 
#pragma mark - TableView Datasource Implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	GardeningAppDelegate *delegate= [[ UIApplication sharedApplication] delegate];
	return [delegate.plantsController.sortArray count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section// fixed font style. use custom view (UILabel) if you want something different
//{
//	return secondLevelTitle;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	static NSString *RootViewControllerCell = @"RootViewControllerCell";
	NSString *str=[NSString stringWithFormat:@"RootViewCon%d-%d",indexPath.section,indexPath.row];
	SecondLevelCell *cell =(SecondLevelCell*) [tableView dequeueReusableCellWithIdentifier:str];

	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	// insure the cell exist, or create it
    if (cell == nil) {

		cell = [[SecondLevelCell alloc] initWithFrame:CGRectZero reuseIdentifier:str];
//		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		// add image view
		float image_offset = 12.0f;
		CGRect frame = CGRectMake(0, 0, CELL_SECOND_LEVEL_HEIGHT, CELL_SECOND_LEVEL_HEIGHT);
		UIView *bgView = [[UIView alloc]initWithFrame:frame];
		bgView.backgroundColor = delegate.plantsController.colorBackground;
		[cell addSubview:bgView];
		[bgView release];

		frame.origin.x  += image_offset;
		frame.origin.y  += image_offset;
		frame.size.width -= image_offset*2;
		frame.size.height-= image_offset*2;

		UIImageView *tmpView = [[UIImageView alloc] initWithFrame:frame];
		cell.imageView = tmpView;
		[tmpView release];
		[cell addSubview:tmpView];
		[tmpView release];

		// init label
		frame = CGRectMake(CELL_SECOND_LEVEL_HEIGHT, 0, SCREEN_WIDTH-CELL_SECOND_LEVEL_HEIGHT, CELL_SECOND_LEVEL_HEIGHT);
		UILabel  *label = [[UILabel alloc]initWithFrame:frame];
		label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		label.textColor = delegate.plantsController.colorText;
		label.backgroundColor = delegate.plantsController.colorBackground;
		[cell addSubview:label];
		[label release];
		cell.label = label;
		[label release];

		if(nil == iconNormal)
			iconNormal = [UIImage imageNamed:@"select_check_off.png"];
		if(nil == iconSelected)
			iconSelected = [UIImage imageNamed:@"select_check_on.png"];

		float width = 12;
		float height= 12;
		UIImageButton    *btn = [[UIImageButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, (CELL_SECOND_LEVEL_HEIGHT-height)/2, width, height)];
//		[btn setImage:[UIImage imageNamed:@"select_check_off.png"] forState:UIControlStateNormal];
//		[btn setImage:[UIImage imageNamed:@"select_check_on.png"] forState:UIControlStateSelected];
		[btn initImages:iconNormal :iconSelected];
		[btn setState:NO];
		btn.image = [UIImage imageNamed:@"select_check_off.png"];
		
		[cell addSubview:btn];
		cell.selectionIcon = btn;
		[btn release];


//		UIButton   *button = [UIButton alloc]

		cell.backgroundColor = delegate.plantsController.colorBackground;
		
		//init
		if(indexPath.row ==0)
		{
			[cell.selectionIcon setState: YES];
		}
	}

	// set value
	cell.label.text = [[delegate.plantsController.sortArray objectAtIndex:indexPath.row] objectForKey:@"string"];
	cell.imageView.image = [UIImage imageNamed:[[delegate.plantsController.sortArray objectAtIndex:indexPath.row] objectForKey:@"icon"]];
//	if(indexPath.row > 0)
	{
		NSKeyBool *boolArray = [delegate.plantsController currentSelectedArray];
		NSString  *key = [[delegate.plantsController.sortArray objectAtIndex:indexPath.row] objectForKey:@"string"];

		if(boolArray && key)
		{
			[cell.selectionIcon setState: [boolArray getBool:key]];
		}
	}

	return cell;
}


#pragma mark - TableView Delegate Implementation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return CELL_SECOND_LEVEL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

	return CELL_SECOND_LEVEL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSUInteger headerHeight = CELL_SECOND_LEVEL_HEIGHT;
	UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
	//	[headerView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:1.0f]];
	
	UILabel *titleText = [[UILabel alloc]initWithFrame:headerView.frame];
	titleText.text =  delegate.plantsController.secondLevelTitle;
	titleText.font = [UIFont boldSystemFontOfSize:22.0f];
	titleText.textAlignment = UITextAlignmentCenter;
	titleText.backgroundColor = delegate.plantsController.colorBackground;
	titleText.textColor = delegate.plantsController.colorText;//[UIColor blackColor];

	[headerView addSubview:titleText];

	return headerView;
}


- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if( 0== indexPath.row)
	{
		SecondLevelCell *cell = (SecondLevelCell*)[tableView cellForRowAtIndexPath:indexPath];
		if(!cell.selectionIcon.selected)
		{
			[cell.selectionIcon setState: YES];
			[self emptyAllOtherCells:tableView];
		}
	}
	else
	{
		// set UI
		SecondLevelCell *cell = (SecondLevelCell*)[tableView cellForRowAtIndexPath:indexPath];
		[cell.selectionIcon setState: !cell.selectionIcon.selected];

		//set value
		GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		NSString *key = [[delegate.plantsController.sortArray objectAtIndex:indexPath.row] objectForKey:@"string"];
		NSKeyBool *boolArray = [delegate.plantsController currentSelectedArray];
		[boolArray setBool:key :cell.selectionIcon.selected];
	
		// clear first one
		BOOL bCancel = !cell.selectionIcon.selected;
		NSUInteger indexs[16];
		[indexPath getIndexes:indexs];
		indexs[1]=0;
		NSUInteger length = [indexPath length];
		NSIndexPath *path= [ NSIndexPath indexPathWithIndexes:indexs length:length];

		cell = (SecondLevelCell*)[tableView cellForRowAtIndexPath:path];
		if(bCancel)
		{
			if(![self allCellEmpty:tableView])
			{
				[cell.selectionIcon setState: NO];
			}else
			{
				[cell.selectionIcon setState: YES];
			}
		}
		else {
			[cell.selectionIcon setState: NO];
		}

		key = [[delegate.plantsController.sortArray objectAtIndex:0] objectForKey:@"string"];
		boolArray = [delegate.plantsController currentSelectedArray];
		[boolArray setBool:key :cell.selectionIcon.selected];

	}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];//the color will disappear
}

- (BOOL) allCellEmpty:(UITableView *)tableView
{
	NSUInteger indexs[2]={0,0};
	NSUInteger length=2;// = [indexPath length];
	int n;
	BOOL bEmpty=YES;
	NSIndexPath *indexPath;
	for(n=1; n< [tableView numberOfRowsInSection:0]; n++)
	{
		indexs[1]=n;
		indexPath= [[NSIndexPath alloc ]initWithIndexes:indexs length:length];
		SecondLevelCell *cell = (SecondLevelCell*)[tableView cellForRowAtIndexPath:indexPath];
		if(cell.selectionIcon.selected)
		{
			bEmpty = NO;
			break;
		}
		SAFE_RELEASE(indexPath);
	}
	
	return bEmpty;
}

-(void) emptyAllOtherCells:(UITableView *)tableView
{
	NSUInteger indexs[2]={0,0};
	NSUInteger length=2;// = [indexPath length];
	int n;
	NSIndexPath *indexPath;
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	for(n=1; n< [tableView numberOfRowsInSection:0]; n++)
	{
		indexs[1]=n;
		indexPath= [[NSIndexPath alloc ]initWithIndexes:indexs length:length];
		SecondLevelCell *cell = (SecondLevelCell*)[tableView cellForRowAtIndexPath:indexPath];
		[cell.selectionIcon setState:NO];
		
		NSString *key = [[delegate.plantsController.sortArray objectAtIndex:indexPath.row] objectForKey:@"string"];
		NSKeyBool  *boolArray = [delegate.plantsController currentSelectedArray];
		[boolArray setBool:key :NO];

		SAFE_RELEASE(indexPath);
	}

//	indexs[1]=0;
//	indexPath= [[NSIndexPath alloc ]initWithIndexes:indexs length:length];
	NSString *key = [[delegate.plantsController.sortArray objectAtIndex:0] objectForKey:@"string"];
	NSKeyBool  *boolArray = [delegate.plantsController currentSelectedArray];
	[boolArray setBool:key :YES];

//	SAFE_RELEASE(indexPath);
}

-(void) dealloc
{
	SAFE_RELEASE(iconNormal);
	SAFE_RELEASE(iconSelected);
	[super dealloc];
}

@end




@implementation SecondLevelCell
@synthesize  label;
@synthesize  imageView;
@synthesize  selectionIcon;

- (void) dealloc
{
	SAFE_RELEASE(selectionIcon);
	if(imageView)
		[imageView release];

	if(label)
		[label release];
	
	[super dealloc];
}

@end

#pragma mark -
#pragma mark 
@implementation ResultTableDelegate



@end


#pragma mark -
#pragma mark 
@implementation PlantsViewController
@synthesize  secondLevelTitle;
@synthesize  sortArray;
//@synthesize  selectedArray;

#pragma mark 
#pragma mark - UIViewController Management


- (void) willLoadView
{
	[super willLoadView];

	segRed   =   0.3f;
	segGreen =   0.7f;
	segBlue  =   0.2f;

	[self setValue:0];
	tableDelegate = [[SecondTableDelegate alloc]init];
}


- (void) initHeader
{
	[super initHeader];

//	UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, 0, 40, 40)];
//	[button setImage:[UIImage imageNamed:@"iconButton.png"] forState:UIControlStateNormal];
//	[button addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:button];
//	[button release];
}

-(IBAction) onRefresh:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.dataHandler requestFusionData];
	
}

- (void) setValue:(int)firstLevel
{
	if(nil == sortArray)
	{
		sortArray = [[NSMutableArray alloc] init];
	}
	[sortArray removeAllObjects];


	switch (firstLevel) {
		// Pollinator
		case 1:
			secondLevelTitle = @"Select by Pollinator";

			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"pollinator_all.png",@"icon",@"All",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
						:@"pollinator_0.png",@"icon",@"Bees/Wasps",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
						:@"pollinator_1.png",@"icon",@"Butterflies/Moths",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
						:@"pollinator_2.png",@"icon",@"Hummingbirds",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
						:@"pollinator_3.png",@"icon",@"Bats",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
						:@"pollinator_4.png",@"icon",@"Beatles",@"string",nil]];
			
			break;
//		case 1:
//
//			secondLevelTitle = @"Select by Water Retention";
//			
//			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
//									  :@"water_0.png",@"icon",@"Dry",@"string",nil]];
//			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
//									  :@"water_1.png",@"icon",@"Moist",@"string",nil]];
//			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
//									  :@"water_2.png",@"icon",@"Dry to Moist",@"string",nil]];
//			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
//									  :@"water_3.png",@"icon",@"Flooded",@"string",nil]];
//			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
//									  :@"water_4.png",@"icon",@"Well Drained",@"string",nil]];
//		
//			break;
		case 2:
			secondLevelTitle = @"Select by Bloom Color";
			
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_all.png",@"icon",@"All",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_0.png",@"icon",@"White",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_1.png",@"icon",@"Yellow",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_2.png",@"icon",@"Orange",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_3.png",@"icon",@"Pink",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_4.png",@"icon",@"Red",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_5.png",@"icon",@"Purple",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_6.png",@"icon",@"Blue",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"color_7.png",@"icon",@"Green",@"string",nil]];

			break;
		case 3:
			secondLevelTitle = @"Select by Sunlight";
			
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"sunlight_all.png",@"icon",@"All",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"sunlight_0.png",@"icon",@"Sun",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"sunlight_1.png",@"icon",@"Partial Sun",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"sunlight_2.png",@"icon",@"Shade",@"string",nil]];


			break;
		case 4:
			secondLevelTitle = @"Select by Soiled Type";

			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_all.png",@"icon",@"All",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_0.png",@"icon",@"Acidic",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_1.png",@"icon",@"Clay",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_2.png",@"icon",@"Loam",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_3.png",@"icon",@"Rich",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_4.png",@"icon",@"Rocky",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_5.png",@"icon",@"Sandy",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_6.png",@"icon",@"Silty",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"soil_7.png",@"icon",@"Caliche",@"string",nil]];
			
			
			break;
		case 5:
			secondLevelTitle = @"Select by Plant Type";
			
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"plantType_All.png",@"icon",@"All",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"plantType_0.png",@"icon",@"Perennial",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"plantType_1.png",@"icon",@"Tree/Shrub",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"plantType_2.png",@"icon",@"Annual",@"string",nil]];
			[sortArray addObject:	 [[NSMutableDictionary alloc] initWithObjectsAndKeys
									  :@"plantType_3.png",@"icon",@"Vine",@"string",nil]];

			break;
		default:
			break;
	}

	if( nil != selectedArray)
	{
		int i=0;
		while (i < [sortArray count])
		{
			NSString *key = [[sortArray objectAtIndex:i]objectForKey:@"string"];
			BOOL b;
			if(0 == i)
				b = YES;
			else
				b = NO;

			[selectedArray addBool:key :b];
			i++;
		}
	}
}


- (void) initNavigation
{
	[super initNavigation];

	self.title = @"Plants";
}


- (void) initTable
{
	[super initTable];

	// init second level table
	CGRect frame = table.frame;
	frame.origin.y -= MAINSEG_MARGIN;
	frame.size.height -= (PLANT_DONE_HEIGHT-MAINSEG_MARGIN);
	secondTable = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
	[secondTable setDelegate:tableDelegate];
	[secondTable setDataSource:tableDelegate];
	secondTable.hidden = TRUE;
	[self.view addSubview:secondTable];

    CGRect buttonFrame = CGRectMake(PLANT_DONE_X,frame.origin.y+frame.size.height+PLANT_DONE_MARGIN,PLANT_DONE_WIDTH,PLANT_DONE_HEIGHT-PLANT_DONE_MARGIN*2);
	doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	//	UIButton  *button = [[UIButton ]initWithFrame:
	doneButton.frame = buttonFrame;
	[self.view addSubview: doneButton];
	[doneButton setTitle:@"Done" forState:UIControlStateNormal];
	[doneButton addTarget:self action:@selector(doneSelected:) forControlEvents:UIControlEventTouchUpInside];

//	resultDelegate = [[ResultTableDelegate alloc]init];
	resultTable    = [[UITableView alloc]initWithFrame:table.frame];
	resultTable.backgroundColor = colorBackground;
	[resultTable setDelegate:self];
	[resultTable setDataSource:self];
	resultDatas = [[SectionDatas alloc] init];
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[resultDatas setDataHandler:delegate.dataHandler];
	allDatas = secDatas;

//	[self.view addSubview:resultDelegate.table];
//	[resultDelegate initTable];
//	[resultDelegate initNavigation];
//	resultTable = resultDelegate.table;
	resultTable.hidden = TRUE;
	[self.view addSubview:resultTable];

	allSelectedArray = [[NSMutableArray alloc]init];
	int i;
	for(i=1; i<6; i++)
	{
		selectedArray = [[NSKeyBool alloc]init];
		[self setValue:i];
		[allSelectedArray addObject:selectedArray];
	}
	selectedArray = nil; // improve later
}




- (void) dealloc
{
	SAFE_RELEASE(backButton);
	SAFE_RELEASE(emptyLabel);
	SAFE_RELEASE(doneButton);
	SAFE_RELEASE(resultDatas);
	SAFE_RELEASE(resultTable);
	SAFE_RELEASE(resultDelegate);
	if(secondTable)
		[secondTable release];
	if(tableDelegate)
		[tableDelegate release];

	if(sortArray)
	{
		[sortArray removeAllObjects];
		[sortArray release];
	}
	if(allSelectedArray)
	{
		[allSelectedArray removeAllObjects];
		[allSelectedArray release];
	}
	if(selectedArray)
	{
		[selectedArray removeAll];
		[selectedArray release];
	}

	[super dealloc];
}


- (void) showAll
{
	[self onSelectSegmented:buttons[0]];
}


- (void) showByCondition:(NSArray*)array
{
	
}



- (void)viewWillAppear:(BOOL)animated
{
	if(navController.visibleViewController == self)
    	[navController setNavigationBarHidden:YES animated:NO];

	[super viewWillAppear:animated];
	
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(delegate.detailShowViewController.bFavoriteChanged)
	{

		if(!table.hidden)
		{
			[table reloadData];
		}
		else if(!resultTable.hidden)
		{
			[resultTable reloadData];
		}
		delegate.detailShowViewController.bFavoriteChanged = NO;
	}
}


- (NSKeyBool*) currentSelectedArray
{
	if(currentSegIndex > 0)
		return (NSKeyBool*)[allSelectedArray objectAtIndex:currentSegIndex-1];
	else
		return nil;
}


- (void)  resetSelectedStatus
{
	for(int n=0;n<5;n++)
	{
		NSKeyBool *boolArray = (NSKeyBool*)[allSelectedArray objectAtIndex:n];
		[self setValue:n+1];
		for(int m=0;m<[sortArray count]; m++)
		{
			NSString *key = [[sortArray objectAtIndex:m] objectForKey:@"string"];
			if(0 == m)
				[boolArray setBool:key :YES];
			else
				[boolArray setBool:key :NO];
		}
	}
}

#pragma mark 
#pragma mark - UI Operations

- (IBAction) onSelectSegmented: (id) sender{
	
	for(int i=0; i< COUNT_OF_HEADER_BUTTONS; i++)
	{
	    if(sender == buttons[i])
		{
			currentSegIndex = i;
			if( !buttons[i].selected || !resultTable.hidden || (emptyLabel && !emptyLabel.hidden)) // the other button
			{
				if(0 == i)
				{
					table.hidden = NO;
					secondTable.hidden = !table.hidden;
					resultTable.hidden = secondTable.hidden;
				//	[self.table reloadData];
					doneButton.hidden = YES;
					if(allDatas)
					{
						secDatas = allDatas;
					}
					[self resetSelectedStatus];
				}
				else 
				{
					[self setValue:i];
					table.hidden = YES;
					secondTable.hidden = NO;						
					resultTable.hidden = !secondTable.hidden;

					[secondTable reloadData];
					doneButton.hidden = NO;
					doneButton.selected = NO;
				}
				break;
			}
			
		}
	}

	if(emptyLabel)
	{
		emptyLabel.hidden = YES;
		backButton.hidden = YES;
	}
	[super onSelectSegmented: sender];

}


- (IBAction) doneSelected: (id) sender
{
	// adjust which are selected
	int i;
	int n;
	int m;
	NSMutableArray *comparedArray = [[NSMutableArray alloc] init];
	NSMutableArray *pair1Array = [[NSMutableArray alloc] init];
	NSMutableArray *pair2Array = [[NSMutableArray alloc] init];

	//just handle the items that are selected!
	//the string may be separated by '/'
	for(m=0;m<5;m++)
	{
		NSKeyBool *boolArray = (NSKeyBool*)[allSelectedArray objectAtIndex:m];
		for(i=1;i<boolArray.count; i++)
		{
			NSString *keySelected = [boolArray getStringByIndex:i];
			if([keySelected compare: @"All"] ==0)
				continue;

			if([boolArray getBool:keySelected]) // selected in UI
			{
				NSArray *keyItems = [keySelected componentsSeparatedByString:@"/"];
				if(keyItems.count > 1 && [keySelected compare:@"Tree/Shrub"] !=0 )
				{
					for(n=0; n<keyItems.count; n+=2)
					{
						[pair1Array addObject:[keyItems objectAtIndex:n]];
					}
					for(n=1; n<keyItems.count; n+=2)
					{
						[pair2Array addObject:[keyItems objectAtIndex:n]];
					}
				}
				else {
					[comparedArray addObject:keySelected ];
				}
			}
		}
	}
//	selectedArray = nil;
//	if(comparedArray.count == 0)
//	{
//		[comparedArray release];
//		return ;
//	}

	[resultDatas retrieveDataByBoolArray_OneSection:allDatas :comparedArray :pair1Array :pair2Array];
	secDatas = resultDatas;
	[resultTable reloadData];

	SAFE_RELEASE(comparedArray);
	SAFE_RELEASE(pair1Array);
	SAFE_RELEASE(pair2Array);
//	[self showAll];
	// set header button
	BOOL bDone = NO;
	for(m=0; m<5; m++)
	{
		NSKeyBool *boolArray = (NSKeyBool*)[allSelectedArray objectAtIndex:m];
		if(![boolArray getBool:@"All"])
		{
			bDone = YES;
			buttons[m+1].backgroundColor = colorBackground;
			buttons[m+1].selected = TRUE;
			[buttons[m+1] setBackgroundImage:nil forState:UIControlStateNormal];
				//			buttons[i].backgroundColor = color;
		}
		else{
			buttons[m+1].selected = FALSE;
			[buttons[m+1] setBackgroundImage :[UIImage imageNamed:@"header_back.png"] forState:UIControlStateNormal];
		}
	}
	
	if(bDone)
	{
		buttons[0].selected = NO;
		[buttons[0] setBackgroundImage :[UIImage imageNamed:@"header_back.png"] forState:UIControlStateNormal];
	}

	secondTable.hidden = YES;
	doneButton.hidden  = YES;
	doneButton.selected= YES;
	if([secDatas getCountInSection:0] > 0)
	{
		resultTable.hidden = NO;
	}
	else {
		if(nil == emptyLabel)
		{
			emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,100 ,SCREEN_WIDTH, 80)];
			[self.view addSubview:emptyLabel];
			emptyLabel.text = @"No plants match your query";
			emptyLabel.textColor = colorText;
			emptyLabel.backgroundColor = colorBackground;
			emptyLabel.adjustsFontSizeToFitWidth = YES;
			emptyLabel.textAlignment = UITextAlignmentCenter;
			
			backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			backButton.frame = doneButton.frame;
			[backButton setTitle:@"Back" forState:UIControlStateNormal];
			[backButton addTarget:self action:@selector(backFilters:) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:backButton];
		}
		emptyLabel.hidden = NO;
		backButton.hidden = NO;
	}

}


- (IBAction) backFilters:(id) sender
{
	[self onSelectSegmented:buttons[ currentSegIndex]];

//	emptyLabel.hidden = YES;
//	backButton.hidden = YES;
//	
//	secondTable.hidden= NO;
}

//#pragma mark 
//#pragma mark - TableView Delegate Implementation
//
//- (void)tableView:(UITableView *)tableView 
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	if(nil == delegate.detailShowViewController)
//	{
//		//	[listView setMode:indexPath.row-3];
//		DetailShowViewController *tmpController = [[DetailShowViewController alloc]init];
//		delegate.detailShowViewController = tmpController;
//		[tmpController release];
//	}
//	[self.navController setNavigationBarHidden:NO animated:NO];
//
//	//	[delegate updateCurrentData:indexPath];
//
//	if(self.navigationController.topViewController == self)
//	    [self.navigationController pushViewController :delegate.detailShowViewController animated:YES];
//
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];//the color will disappear
//}

//#pragma mark 
//#pragma mark - TableView Datasource Implementation

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//	if(tableView == table)
//	{
//		return [super numberOfSectionsInTableView:tableView];
//	}
//	
//	return 1;
//	
//}
//
////- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//////	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//////	return [delegate.dataHandler getSectionTitle:section];
////
////	return [secDatas getSectionTitle:section];
////}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	if(tableView == table)
//	{
//		return [table numberOfRowsInSection :section];
//	}
//	
//	return [sortArray count];
//}
//
////- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section// fixed font style. use custom view (UILabel) if you want something different
////{
////	return secondLevelTitle;
////}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	if(tableView == table)
//	{
//		return [table cellForRowAtIndexPath:indexPath];
//	}
//	
//	//	static NSString *RootViewControllerCell = @"RootViewControllerCell";
//	NSString *str=[NSString stringWithFormat:@"RootViewCon%d-%d",indexPath.section,indexPath.row];
//	SecondLevelCell *cell =(SecondLevelCell*) [tableView dequeueReusableCellWithIdentifier:str];
//	
//	// insure the cell exist, or create it
//    if (cell == nil) {
//		
//		cell = [[SecondLevelCell alloc] initWithFrame:CGRectZero reuseIdentifier:str];
//		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
//		
//		// init label
//		CGRect frame = CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.8, CELL_SECOND_LEVEL_HEIGHT);
//		frame.origin.x = SCREEN_WIDTH*0.2;
//		frame.origin.y = 0;
//		UILabel  *label = [[UILabel alloc]initWithFrame:frame];
//		label.text = [[sortArray objectAtIndex:indexPath.row] objectForKey:@"string"];
//		label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//		label.textColor = colorText;
//		label.backgroundColor = colorBackGround;
//		[cell addSubview:label];
//		[label release];
//		cell.label = label;
//	}
//	else {
//		//	[self updateCellValue:cell :indexPath];
//		cell.label.text = [[sortArray objectAtIndex:indexPath.row] objectForKey:@"string"];
//	}
//	
//	
//	
//    return cell;
//}
//


//
//#pragma mark 
//#pragma mark - TableView Delegate Implementation
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	if(tableView == table)
//	{
//		return BROWSE_CELL_HEIGHT;
////		return [super heightForRowAtIndexPath:tableView :indexPath];
//	}
//
//    return CELL_SECOND_LEVEL_HEIGHT;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//	if(tableView == table)
//	{
//		return -1;//[table heightForHeaderInSection:section];
//	}
//
//	return CELL_SECOND_LEVEL_HEIGHT;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
//{
//	if(tableView != secondTable)
//	{
//		return nil;// [table viewForHeaderInSection:section]
//	}
//
//	NSUInteger headerHeight = CELL_SECOND_LEVEL_HEIGHT;
//	UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
////	[headerView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:1.0f]];
//
//	UILabel *titleText = [[UILabel alloc]initWithFrame:headerView.frame];
//	titleText.text =  secondLevelTitle;
//	titleText.font = [UIFont boldSystemFontOfSize:20.0f];
//	titleText.textAlignment = UITextAlignmentCenter;
//	titleText.backgroundColor = colorBackGround;
//	titleText.textColor = colorText;//[UIColor blackColor];
//
//	[headerView addSubview:titleText];
//	
//	return headerView;
//}
//
//
//- (void)tableView:(UITableView *)tableView 
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{	
//	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	//	if(nil == delegate.detailShowViewController)
//	//	{
//	//		//	[listView setMode:indexPath.row-3];
//	//		DetailShowViewController *tmpController = [[DetailShowViewController alloc]init];
//	//		delegate.detailShowViewController = tmpController;
//	//		[tmpController release];
//	//
//	//	}
//	//	[browseNav setNavigationBarHidden:NO animated:NO];
//	//	[self.navigationController pushViewController :delegate.detailShowViewController animated:YES];
//	//	
//	//	//	[self goDetailShow];
//	//	
//	//	//	[delegate.currentController goNavigationController:browseNav 
//	//	//											controller:delegate.detailShowViewController];/*delegate.searchNav]*/;
//	
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];//the color will disappear
//}
//

@end
