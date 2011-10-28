//
//  SearchViewController.h
//  Gardening
//
//  Created by maesinfo on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowseTableViewController.h"
#import "searchResultViewController.h"

#define HEIGHT_LISTCELL 50

//@class SearchViewController;


/*
 @interface SearchNavigation : UINavigationController
 {
 FoodSearch searchViewController;
 }
 
 @end
 */

@interface SearchViewController : BrowseTableViewController<UITextFieldDelegate>
//<UITableViewDelegate,UITableViewDataSource>
{
//	UITableView *table;
//    NSArray *labelData;
	UITextField  *inputSearch;
//	UINavigationController        *navSearch;


}

//@property (nonatomic, retain) UINavigationController *navSearch;



-(IBAction) hideKeyboard:(id)sender;


-(IBAction)doSearch:(id)sender;
-(IBAction) onSearchValueChanged:(id)sender;

@end
