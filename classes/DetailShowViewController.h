//
//  SearchViewController.h
//  Gardening
//
//  Created by maesinfo on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerBase.h"
#import "detailEmbededViewControl.h"
#import "dataHandler.h"
//#import "NoteViewController.h"



@class DetailShowView;
@class DetailShowViewController;

/*
 @interface SearchNavigation : UINavigationController
 {
 FoodSearch searchViewController;
 }
 
 @end
*/

@interface DetailShowViewController : ViewControllerBase
{


//	NoteViewController   *noteController;

	FusionTableData	   *currentRecord;
	float              y_image;
	float              height_image;
	// plant info
	//
	UIScrollView    *detailView;
	UILabel        *label_CommonlName;
	UILabel        *label_BotanicalName;
	UILabel        *label_BotanicalName2;
	UILabel        *label_BotanicalName3;
	UIImageView    *imageView_plant;

	UIButton        *favorite;
	UIView		    *infoBar;
	DetailLineView  *lineInfo[8];

	//
	BOOL           bStretchImage;
	BOOL           bFavoriteChanged;
	BOOL           bFormerFavorite;
}

@property (nonatomic) BOOL    bFavoriteChanged;



- (void) initLineInfos;
//-(IBAction) onSelectSegmented:(id)sender;

- (void) updateDetail:(NSString*)botanicalName;
- (void) updateView;
- (void) updateLines:(NSInteger) yStart;

- (CGRect) adjustImagePos:(float)y :(UIImage*)image; // get image frame

//
-(IBAction) onSelectFavorite:(id) sender;
- (IBAction) goPlantNote:(id)sender;

-(IBAction) goCreateNote:(id)sender;
-(IBAction) goMyNote:(id)sender;


@end
