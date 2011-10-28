//
//  aboutViewController.m
//  Gardening
//
//  Created by maesinfo on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "aboutViewController.h"


@implementation aboutViewController

-(void) initHeader
{
}

- (void) loadView
{
	[super loadView];
	self.title = @"About";

	web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAIN_VIEW_HEIGHT-self.navigationController.navigationBar.frame.size.height)];
//	web.scalesPageToFit = YES;
	[web setDelegate:self];
	[self.view addSubview:web];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"beesmart_about.webarchive" ofType:nil];
	NSURL *url = [NSURL fileURLWithPath:path];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[web loadRequest:request];
	
	SAFE_RELEASE(memPool);
}

-(void) viewWillAppear:(BOOL)animated
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"beesmart_about.webarchive" ofType:nil];
	NSURL *url = [NSURL fileURLWithPath:path];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[web loadRequest:request];
}

-(void) dealloc
{
	SAFE_RELEASE(web);
	[super dealloc];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//	if([[[request URL] absoluteString ]compare:@"beesmart_about.webarchive"]!=0)
//	{
//		web.scalesPageToFit = YES;
//	}
//	else {
//		web.scalesPageToFit = NO;
//	}


	return YES;
}

@end
