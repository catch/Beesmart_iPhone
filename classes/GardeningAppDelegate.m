//
//  GardeningAppDelegate.m
//  Gardening
//
//  Created by maesinfo on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GardeningAppDelegate.h"
#import "GardeningViewController.h"

#import "CatchClient.h"
#import "StartViewController.h"


@implementation GardeningAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize	mainView;
@synthesize	currentController;
@synthesize	browseViewController;
@synthesize searchViewController;
@synthesize favoriteViewController;
@synthesize moreViewController;
@synthesize	detailShowViewController;
@synthesize zipController;
@synthesize	dashboardController;
@synthesize plantsController;
@synthesize mapController;


@synthesize dataHandler;
@synthesize	favoriteArray;
@synthesize favoriteChanged;
@synthesize zipCode;
@synthesize ecoregionNumber;
@synthesize versionString;



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	
//	
//	CatchClient *client = [[[CatchClient alloc] initWithAppName:@"Gardening" 
//														version:@"1.0.0" 
//															url:@"https://catch.com/"] autorelease];
//
//	@try {
//		// sign in
//		[client signIn:@"cyrys" password:@"888888"];
//		
//		// add a new note
//		CatchApiNote *note = [[[CatchApiNote alloc] initWithText:@"Hello World~~~###" location:nil] autorelease];
//		CatchApiNote *retNote = [client addNote:note];
//		//[note release];
//		NSArray *arr =[client getAllNoteRefs];
//		//CatchApiNoteRef *ref;
//		NSString *str;
//		for(CatchApiNoteRef *ref in arr)
//		{
//			str = ref.noteId;
//			NSLog(str);
//		}
//		//		NSString *str = note.noteId;
//		//		[str retain];
//		NSArray *noteArray = [client getNotesForNoteIds:[NSArray arrayWithObject: retNote.noteId]];
//		CatchApiNote *newNote = [noteArray objectAtIndex:0];
//		newNote.text = @"FFFAAEE";
//		[client forceUpdateNote:newNote];
//	}
//	@catch (NSException *exception) {
//		NSLog(@"Error: %@", [exception reason]);
//	}
	// Override point for customization after application launch.
    // Add the view controller's view to the window and display.

	UIView* tmpMainView = [[UIView alloc]initWithFrame:
						   CGRectMake(MAIN_VIEW_POINT_X, STATUS_BAR_HEIGHT, SCREEN_WIDTH, MAIN_VIEW_HEIGHT) ] ;//] - TOOLBAR_HEIGHT)];
	self.mainView = tmpMainView;
	[tmpMainView release];
	[self.window addSubview:self.mainView];

//	StartViewController *controller = [[StartViewController alloc]init];
//	[self.mainView addSubview:controller.view];

	
	// init first view
	[self unarchive:ARCHIVE_ZIPCODE];

	if(nil == zipCode)
	{
		ZipViewController  *firstController = [[ZipViewController alloc]init];
		self.zipController = firstController;
		[firstController release];
		[self.mainView addSubview:zipController.view];
		self.currentController = zipController;
	}
	else {
		DashboardViewController  *tempController = [[DashboardViewController alloc] init];
		self.dashboardController = tempController;
		[tempController release];
		[self.mainView addSubview:dashboardController.view];
		self.currentController = dashboardController;
	}

//	SAFE_RELEASE(controller);

	
	[self checkVersion];
	[self unarchive:ARCHIVE_FAVORITE];
	dataHandler = [[DataHandler alloc]init];
	[dataHandler requestFusionData];
	

	[self.window makeKeyAndVisible];

    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	// ANDREAS: After user saves or cancels in Catch Notes, you end up back here with 
	// either catchhaj://catch-return/saved or catchhaj://catch-return/cancelled
	NSLog(@"\n******************** handleOpenURL");
	if ([[url scheme] isEqualToString:@"catched"]) {
		
		if ([[url path] isEqualToString:@"/saved"]) {
			// DO SOMETHING
			NSLog(@"\n **************** application:saved");
		} else if ([[url path] isEqualToString:@"/cancelled"]) {
			// DO SOMETHING ELSE
			NSLog(@"\n **************** application:cancelled");
		}
		
		return YES;
	}

	return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	//[self archiveFavorite];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    /*
//     Called when the application is about to terminate.
//     See also applicationDidEnterBackground:.
//     */
//	
////	[self archive:ARCHIVE_FAVORITE];
//
//	if(favoriteArray)
//		[favoriteArray release];
//}




- (NSString*) fileDir
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) 
			objectAtIndex:0];
	
}



- (void) archive:(NSInteger)archiveType
{
	NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	switch (archiveType)
	{
		case ARCHIVE_VERSION:
			
			[NSKeyedArchiver archiveRootObject:versionString 
										toFile: [docDir stringByAppendingPathComponent:FILENAME_VERSION]];
			break;
		case ARCHIVE_FUSIONSTRINGS:
		{
			NSString *str;
			if(nil == dataHandler)
			{
				str = @"";
			}else {
				str = dataHandler.archivedData;
			}

			[NSKeyedArchiver archiveRootObject:str 
										toFile: [docDir stringByAppendingPathComponent:FILENAME_FUSIONSTRING]];
		}
			break;

		case ARCHIVE_FAVORITE:

			[NSKeyedArchiver archiveRootObject:favoriteArray 
										toFile: [docDir stringByAppendingPathComponent:FILENAME_FAVORITE]];
			favoriteChanged = YES;
			break;
		case ARCHIVE_ZIPCODE:
			
			[NSKeyedArchiver archiveRootObject:zipCode 
										toFile: [docDir stringByAppendingPathComponent:FILENAME_ZIPCODE]];
			break;
		default:
			break;
	}
}

- (void) unarchive:(NSInteger)archiveType
{
	NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	switch (archiveType)
	{
		case ARCHIVE_VERSION:
			
			self.versionString = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_VERSION]];
		
			break;
		case ARCHIVE_FUSIONSTRINGS:

			dataHandler.archivedData = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_FUSIONSTRING]];
			if( dataHandler.archivedData == nil)
			{
				NSString *tmpStr = [[NSString alloc]init];
				dataHandler.archivedData = tmpStr;
				[tmpStr release];
			}
			break;

		case ARCHIVE_FAVORITE:
			favoriteArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_FAVORITE]];
			[favoriteArray retain];
			if( favoriteArray == nil)
			{
				NSMutableArray  *arr = [[NSMutableArray alloc]init];
				self.favoriteArray = arr;
				[arr release];
			}
			break;
		case ARCHIVE_ZIPCODE:
			self.zipCode = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_ZIPCODE]];
//			if( favoriteArray == nil)
//			{
//				NSMutableArray  *arr = [[NSMutableArray alloc]init];
//				self.favoriteArray = arr;
//				[arr release];
//			}
			break;
		default:
			break;
	}
}

- (void) updateZipcode:(NSString*)text
{
	self.zipCode = text;
	[self archive:ARCHIVE_ZIPCODE];

	//get ecoregion number
	ecoregionNumber = [self getEcoNumber:zipCode];
}

- (NSString*) getEcoNumber:(NSString*)zipcode
{
	return @"M212";
}

- (void) updateTableView
{
//	if(self.currentController == self.browseViewController)
//	{
	if(plantsController)
		[self.plantsController reloadTable];
//	}
//	else if(self.currentController == self.favoriteViewController)
//	{
	if(favoriteViewController)
		[self.favoriteViewController reloadTable];
//	}
//	else if(self.currentController == self.searchViewController)
//	{
	if(searchViewController)
		[self.searchViewController reloadTable];
//	}
}

- (void) showDashboard
{
	if(nil == dashboardController)
	{
		DashboardViewController  *tempController = [[DashboardViewController alloc] init];
		self.dashboardController = tempController;
		[tempController release];
	}

	[self.dashboardController showView:self.currentController];
}

- (void) checkVersion
{
	[self unarchive:ARCHIVE_VERSION];
	if(!versionString || [versionString compare:CURRENT_VERSION]!=0) 
	{
		[self deleteDataFiles];
	}
}

-(void) deleteDataFiles
{
	//delete fusionstring file,picture files
	bDeleteDataFiles = YES;
	NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

	NSFileManager *fileManager=[NSFileManager defaultManager];
	[fileManager setDelegate:self];
	NSError *err;

	NSArray *files = [fileManager contentsOfDirectoryAtPath:docDir error:&err];
//	[fileManager removeItemAtPath:docDir error:&err];

//	NSArray *files = [fileManager directoryContentsAtPath:docDir];
	for(int n=0;n<[files count];n++)
	{
		if([(NSString*)[files objectAtIndex:n] compare:FILENAME_ZIPCODE] ==0
		   ||[(NSString*)[files objectAtIndex:n] compare:FILENAME_FAVORITE] ==0)
		{
			continue;
		}
		[fileManager removeItemAtPath:[docDir stringByAppendingPathComponent:(NSString*)[files objectAtIndex:n]] error:&err];
	}
}

//- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtPath:(NSString *)path
//{
//	if(bDeleteDataFiles)
//	{
//		NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//		if(0== [path compare:docDir]
//		   || 0== [path compare:[docDir stringByAppendingPathComponent:FILENAME_ZIPCODE]]
//		   || 0== [path compare:[docDir stringByAppendingPathComponent:FILENAME_FAVORITE]])
//		{
//			return NO;
//		}
//	}
//	
//	return YES;
//}

//-(void) encodeWithCoder:(NSCoder *)aCoder
//{
//	[aCoder encodeObject:self.favoriteArray forKey:KEY_FAVORITE];
//}
//
//- (id) initWithCoder:(NSCoder *)aDecoder
//{
//	if(self = [super  init])
//	{
//		self.favoriteArray = [aDecoder decodeObjectForKey:KEY_FAVORITE];
//	   
//	}
//	   
//	return self;
//}




#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {

//	[favoriteArray release];
	SAFE_RELEASE(zipCode);
	SAFE_RELEASE(mapController);
	[zipController release];
	[dataHandler release];
	[currentController release];
	[moreViewController release];
	[favoriteViewController release];
    [browseViewController release];
	[searchViewController release];
	[viewController release];
    [window release];
    [super dealloc];
}


@end
