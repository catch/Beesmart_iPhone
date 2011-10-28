//
//  detailEmbededViewController.h
//  Gardening
//
//  Created by maesinfo on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerBase.h"

@interface DetailLineView : UIScrollView
{
	UILabel *info;
}

- (id) initWithArgs:(CGRect)externalFrame :(NSString*)iconName :(UIColor*)textColor :(UIColor*)bgColor;
-(id)initAsTextInfo:(CGRect)externalFrame :(NSString*)titleText :(UIColor*)textColor :(UIColor*)bgColor;

- (void) update:(NSString*)text;
- (NSString*) getText;

@end



enum{
	DETAIL_EMBEDED_INFO = 0,
	DETAIL_EMBEDED_NEIGHBOR,
	DETAIL_EMBEDED_HABIT,
	NUM_OF_DETAIL_EMBEDED
};

// 1. establish UI
// 2. interact with the data

@interface DetailEmbededViewControl : UIControl<UITableViewDataSource,UITableViewDelegate> {

	//info
	UIImageView    *infoImage;
	UIButton       *infoIconButton;
	UITableView    *infoTable;

	//neighbor
	UITableView    *neighborTable;

//	FusionTableData *record;
	//habit: the controls are the same as info
	
}

- (void) initControls:(int)mode;
- (void) releaseControls:(int)mode;
- (void) setMode:(int)mode;



// UI Events
- (IBAction) goInfoTable:(id)sender;

@end
