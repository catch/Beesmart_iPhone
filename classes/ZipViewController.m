//
//  startViewController.m
//  Gardening
//
//  Created by maesinfo on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zipViewController.h"
#import "GardeningAppDelegate.h"



@implementation ZipViewController

- (void) willLoadView
{
	bShowToolbar = FALSE;
}


- (void) setMode:(NSUInteger)mode
{
    currentMode = mode;	
}

- (id) init
{
	[super init];
	
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate unarchive:ARCHIVE_ZIPCODE];
	
	return self;
}

-(void) loadView
{
	[super loadView];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"start_bg" ofType:@"png"];
	UIImageView *tmpView = [[[UIImageView alloc]initWithFrame:self.view.frame]autorelease];// CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
	tmpView.image = [UIImage imageWithContentsOfFile:path];//imageNamed:LOADING_IMAGE_FILE]];

	bgView = [[UIControl alloc]initWithFrame:self.view.frame];
	[bgView addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
	[bgView addSubview:tmpView];
	[self.view addSubview:bgView];
//	[tmpView release];

	float x_margin = 60;
	UITextField   *tempInput = [[UITextField alloc]initWithFrame:CGRectMake(x_margin*screen_rate, MAIN_VIEW_HEIGHT*0.43,SCREEN_WIDTH - x_margin*2*screen_rate, 32*screen_rate)];
	zipInput = tempInput;
	zipInput.borderStyle = UITextBorderStyleRoundedRect;
//	zipInput.clearButtonMode = UITextFieldViewModeAlways;
	zipInput.font = [UIFont systemFontOfSize:22.0f];
//	zipInput.textAlignment = UITextAlignmentCenter;
	[zipInput setDelegate:self];
	zipInput.returnKeyType =  UIReturnKeyDone;
	zipInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	zipInput.clearsOnBeginEditing = YES;
//	[zipInput addTarget:self action:@selector(hideKeyboard:)   forControlEvents:UIControlEventEditingDidEndOnExit];
	[zipInput addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventEditingChanged];
	[self.view addSubview:zipInput];
	[[NSNotificationCenter defaultCenter] addObserver:self                                                          
											 selector:@selector(keyboardDidHide:)                                                                  
												 name:UIKeyboardDidHideNotification
											   object:nil];


	float offset = 4.0*screen_rate;
	float startY_ = 44.0 * screen_rate;
	CGRect frame = CGRectMake(SCREEN_WIDTH-60*screen_rate , offset*2, startY_-offset*2, startY_-offset*2);
	returnButton = [[UIButton alloc] initWithFrame:frame];
	[returnButton setImage:[UIImage imageNamed:@"home_grey.png"] forState:UIControlStateNormal];
	[returnButton addTarget:self action:@selector(showDashboard:) forControlEvents:UIControlEventTouchUpInside];
	returnButton.hidden = YES;
	[self.view addSubview:returnButton];

}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate unarchive:ARCHIVE_ZIPCODE];
	if(nil == delegate.zipCode)
	{
		returnButton.hidden = YES;
		currentMode = ZIPCODE_INIT;
		zipInput.placeholder = @"";
	}
	else {
		returnButton.hidden = NO;
		currentMode = ZIPCODE_EDIT;
		zipInput.placeholder = delegate.zipCode;
	}
	bCorrectZip = FALSE;


//	if(ZIPCODE_INIT == currentMode)
//	{
//	//	zipInput remove
//		if(ensureButton)
//			ensureButton.hidden = YES;
//	}
//	else if(ZIPCODE_EDIT == currentMode)
//	{
//		if(ensureButton)
//			ensureButton.hidden = NO;
//	}

}

- (IBAction)keyboardDidHide:(NSNotification *)note
{
	if(bCorrectZip)
	{
//		if(ZIPCODE_INIT == currentMode)
		{
			GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			[delegate updateZipcode:zipInput.text];
			[self showDashboard:nil];
		}
	}
	
}


-(IBAction) hideKeyboard:(id)sender{
	[zipInput resignFirstResponder];
	[bgView   resignFirstResponder];
}

-(IBAction) onValueChanged:(id) sender
{
	if([zipInput.text length] == 5)
	{
		bCorrectZip = TRUE;
//		ensureButton.enabled = YES;
		[self hideKeyboard:nil];

//		ensureButton.enabled = YES;
//		ensureButton.hidden=NO;
//		[self goDashboard];
//		GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//		[delegate showDashboard];
	}
}



- (void) dealloc
{
	SAFE_RELEASE(returnButton);
	[bgView release];
	[zipInput release];
	[super dealloc];
}


#pragma mark 
#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(id)textField{
    [textField  resignFirstResponder];
	return YES;
}

@end
