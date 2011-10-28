//
//  FoodInfoShowView.h
//  MovePictureTest
//
//  Created by maesinfo on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuration.h"
#import "ViewBase.h"

typedef enum _ShowMode
{
	IMAGEVIEWMODE =0,
	ASSRESSVIEWMODE,
	INFORMATIONVIEWMODE,
	MODENUM
}ShowMode;

@interface FoodInfoShowView : ViewBase {
	UIImageView* imageView;
	UILabel* addressView;
	UILabel* informationView;
	UIView* extensionView;
	UILabel* priceView;
	UILabel* tasteView;
	TransitionDirection direction;
	CGPoint startTouchPoint;
	ShowMode mode;
	NSString* information;
	NSString* address;
}

@property(nonatomic ,retain) UIImageView* imageView;
@property(nonatomic, retain) UILabel* addressView;
@property(nonatomic, retain) UILabel* informationView;
@property(nonatomic, retain) UILabel* priceView;
@property(nonatomic, retain) UILabel* tasteView;
@property(nonatomic, retain) UIView* extensionView;
@property(nonatomic, retain) NSString* information;
@property(nonatomic, retain) NSString* address;

- (FoodInfoShowView*) initInfoShowView;
- (FoodInfoShowView*) initContent;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) dealloc;

@end
