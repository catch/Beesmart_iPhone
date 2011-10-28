//
//  StartViewController.m
//  Gardening
//
//  Created by maesinfo on 10/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartViewController.h"


@implementation StartViewController

- (void) loadView
{
	[super loadView];
	
	UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, MAIN_VIEW_HEIGHT/2, SCREEN_WIDTH, 80)];
	label.text = @"loading...";
	label.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:label];
	[label release];
}

@end
