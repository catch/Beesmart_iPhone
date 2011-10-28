//
//  zoneViewController.m
//  Gardening
//
//  Created by maesinfo on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zoneViewController.h"
#import "GardeningAppDelegate.h"
#import "CatchClient.h"

@implementation ZoneViewController




-(void) viewDidLoad
{
	[super viewDidLoad];

	/*	[btn setTitle:@"Search" forState:UIControlStateNormal];
	 btn.titleLabel.textColor = [UIColor blackColor];
	 [btn setBackgroundColor:[UIColor grayColor]];
	 [btn addTarget:self action:@selector(doSearch:) forControlEvents:UIControlEventTouchUpInside];
	 */
	NSString *path = [[NSBundle mainBundle] pathForResource:@"bg_start" ofType:@"png"];
	UIImageView *bgView = [[[UIImageView alloc]initWithFrame:self.view.frame]autorelease];// CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
	bgView.image = [UIImage imageWithContentsOfFile:path];//imageNamed:LOADING_IMAGE_FILE]];
    [self.view addSubview:bgView];

//	zoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
//	zoneLabel.text = @"Select Zone Here...";
//	zoneLabel.backgroundColor = [UIColor whiteColor];
//	zoneLabel.textColor = [UIColor blackColor];
//	[self.view addSubview:zoneLabel];
//	[zoneLabel release];
	
	UITextField   *tempInput = [[UITextField alloc]initWithFrame:CGRectMake(50, 260, 220, 35)];
	zipInput = tempInput;
//	zipInput.backgroundColor = [UIColor whiteColor];
	zipInput.borderStyle = UITextBorderStyleRoundedRect;
	zipInput.clearButtonMode = UITextFieldViewModeAlways;
	[zipInput addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
	[self.view addSubview:zipInput];
	[tempInput release];

	UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(110,305,100,40)];
//	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	btn.frame = CGRectMake(110,310,100,40); 
	[btn setTitle:@"OK" forState:UIControlStateNormal];
	btn.titleLabel.textColor = [UIColor blackColor];
	[btn setBackgroundColor:[UIColor purpleColor]];
	[btn addTarget:self action:@selector(goZone:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	[btn release];

}

-(IBAction) hideKeyboard:(id)sender{
	[zipInput resignFirstResponder];
}

-(IBAction) goZone:(id)sender
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(nil == delegate.moreViewController)
	{		
		GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.mainView addSubview: delegate.toolbarView];

		CGRect frame = self.view.frame;
		frame.size.height -= TOOLBAR_HEIGHT;
		self.view.frame = frame;

		[delegate.toolbarView goBrowseView:nil];
		[delegate.toolbarView enabledAll:YES];
	}
	else
	{
		[delegate.moreViewController showView:delegate.currentController];
	}


}

- (void) dealloc
{
	[zoneLabel release];
	[super dealloc];
}

@end
