//
//  GardeningAppDelegate.h
//  Gardening
//
//  Created by maesinfo on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuration.h"
#import "ViewControllerBase.h"
#import "BrowseViewController.h"
#import "SearchViewController.h"
#import "FavoriteViewController.h"
#import "MoreViewController.h"
#import "DetailShowViewController.h"
#import "ZipViewController.h"
#import "DashboardViewController.h"
#import "PlantsViewController.h"
//#import "TableView.h"
#import "dataHandler.h"
#import "EcoregionMapController.h"


// symbols for NSCoding
#define FILENAME_FAVORITE @"favorites.dat"
#define FILENAME_FUSIONSTRING @"FusionStrings.dat"
#define FILENAME_ZIPCODE  @"zipCode.dat"
#define FILENAME_VERSION  @"version.dat"

enum{
	ARCHIVE_VERSION,
	ARCHIVE_FUSIONSTRINGS ,
	ARCHIVE_FAVORITE,
	ARCHIVE_ZIPCODE,
};



@class GardeningViewController;



@interface GardeningAppDelegate : NSObject 
<UIApplicationDelegate> 
{
    UIWindow *window;
    GardeningViewController *viewController;

	UIView						  *mainView;
	ViewControllerBase			  *currentController;
	BrowseViewController		  *browseViewController;
	SearchViewController          *searchViewController;
	FavoriteViewController        *favoriteViewController;
	MoreViewController            *moreViewController;
 	DetailShowViewController	  *detailShowViewController;
	ZipViewController             *zipController;
	DashboardViewController       *dashboardController;
	PlantsViewController          *plantsController;
	EcoregionMapController        *mapController;
	
	
	DataHandler					  *dataHandler;
	NSMutableArray                *favoriteArray;
	BOOL						  favoiriteChanged;
	NSString                      *zipCode;
	NSString                      *ecoregionNumber;
	NSString                      *versionString;
	BOOL						  bDeleteDataFiles;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GardeningViewController *viewController;
@property (nonatomic, retain) UIView						*mainView;
@property (nonatomic, retain) ViewControllerBase			*currentController;
@property (nonatomic, retain) BrowseViewController			*browseViewController;
@property (nonatomic, retain) SearchViewController			*searchViewController;
@property (nonatomic, retain) FavoriteViewController        *favoriteViewController;
@property (nonatomic, retain) MoreViewController            *moreViewController;
@property (nonatomic, retain) DetailShowViewController		*detailShowViewController;
@property (nonatomic, retain) ZipViewController			    *zipController;
@property (nonatomic, retain) DashboardViewController       *dashboardController;
@property (nonatomic, retain) PlantsViewController          *plantsController;
@property (nonatomic, retain) EcoregionMapController        *mapController;


//@property (nonatomic, retain) TableView						*tableView;
//@property (nonatomic, retain) TableView						*favoriteTableView;

@property (nonatomic, retain) DataHandler					*dataHandler;
@property (nonatomic, retain) NSMutableArray				*favoriteArray;
@property (nonatomic, readonly) NSString      				*ecoregionNumber;
@property (nonatomic, retain) NSString      				*zipCode;
@property (nonatomic, retain) NSString      				*versionString;
@property (nonatomic) BOOL                                  favoriteChanged;


- (void) checkVersion;

- (NSString*) fileDir;

- (void) archive:(NSInteger)archiveType;
- (void) unarchive:(NSInteger)archiveType;
- (void) deleteDataFiles;

- (void) updateZipcode:(NSString*)text;
- (NSString*) getEcoNumber:(NSString*)zipcode;
- (void) updateTableView;

// common methods
- (void) showDashboard;


@end

