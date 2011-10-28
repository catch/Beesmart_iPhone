//
//  FoodInfoShowView.m
//  MovePictureTest
//
//  Created by maesinfo on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FoodInfoShowView.h"

@implementation FoodInfoShowView

@synthesize imageView;
@synthesize addressView;
@synthesize informationView;
@synthesize extensionView;
@synthesize information;
@synthesize address;
@synthesize priceView;
@synthesize tasteView;

- (FoodInfoShowView*) initInfoShowView
{
	[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAIN_VIEW_HEIGHT - TOOLBAR_HEIGHT)];
	
	mode = IMAGEVIEWMODE;
	int height = MAIN_VIEW_HEIGHT - EXTENSIONVIEWHEIGHT;
	UIImageView* tmpImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, height)];
	self.imageView = tmpImageView;
	self.imageView.image = [UIImage imageNamed:@"1.png"];
	[self addSubview:self.imageView];
	[tmpImageView release];
	
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, height)];
	self.addressView = label;
	[label release];
	self.addressView.lineBreakMode = UILineBreakModeWordWrap;
	[self.addressView setText:@"address Viewgg gggggggggggg ggggggg ggggggggggggggggggggggggggggggggggg"];
	self.addressView.numberOfLines =0;
	[self addSubview:self.addressView];

	UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, height)];
	self.informationView = label1;
	[label1 release];
	self.informationView.lineBreakMode = UILineBreakModeWordWrap;
	[self.informationView setText:@"information Viewgg gggggggggggg ggggggg ggggggggggggggggggggggggggggggggggg"];
	self.informationView.numberOfLines =0;	
	[self addSubview:self.informationView];
		
	UIView* tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH,EXTENSIONVIEWHEIGHT)];
	self.extensionView = tmpView;
	[self addSubview:self.extensionView];
	[tmpView release];
	
	int x = (SCREEN_WIDTH - PRICEVIEWWIDTH - TASTEVIEWWIDTH - DISTANCE_BETWEEN_LABEL)/2;
	int y = height + (EXTENSIONVIEWHEIGHT - LABELWHEIGHT)/2;
	CGRect rect = CGRectMake(x, y, PRICEVIEWWIDTH, LABELWHEIGHT);
	UILabel* label2 = [[UILabel alloc] initWithFrame:rect];
	self.priceView = label2;
	[self.priceView setText:@"price"];
	[self addSubview:self.priceView];
	[label2 release];
	
	x = SCREEN_WIDTH - PRICEVIEWWIDTH - DISTANCE_BETWEEN_LABEL;
	y = height + (EXTENSIONVIEWHEIGHT - LABELWHEIGHT)/2;
	rect = CGRectMake(x, y, TASTEVIEWWIDTH, LABELWHEIGHT);
	UILabel* label3 = [[UILabel alloc] initWithFrame:rect];
	self.tasteView = label3;
	[self.tasteView setText:@"taste"];
	[self addSubview:self.tasteView];
	[label3 release];
	return self;
}

- (FoodInfoShowView*) initContent
{
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	startTouchPoint = [touch locationInView: self];
	direction = TRANSITIONNONE;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint currentTouchPoint = [touch locationInView: self];
	
	int tmp = fabsf(startTouchPoint.x - currentTouchPoint.x);
	int tmp2 = fabsf(startTouchPoint.y - currentTouchPoint.y);
	NSLog(@"between is %d  %d", tmp, tmp2);	
	if(fabsf(startTouchPoint.x - currentTouchPoint.x) >= HORIZ_SWIPE_DRAG_MIN
	   && fabsf(startTouchPoint.y - currentTouchPoint.y) <= VERT_SWIPE_DRAG_MAX)
	{
		if(startTouchPoint.x < currentTouchPoint.x)
		{
			direction = TRANSITIONRIGHT;
		}
		else
		{
			direction = TRANSITIONLEFT;
		}
	}
	
	else if(fabsf(startTouchPoint.y - currentTouchPoint.y) >= VERT_SWIPE_DRAG_MIN
			&& fabsf(startTouchPoint.x - currentTouchPoint.x) <= HORIZ_SWIPE_DRAG_MAX)
	{
		if(startTouchPoint.y < currentTouchPoint.y)
		{
			direction = TRANSITIONBOTTOM;
		}
		else
		{
			direction = TRANSITIONUP;
		}
	}
	else 
	{
		direction = TRANSITIONNONE;
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(direction == TRANSITIONRIGHT)
	{
		if(mode == INFORMATIONVIEWMODE)
		{
			return;
		}
		
		CGContextRef context = UIGraphicsGetCurrentContext();
		[UIView beginAnimations:nil context:context];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView	setAnimationDuration:0.5];
			
		CGRect rect= self.informationView.frame;
		rect.origin.x += SCREEN_WIDTH;
		[self.informationView setFrame:rect];
		rect= self.imageView.frame;
		rect.origin.x += SCREEN_WIDTH;
		[self.imageView setFrame:rect];	
		rect= self.addressView.frame;
		rect.origin.x += SCREEN_WIDTH;
		[self.addressView setFrame:rect];	
		if(mode == ASSRESSVIEWMODE)
		{
			mode = IMAGEVIEWMODE;
		}
		else if (mode == IMAGEVIEWMODE)
		{
			mode = INFORMATIONVIEWMODE;
		}
	}
	else if(direction == TRANSITIONLEFT)
	{
		if(mode == ASSRESSVIEWMODE)
		{
			return;
		}
		
		CGContextRef context = UIGraphicsGetCurrentContext();
		[UIView beginAnimations:nil context:context];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView	setAnimationDuration:0.5];
		
		CGRect rect= self.informationView.frame;
		rect.origin.x -= SCREEN_WIDTH;
		[self.informationView setFrame:rect];
		rect= self.imageView.frame;
		rect.origin.x -= SCREEN_WIDTH;
		[self.imageView setFrame:rect];	
		rect= self.addressView.frame;
		rect.origin.x -= SCREEN_WIDTH;
		[self.addressView setFrame:rect];	
		if(mode == INFORMATIONVIEWMODE)
		{
			mode = IMAGEVIEWMODE;
		}
		else if (mode == IMAGEVIEWMODE)
		{
			mode = ASSRESSVIEWMODE;
		}
	}
	else
	{
	}
}

- (void) dealloc
{
	[self.priceView removeFromSuperview];
	[self.tasteView removeFromSuperview];
	[self.imageView removeFromSuperview];
	[self.addressView removeFromSuperview];
	[self.informationView removeFromSuperview];
	[self.extensionView removeFromSuperview];
	[self.priceView release];
	[self.tasteView release];
	[self.imageView release];
	[self.addressView release];
	[self.informationView release];
	[self.extensionView release];
	[super dealloc];
}

@end
