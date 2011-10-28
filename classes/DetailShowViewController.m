//
//  SearchViewController.m
//  Gardening
//
//  Created by maesinfo on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "DetailShowViewController.h"
#import "CatchNotesLauncher.h"

/*
 @implementation FoodSearch
 @synthesize listData;
 
 //@pragma mark Table view Methods
 - (void) viewDidLoad{
 NSArray *array=[[NSArray alloc]initWithObjects:@"Sleepy",
 @"Sneezy",@"Bashful",@"Happy",nil];
 self.listData = array;
 [array release];
 [super viewDidLoad];
 }
 
 -(void) didReceiveMemoryWarning{
 [super didReceiveMemoryWarning];	
 }
 
 -(void) dealloc{
 [listData release];
 [super dealloc];
 }
 
 // table view datasource methods
 
 -(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
 {
 return 2;	
 }
 
 -(NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
 {
 return [self.listData count];	
 }
 
 -(UITableViewCell*)tableView:(UITableView *)tableView
 cellForRowAtIndexPath:(NSIndexPath*)indexPath
 {
 static NSString *simpleTableIdentifier = @"S-T-I";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 if(cell == nil){
 cell = [[[UITableViewCell alloc]initWithFrame:CGRectZero
 reuseIdentifier: simpleTableIdentifier]autorelease];
 }
 NSUInteger row = [indexPath row];
 cell.text = [listData objectAtIndex:row];
 //	UIImage *image = [UIImage imageNamed:@"star.png"];
 //	cell.image = image;
 return cell;
 }
 
 -(NSInteger)tableView:(UITableView *)tableView
 indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSUInteger row =[indexPath row];
 
 return row;
 }
 
 @end
 */


#import "GardeningAppDelegate.h"



@implementation DetailShowViewController

@synthesize bFavoriteChanged;


-(void) initHeader
{
	
}

- (void) updateDetail:(NSString*)botanicalName
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	currentRecord = [delegate.dataHandler getFusionTableDataByName:botanicalName];
	[self updateView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)loadView {

	[super loadView];

	// navigation bar
	//	UIBarButtonItem  *btn = [[UIBarButtonItem alloc] initWithTitle:@"Note" style:UIBarButtonItemStylePlain target:self action:@selector(goPlantNote:)];
//	btn.backgroundColor = [UIColor blackColor];
//	[self.navigationController.navigationItem setRightBarButtonItem:btn animated:YES];
//	self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];// setRightBarButtonItem:btn animated:YES];

	
	CGRect frame = self.view.frame;
	frame.size.height -= (self.navigationController.navigationBar.frame.size.height+44);
	detailView = [[UIScrollView alloc]initWithFrame:frame];
	[self.view addSubview: detailView];

	float x_note=20;
	CGRect buttonFrame = CGRectMake(x_note,MAIN_VIEW_HEIGHT - 38 - self.navigationController.navigationBar.frame.size.height,SCREEN_WIDTH/2 - x_note*1.5,32);
	UIButton  *noteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	noteButton.frame = buttonFrame;
	[noteButton setTitle:@"Create Note" forState:UIControlStateNormal];
	[noteButton addTarget:self action:@selector(goCreateNote:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: noteButton];
//	[noteButton release];
	buttonFrame.origin.x = SCREEN_WIDTH/2 + x_note/2;
	noteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	noteButton.frame = buttonFrame;
	[noteButton setTitle:@"My Notes" forState:UIControlStateNormal];
	[noteButton addTarget:self action:@selector(goMyNote:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: noteButton];
	

	// init controls
	float x_start= 0;
	float y_start= 5;
	label_CommonlName = [[UILabel alloc]initWithFrame:CGRectMake(x_start, y_start, SCREEN_WIDTH, 32)];
	[detailView addSubview:label_CommonlName];
	label_CommonlName.textColor = self.colorText;
	label_CommonlName.font = [UIFont boldSystemFontOfSize:22.0f];
	label_CommonlName.textAlignment = UITextAlignmentCenter;
	label_CommonlName.adjustsFontSizeToFitWidth = YES;
	label_CommonlName.backgroundColor = self.colorBackground;

	y_start += label_CommonlName.frame.size.height;
	label_BotanicalName = [[UILabel alloc]initWithFrame:CGRectMake(x_start, y_start, SCREEN_WIDTH-x_start, 22)];
	[detailView addSubview:label_BotanicalName];
	label_BotanicalName.textColor = self.colorText;
	label_BotanicalName.textAlignment = UITextAlignmentCenter;
	label_BotanicalName.adjustsFontSizeToFitWidth = YES;
	label_BotanicalName.backgroundColor = self.colorBackground;
	label_BotanicalName.font = [UIFont italicSystemFontOfSize:18.0f];

	label_BotanicalName2 = [[UILabel alloc]initWithFrame:CGRectMake(x_start, y_start+22, SCREEN_WIDTH-x_start, 18)];
	[detailView addSubview:label_BotanicalName2];
	label_BotanicalName2.textColor = self.colorText;
	label_BotanicalName2.textAlignment = UITextAlignmentCenter;
	label_BotanicalName2.adjustsFontSizeToFitWidth = YES;
	label_BotanicalName2.backgroundColor = self.colorBackground;
	label_BotanicalName2.font = [UIFont boldSystemFontOfSize:16.0f];

	label_BotanicalName3 = [[UILabel alloc]initWithFrame:CGRectMake(x_start, y_start+18+22, SCREEN_WIDTH-x_start, 22)];
	[detailView addSubview:label_BotanicalName3];
	label_BotanicalName3.textColor = self.colorText;
	label_BotanicalName3.textAlignment = UITextAlignmentCenter;
	label_BotanicalName3.adjustsFontSizeToFitWidth = YES;
	label_BotanicalName3.backgroundColor = self.colorBackground;
	label_BotanicalName3.font = [UIFont italicSystemFontOfSize:18.0f];

	x_start += 50;
	y_start += label_BotanicalName.frame.size.height;
	y_image = y_start+5;
	imageView_plant = [[UIImageView alloc]initWithFrame:CGRectMake(x_start*2,y_start,SCREEN_WIDTH-x_start*4,100) ];
    [detailView addSubview:imageView_plant];

	[self initLineInfos];


	self.title = @"Detail";
	[self updateView];
	
	SAFE_RELEASE(memPool);
}

- (void) initLineInfos
{
//  add: Detail Info  Favorite
//       lineInfo
//       ...
//
	float lineHeight = 40;
	CGRect frame;
	frame.origin.y = y_image + imageView_plant.frame.size.height+10;
	frame.origin.x = 0;
	frame.size.width = SCREEN_WIDTH;
	frame.size.height = lineHeight;
	infoBar = [[UIView alloc] initWithFrame:frame];
	infoBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
	[detailView addSubview:infoBar];
	
	
	float favWidth = 32;
	float favHeight= 32;
	favorite = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -40, frame.origin.y+(lineHeight-favHeight)/2, favWidth, favHeight)];
	[favorite setImage:[UIImage imageNamed:@"favorite_button.png"] forState:UIControlStateNormal];
	[favorite setImage:[UIImage imageNamed:@"favorite_selected.png"] forState:UIControlStateSelected];
	[favorite addTarget:self action:@selector(onSelectFavorite:) forControlEvents:UIControlEventTouchUpInside];
	[detailView addSubview:favorite];
	
	
	CGRect labelFrame = frame;
	labelFrame.origin.y = 0;
	UILabel *infoLabel = [[UILabel alloc]initWithFrame:labelFrame];
	infoLabel.textColor = self.colorText;
	infoLabel.backgroundColor = infoBar.backgroundColor;
	infoLabel.font = [UIFont systemFontOfSize:22.0f];
	infoLabel.textAlignment = UITextAlignmentCenter;
	infoLabel.text = @"Plant Info";
	[infoBar addSubview:infoLabel];


	lineHeight *= 0.8;
	frame.origin.y = frame.origin.y + frame.size.height;
	frame.size.height = lineHeight ;

	UIColor *bgColor1 = [UIColor colorWithWhite:0.96 alpha:1.0f];
	UIColor *bgColor2 = [UIColor colorWithWhite:0.93 alpha:1.0f];


//	frame.origin.y += lineHeight;
	lineInfo[0]= [[DetailLineView alloc]initWithArgs:frame :@"seg0_.png" :self.colorText :bgColor1];
	frame.origin.y += lineHeight;
	lineInfo[1]= [[DetailLineView alloc]initWithArgs:frame :@"seg2_.png" :self.colorText :bgColor2];
	frame.origin.y += lineHeight;
	lineInfo[2]= [[DetailLineView alloc]initWithArgs:frame :@"seg3_.png" :self.colorText :bgColor1];
	frame.origin.y += lineHeight;
	lineInfo[3]= [[DetailLineView alloc]initWithArgs:frame :@"seg4_.png" :self.colorText :bgColor2];
	frame.origin.y += lineHeight;
	lineInfo[4]= [[DetailLineView alloc]initWithArgs:frame :@"seg5_.png" :self.colorText :bgColor1];
	frame.origin.y += lineHeight;
	lineInfo[5]= [[DetailLineView alloc]initWithArgs:frame :@"seg1_.png" :self.colorText :bgColor2];
	frame.origin.y += lineHeight;
	lineInfo[6]= [[DetailLineView alloc]initAsTextInfo:frame :@"Height:" :self.colorText :bgColor1];
	frame.origin.y += lineHeight;
	lineInfo[7]= [[DetailLineView alloc]initAsTextInfo:frame :@"Flower Season:" :self.colorText :bgColor2];

	int i=0;
	while(i<8)
	{
		[detailView addSubview:lineInfo[i]];
		i++;
	}

}

- (void) updateLines:(NSInteger) yStart
{
	// update pos and infos

	CGRect frame = infoBar.frame;
	int offset = yStart - frame.origin.y;
	frame.origin.y = yStart;
	infoBar.frame = frame;

	frame = favorite.frame;
	frame.origin.y += offset;
	favorite.frame = frame;
	int i=0;
	while (i<8)
	{
		frame = lineInfo[i].frame;
		frame.origin.y += offset;
		lineInfo[i].frame = frame;
		i++;
	}

	// update info
	NSMutableArray *titleArray = [[NSMutableArray alloc] init];
	[titleArray addObject:[NSArray arrayWithObjects:@"Bees",@"Wasps",@"Butterflies",@"Moths",@"Hummingbirds",@"Bats",@"Beetles",nil]];
	[titleArray addObject:[NSArray arrayWithObjects:@"White",@"Yellow",@"Orange",@"Pink",@"Red",@"Purple",@"Blue",@"Green",nil]];
	[titleArray addObject:[NSArray arrayWithObjects:@"Sun",@"Partial Sun",@"Shade",nil]];
	[titleArray addObject:[NSArray arrayWithObjects:@"Acidic",@"Clay",@"Loam",@"Rich",@"Rocky",@"Sandy",@"Silty",@"Caliche",nil]];
	[titleArray addObject:[NSArray arrayWithObjects:@"Perennial",@"Tree/Shrub",@"Annual",@"Vine",nil]];
	[titleArray addObject:[NSArray arrayWithObjects:@"Dry",@"Well-drained",@"Flooded",@"Moist/wet",nil]];

	NSString *result = [[NSString alloc]init];
	for(int i=0;i<titleArray.count;i++)
	{
		NSArray *array = [titleArray objectAtIndex:i];
		for(int j=0;j<array.count;j++)
		{
			if(currentRecord && [currentRecord->boolAttributes getBool:[array objectAtIndex:j]])
			{
				if([result length]>0)
				{
					result = [result stringByAppendingFormat:@", %@",[array objectAtIndex:j]];
				}
				else {
					result = [array objectAtIndex:j];
				}
			}
		}

		[lineInfo[i] update:result];
		result=@"";
	}

	[lineInfo[6] update:currentRecord->strHeight];
	[lineInfo[7] update:currentRecord->strFlowerSeason];
}


- (void) updateView
{
	if(!currentRecord)
		return;

	if(nil == label_CommonlName)
		return;

	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	label_CommonlName.text = [currentRecord->strPreferedCommonName capitalizedString];
	//ssp., spp., sp., var.  NSNotFound
	NSArray  *strArray = [NSArray arrayWithObjects:@" ssp.",@" spp.",@" sp.",@" var.",nil];
	int n;
	BOOL bFound=NO;
	for(n=0;n<strArray.count;n++)
	{
		NSString *str = [strArray objectAtIndex:n];
		NSRange range = [currentRecord->strBotanicalName rangeOfString:str];
		if(range.location != NSNotFound)
		{
			bFound = YES;
			// set text and new height
			NSRange rangeStr3;
			rangeStr3.location=0;
			rangeStr3.length = range.location;
			label_BotanicalName.text = [currentRecord->strBotanicalName substringWithRange:rangeStr3];
			label_BotanicalName2.text = str;
			rangeStr3.location = range.location + str.length;
			rangeStr3.length = currentRecord->strBotanicalName.length - range.location - range.length - 1;
			if(rangeStr3.location<currentRecord->strBotanicalName.length && rangeStr3.length > 0)
			{
				label_BotanicalName3.text = [currentRecord->strBotanicalName substringWithRange:rangeStr3];
			}
			else {
				label_BotanicalName3.text = @"";
			}

			label_BotanicalName2.hidden = NO;
			label_BotanicalName3.hidden = NO;

			y_image += label_BotanicalName2.frame.size.height;
			y_image += label_BotanicalName3.frame.size.height;
			break;
		}
	}
	if(!bFound)
	{
		label_BotanicalName.text = [currentRecord->strBotanicalName capitalizedString];
		label_BotanicalName2.hidden = YES;
		label_BotanicalName3.hidden = YES;
	}

	// set image
	NSString *localPath = [delegate.dataHandler.imageHandler getLocalPath:currentRecord->strBotanicalName];
	UIImage  *plantImage=nil;
	if(nil != localPath)
	{
		plantImage = [UIImage imageWithContentsOfFile:localPath];
	}
	if(plantImage)
	{
		[imageView_plant setImage:plantImage];
	}
	else
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"png"];
		plantImage = [UIImage imageWithContentsOfFile:path];
		[imageView_plant setImage: plantImage];
	}

	imageView_plant.frame = [self adjustImagePos:y_image :plantImage];

	if(currentRecord)
	{
		GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		if(isStringInArray(currentRecord->strBotanicalName, delegate.favoriteArray))
		{
			favorite.selected = YES;
		}
		else {
			favorite.selected = NO;
		}
	}
	bFormerFavorite = favorite.selected;
	bFavoriteChanged= NO;

	int yOffset=0;
	if(bFound)
	{
		yOffset = label_BotanicalName2.frame.size.height + label_BotanicalName3.frame.size.height;
	}
	[self updateLines:y_image + imageView_plant.frame.size.height + 10];
	
	
	if(bFound)
	{
		y_image -= label_BotanicalName2.frame.size.height;
		y_image -= label_BotanicalName3.frame.size.height;
	}
	
	
	detailView.contentSize = CGSizeMake(detailView.frame.size.width,lineInfo[7].frame.origin.y+100);

}


- (CGRect) adjustImagePos:(float)y :(UIImage*)image // get image frame
{
	CGRect frame;
	if(	image.size.width < DETAIL_IMAGE_MAX_LENGTH 
	   && image.size.height < DETAIL_IMAGE_MAX_LENGTH)
	{
		frame.size = image.size;
		frame.origin.x = (SCREEN_WIDTH - image.size.width)/2;
		frame.origin.y = y;
	}
	else if((image.size.width/DETAIL_IMAGE_MAX_LENGTH) 
			> (image.size.height/DETAIL_IMAGE_MAX_LENGTH) )
	{
		frame.size.width = DETAIL_IMAGE_MAX_LENGTH;
		frame.size.height= (DETAIL_IMAGE_MAX_LENGTH/image.size.width)*image.size.height;
		frame.origin.x = (SCREEN_WIDTH - DETAIL_IMAGE_MAX_LENGTH)/2;
		frame.origin.y = y;
	}
	else
	{
		frame.size.height = DETAIL_IMAGE_MAX_LENGTH;
		frame.size.width= (DETAIL_IMAGE_MAX_LENGTH/image.size.height)*image.size.width;
		frame.origin.x = (SCREEN_WIDTH - frame.size.width)/2;
		frame.origin.y = y;
	}

//	if(bStretchImage)
	{
		if((image.size.width/DETAIL_IMAGE_MAX_LENGTH) 
		   > (image.size.height/DETAIL_IMAGE_MAX_LENGTH) )
		{
			frame.size.height *= (DETAIL_IMAGE_MAX_LENGTH/frame.size.width);
			frame.size.width = DETAIL_IMAGE_MAX_LENGTH;
			frame.origin.x = (SCREEN_WIDTH - frame.size.width)/2;
		}
		else
		{
			frame.size.width *= (DETAIL_IMAGE_MAX_LENGTH/frame.size.height);
			frame.size.height = DETAIL_IMAGE_MAX_LENGTH;
			frame.origin.x = (SCREEN_WIDTH - frame.size.width)/2;
		}
	}

	height_image = frame.size.height;
	
	return frame;
}

// Called when the view is about to made visible. Default does nothing
//- (void)viewWillAppear:(BOOL)animated
//{
//	NSIndexPath *indexPath;
//	labelSelect[0].text = @"select";
//	labelSelect[1].text = @"select";
//	
//	if([listView1.selected count] > 0)
//	{
//		if([listView1.selected count] == 1)
//		{
//			indexPath = [listView1.selected objectAtIndex:0];
//			labelSelect[0].text  = [listView1.list objectAtIndex:indexPath.row];
//		}
//		else
//		{
//			NSInteger i=0;
//			NSString *tmp =[[[NSString alloc]init] autorelease];
//			
//			for(i=0;i<[listView1.selected count];i++)
//			{
//				if(i>0)
//				{
//					tmp =[labelSelect[0].text stringByAppendingString:@","];
//				}
//				indexPath = [listView1.selected objectAtIndex:i];
//				labelSelect[0].text  =[tmp stringByAppendingString:
//									   [listView1.list objectAtIndex:indexPath.row]];
//			}
//		}
//	}
//	
//	if([listView2.selected count] > 0)
//	{
//		if([listView2.selected count] == 1)
//		{
//			indexPath = [listView2.selected objectAtIndex:0];
//			labelSelect[1].text  = [listView2.list objectAtIndex:indexPath.row];
//		}
//	}
//}


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
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */



- (void)dealloc
{
	SAFE_RELEASE(favorite);
	SAFE_RELEASE(infoBar);
	SAFE_RELEASE(label_BotanicalName);
	SAFE_RELEASE(label_CommonlName);
	SAFE_RELEASE(imageView_plant);
	SAFE_RELEASE(detailView);
//	SAFE_RELEASE(noteController);
    [super dealloc];
}

//-(IBAction) onSelectSegmented:(id)sender
//{
//	segmentCtrl = (UISegmentedControl*)sender;
//	[detailEmbeded setMode:segmentCtrl.selectedSegmentIndex];
//	
//	if(segmentCtrl.selectedSegmentIndex == 0)
//	{
//		label.text = @"Photo and Infos";
//		detailEmbeded.hidden = FALSE;
//
//	}
//	else {
//		label.text = @"Note";
//		detailEmbeded.hidden = TRUE;
//	}
//
//}



-(IBAction) onSelectFavorite:(id) sender
{
	//[super on
	favorite.selected = !favorite.selected;
	if(currentRecord)
	{
		[self setFavoirte:currentRecord->strBotanicalName :favorite.selected];
	}
	
	if(favorite.selected != bFormerFavorite)
	{
		bFavoriteChanged = YES;
	}
	else {
		bFavoriteChanged = NO;
	}

}

- (IBAction) goPlantNote:(id)sender
{
//	if(nil == noteController)
//	{
//		noteController = [[NoteViewController alloc] init];
//	}
//	[noteController showNote:self];
}

-(IBAction) goCreateNote:(id)sender
{
	NSString *text = [NSString stringWithFormat:@"Prefered Common Name:%@\nBotanical Name:%@\nPollinator:%@\nColor:%@\nSunlight:%@\nSolid Type:%@\nPlant Type:%@\nWater:%@\nHeight:%@\nFlower Season:%@\n\n\n#BeeSmart",
					  currentRecord->strPreferedCommonName,currentRecord->strBotanicalName,
					  [lineInfo[0] getText],[lineInfo[1] getText],[lineInfo[2] getText],
					  [lineInfo[3] getText],[lineInfo[4] getText],[lineInfo[5] getText],
					  [lineInfo[6] getText],[lineInfo[7] getText]];

	[CatchNotesLauncher createNewNoteWithText:text cursorAt:0 
								 bounceOnSave:@"catched://catch-return/saved" 
							   bounceOnCancel:@"catched://catch-return/cancelled" 
						   fromViewController:self];
}

-(IBAction) goMyNote:(id)sender
{
	NSString *tag = @"BeeSmart";

	[CatchNotesLauncher showNotesWithTag:tag fromViewController:self];
}



@end

