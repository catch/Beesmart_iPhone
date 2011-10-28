//
//  unitControl.m
//  Gardening
//
//  Created by maesinfo on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "unitControl.h"


@implementation UnitControl

- (id)  initWithArgs:(CGRect)frame :(NSString*)imageDir :(NSString*)text :(SEL)function
{	
	[super initWithFrame:frame];

	//add image and text
	CGRect newFrame = frame;
	newFrame.origin.y = 0;
	newFrame.size.height = frame.size.height*0.8;
	newFrame.size.width  = newFrame.size.height;
	newFrame.origin.x = (frame.size.width - newFrame.size.width)/2;

	UIButton   *tempView = [[UIButton alloc] initWithFrame:newFrame];
	NSArray  *imgStrs = [imageDir componentsSeparatedByString:@"."];
	NSString *path = [[NSBundle mainBundle] pathForResource:[imgStrs objectAtIndex:0] ofType:[imgStrs objectAtIndex:1]];
	[tempView setImage: [UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
	[tempView addTarget:nil action:function forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:tempView];
//	[imgStrs release];
//	[path    release];
	[tempView release];

	//add text
	newFrame.origin.y = newFrame.size.height;
	newFrame.origin.x = 0;
	newFrame.size.height = frame.size.height - newFrame.origin.y;
	newFrame.size.width  = frame.size.width;
	UILabel *label= [[UILabel alloc]initWithFrame:newFrame];
	label.text = text;
	label.textAlignment      =  UITextAlignmentCenter; 
	[self addSubview:label];
	[label release];


	[self addTarget:nil action:function forControlEvents:UIControlEventTouchUpInside];
//	[self sendAction:function to:tempView forEvent:UIControlents];
	
	return self;
}


@end
