//
//  SortedViewController.h
//  Gardening
//
//  Created by maesinfo on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerBase.h"
#import "BrowseViewController.h"

@interface UIImageButton : UIImageView
{
	BOOL selected;
	UIImage *imageNormal;
	UIImage *imageSelected;
}

@property (nonatomic,readonly) BOOL selected;


-(void) initImages:(UIImage*)normal :(UIImage*)seled;
-(void) setState:(BOOL)bSelected;


@end


@interface SecondTableDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>
{

	UIImage  *iconNormal;
	UIImage  *iconSelected;
}

- (BOOL) allCellEmpty:(UITableView *)tableView;
- (void) emptyAllOtherCells:(UITableView *)tableView;

@end


@interface ResultTableDelegate : BrowseTableViewController//<UITableViewDelegate,UITableViewDataSource>
{
	
}

@end

//
//@interface SortedListTableDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>
//{
//	
//}
//
//@end




@interface SecondLevelCell : UITableViewCell
{
	UILabel *label;
	UIImageView *imageView;
	UIImageButton    *selectionIcon;
}

@property (nonatomic,retain) UILabel *label;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIImageButton *selectionIcon;

@end



@interface PlantsViewController : BrowseViewController
{
	UITableView     *secondTable;
	UITableView     *resultTable;
	SectionDatas    *allDatas;
	SectionDatas    *resultDatas;
	UIButton        *doneButton;
	SecondTableDelegate *tableDelegate;
	ResultTableDelegate *resultDelegate;
	NSString        *secondLevelTitle;

	NSUInteger      currentSegIndex;
	NSMutableArray	*sortArray;
	NSKeyBool       *selectedArray;
	NSMutableArray  *allSelectedArray;
	NSKeyBool       *allSelectedBool;
	
	UILabel         *emptyLabel;
	UIButton        *backButton;
}

@property (nonatomic,readonly) NSString  *secondLevelTitle;
@property (nonatomic,readonly) NSMutableArray	*sortArray;
//@property (nonatomic,readonly) NSKeyBool	*selectedArray;


- (void) setValue:(int)firstLevel;

- (IBAction) onSelectSegmented: (id) sender;
- (IBAction) doneSelected: (id) sender;
- (IBAction) onRefresh:(id) sender;
- (IBAction) backFilters:(id) sender;

- (void) showAll;
- (void) showByCondition:(NSArray*)array;

- (NSKeyBool*) currentSelectedArray;
- (void)  resetSelectedStatus;

@end
