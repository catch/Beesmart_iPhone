//
//  SearchViewController.m
//  Gardening
//
//  Created by maesinfo on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "SearchViewController.h"

#import "GardeningAppDelegate.h"


@implementation SearchViewController

#pragma mark -


-(void) willInit
{
	[super willInit];

	beginHeight += 60;

}

-(IBAction) hidekKeyboard:(id)sender
{
	[inputSearch resignFirstResponder];
	[self becomeFirstResponder];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) loadView {
    [super loadView];

	//[self initNavigation];

	float x=30.0f;
    inputSearch = [[UITextField alloc] initWithFrame : CGRectMake(x, startY+10, SCREEN_WIDTH-x*2, 32)];
	[self.view addSubview:inputSearch];
//	inputSearch.backgroundColor = [UIColor whiteColor];
	inputSearch.placeholder = @"Search by plant name";
	inputSearch.font = [UIFont systemFontOfSize:20.0f];
//	inputSearch.textAlignment = UITextAlignmentCenter;
	inputSearch.borderStyle = UITextBorderStyleRoundedRect;
//	inputSearch.clearButtonMode = UITextFieldViewModeAlways;
	inputSearch.returnKeyType = UIReturnKeyDone;
	[inputSearch setDelegate:self];

	[inputSearch addTarget:self action:@selector(onSearchValueChanged:) forControlEvents:UIControlEventEditingChanged];


	[table setDelegate:self];

	self.title = @"Search";
//	[self addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	if(navController.visibleViewController == self)
    	[navController setNavigationBarHidden:YES animated:NO];
	
	[super viewWillAppear:animated];

	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(delegate.favoriteChanged)
	{
		[self reloadTable];
		delegate.favoriteChanged = NO;
	}

	if([inputSearch.text length] > 0 )
	{
		[self hidekKeyboard:self];
	}
	else {
		[inputSearch becomeFirstResponder];

	}

}

//- (void) viewWillDisappear:(BOOL)animated
//{
////	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
////    if(self == delegate.searchViewController)
////	{
////		[navController setNavigationBarHidden:NO animated:NO];
////	}
//	[super viewDidAppear:animated];
//	
//	[self hideKeyboard:self];
//}

-(void) reloadTable
{
	[secDatas retrieveDataByName_OneSection:inputSearch.text];
	
	[table reloadData];
}

-(IBAction)  onSearchValueChanged:(id)sender
{
	//update the talbe
//	NSLog(inputSearch.text);

	[secDatas retrieveDataByName_OneSection:inputSearch.text];

	[table reloadData];
}

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)dealloc {
	if(inputSearch)
		[inputSearch release];
    [super dealloc];
}



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	[inputSearch resignFirstResponder];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	[inputSearch resignFirstResponder];
//	
//}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	[inputSearch resignFirstResponder];
//	
//}

#pragma mark 
#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(id)textField{
    [self hidekKeyboard:nil];
	return YES;
}


@end
