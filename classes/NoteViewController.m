//
//  NoteViewController.m
//  Gardening
//
//  Created by maesinfo on 10/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NoteViewController.h"
#import "GardeningAppDelegate.h"
#import "QuartzCore/QuartzCore.h"
//#import "QuartzCore/CATransition.h"


@implementation NoteViewController

-(void) showNote:(ViewControllerBase*)controller
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	CATransition *animation = [CATransition animation];   
	[animation setDuration:.25f];   
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];  
	[animation setType:kCATransitionMoveIn];//动画类型
	animation.subtype = kCATransitionFromTop;   /* 动画方向*/
	[self.view.layer addAnimation:animation forKey:@"movein"];

	[controller viewWillDisappear: YES];
	[self viewWillAppear: YES];
	[controller.view removeFromSuperview];
	[delegate.mainView addSubview: self.view];
	[controller viewDidDisappear: YES];
	[self viewDidAppear: YES];
}

@end
