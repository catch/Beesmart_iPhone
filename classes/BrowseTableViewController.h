//
//  BrowseTableView.h
//  Gardening
//
//  Created by maesinfo on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerBase.h"
#import "dataHandler.h"




@interface FavoriteButton :UIButton
{
	NSInteger  itemSection;
	NSInteger  itemIndex;
}

@property(nonatomic) NSInteger  itemIndex;
@property(nonatomic) NSInteger  itemSection;


@end





@interface UIBrowseCell : UITableViewCell
{
	UIImageView *imageView;
	UILabel   *label1;
	UILabel   *label2;
	FavoriteButton  *buttonFavorite;
}

-(void) dealloc;

@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UILabel   *label1;
@property (nonatomic,retain) UILabel   *label2;
@property (nonatomic,retain) FavoriteButton  *buttonFavorite;

@end



@interface BrowseTableViewController : ViewControllerBase 
<UITableViewDelegate,UITableViewDataSource>
{
	UITableView    *table;
	NSMutableArray *recordArray;          // store the records by key(botanical name)
	
	NSInteger      beginHeight;
	
	float          separateWhite;

	// storage the index for datahandler
//	NSMutableArray *currentItems;
	SectionDatas   *secDatas;
}

@property (nonatomic,retain) UITableView    *table;
@property (nonatomic,retain) NSMutableArray *recordArray;
@property (nonatomic)   NSInteger      beginHeight;
//@property (nonatomic)   SectionDatas  *secDatas;


- (void) willInit;
- (void) initTable;
- (void) reloadTable;

- (UIBrowseCell *)  initPlantCell:(NSIndexPath*)indexPath :(NSString*)strIdentifier;
- (void) initFavoriteButton:(UIButton*)button  :(NSString*)strName;
- (void) updateCellValue:(UIBrowseCell *)cell :(NSIndexPath*)indexPath;

- (IBAction) switchFavorite: (id) sender;


- (void) showDetailView:(NSString*) bonanticalName;

@end
