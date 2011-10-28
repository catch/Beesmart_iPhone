//
//  DonateViewController.m
//  Gardening
//
//  Created by maesinfo on 10/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DonateViewController.h"


@implementation DonateViewController

-(void) initHeader
{
}

- (void) loadView
{
	[super loadView];
	self.title = @"Donate";
		
	web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAIN_VIEW_HEIGHT-self.navigationController.navigationBar.frame.size.height)];
//	web.scalesPageToFit = YES;
	[web setDelegate:self];
	[self.view addSubview:web];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"beesmart_donate.webarchive" ofType:nil];
	NSURL *url = [NSURL fileURLWithPath:path];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[web loadRequest:request];
	
	SAFE_RELEASE(memPool);
}

-(void) viewWillAppear:(BOOL)animated
{

	NSString *path = [[NSBundle mainBundle] pathForResource:@"beesmart_donate.webarchive" ofType:nil];
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
//	if([[[request URL] absoluteString ]compare:@"beesmart_donate.webarchive"]!=0)
//	{
//		web.scalesPageToFit = YES;
//	}
//	else {
//		web.scalesPageToFit = NO;
//	}
//	
	
	return YES;
}
@end
