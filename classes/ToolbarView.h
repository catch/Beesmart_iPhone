//
//  ToolbarView.h
//  Gardening
//
//  Created by maesinfo on 11-8-2.
//  Copyright 2011 MaesInfo Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ToolBarButton : UIButton
{
	UILabel *bottomLabel;
	UIImageView *topImage;

	float   bgRed;
	float   bgGreen;
	float   bgBlue;
	float   bgRed_Selected;
	float   bgGreen_Selected;
	float   bgBlue_Selected;

}

@property(nonatomic,retain) UILabel *bottomLabel;
@property(nonatomic,retain) UIImageView *topImage;

-(void) setSelected:(bool)bSelected;
-(void) dealloc;

@end



@interface ToolbarView : UIToolbar{
	NSMutableArray* toolbarViews;
	int indexSelected;
	

	float   textRed;
	float   textGreen;
	float   textBlue;
}

@property (nonatomic, retain) NSMutableArray* toolBarItems;

- (void)  willInit;
- (ToolbarView*) initToolbar;
- (void) initToolbarItem:(NSInteger)pos :(SEL)itemAction :(NSString*)imagefile :(NSString*)image_selected :(NSString*)title;

- (bool) setSelectedUI:(int)index;
- (void) enabledAll:(bool)bEnabled;

-(IBAction) goBrowseView:(id)sender;
-(IBAction) goSearchView:(id)sender;
-(IBAction) goFavoriteView:(id)sender;
-(IBAction) goMoreView:(id)sender;

- (void) dealloc;

//- (void) buttonEnable:(int) index;
//- (void) buttonDisable:(int) index;
//
//- (IBAction) backPreviousView: (id) sender;
//- (IBAction) gotoMainView: (id) sender;
//- (IBAction) gotoSearchView: (id) sender;
//- (IBAction) gotoFavoriteView: (id) sender;

@end
