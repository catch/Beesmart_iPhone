//
//  helpViewController.m
//  Gardening
//
//  Created by maesinfo on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "helpViewController.h"


@implementation helpViewController

- (void) initHeader
{
	
}

- (void) loadView
{
	[super loadView];
	self.title = @"Help";

//	textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH-5*2, MAIN_VIEW_HEIGHT-10)];
//
//	textView.editable = NO;
//	textView.textColor = colorText;
//	textView.backgroundColor = colorBackground;
//	textView.font = [UIFont systemFontOfSize:16.0f];
//	NSError *error;
//	NSString *path = [[NSBundle mainBundle] pathForResource:@"help.txt" ofType:nil];
//	textView.text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
//	[self.view addSubview:textView];
//
//	
	UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAIN_VIEW_HEIGHT-self.navigationController.navigationBar.frame.size.height)];
	//	web.scalesPageToFit = YES;
//	[web setDelegate:self];
	[self.view addSubview:web];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"beesmart_help.htm" ofType:nil];
	NSURL *url = [NSURL fileURLWithPath:path];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[web loadRequest:request];
	
}

- (void) dealloc
{
	SAFE_RELEASE(textView);

	[super dealloc];
}

@end
