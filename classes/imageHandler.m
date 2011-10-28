//
//  imageHandler.m
//  Gardening
//
//  Created by maesinfo on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "imageHandler.h"
#import "GardeningAppDelegate.h"


@implementation ImageHandler



- (void)   dealloc
{
	if(imageBotanicalNames)
	{
		[imageBotanicalNames removeAllObjects];
		[imageBotanicalNames release];
	}
	if(imageURLs)
	{
		[imageURLs removeAllObjects];
		[imageURLs release];
	}

	[super dealloc];
}

- (NSString*)   getFilePath: (NSString*)strBotanicalName
{
//	NSString *strURL = [[request url] absoluteString];
	int index = [imageBotanicalNames indexOfObject: strBotanicalName];
	NSString *strURL = [imageURLs objectAtIndex:index];
	if(strURL.length < 3)
		return nil;

	//retrieve file name
	NSString *suffix = [[strURL componentsSeparatedByString:@"."] lastObject];
	NSString *strTemp = [strBotanicalName stringByAppendingString:@"."];
	NSString *strFile = [strTemp stringByAppendingString:suffix];

	// retrieve file path
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *filePath = [[delegate fileDir] stringByAppendingPathComponent:strFile];

	return filePath;
}

- (NSString*)   getLocalPath:(NSString*)strBotanicalName
{
	if(nil == strBotanicalName || [strBotanicalName length] ==0 )
	{
		return nil;
	}

	NSString *filePath = [self getFilePath:strBotanicalName];


	BOOL bExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];

	if (bExist)
	{
		return filePath;
	}
	else
	{
		return nil;
	}
}



- (void) asyncDownload:(NSUInteger)index
{
	// start download,when completed it'll nofity browse controller to reload the picture

	NSString *strBotanicalName;
	NSString *filePath;// = [imageDir stringByAppendingPathComponent:
	//  [strBotanicalName  stringByAppendingPathComponent:@".png"]];

	NSFileManager *fileManager = [NSFileManager defaultManager];// fileExistsAtPath:filePath];
	for (int i=index; i< imageBotanicalNames.count; i++)
	{
		strBotanicalName = [imageBotanicalNames objectAtIndex:i];
	    filePath = [self getFilePath:strBotanicalName];
		if (![fileManager fileExistsAtPath:filePath] )
		{
			NSString *strURL = [imageURLs objectAtIndex:i];
			if(strURL.length > 0)
			{
				currentIndex = i;
				NSURL *url = [NSURL URLWithString:strURL];
				ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
				[request setDelegate:self];
				[request startAsynchronous];
				break;//first step,one by one
			}
		}
	}
}

- (BOOL) isImageInit
{
	if((!imageBotanicalNames || [imageBotanicalNames count]==0)
	   ||(!imageURLs || [imageURLs count]==0))
	{
		return NO;
	}
	
	return YES;
}

- (BOOL) isImageInfoChanged
{
	GardeningAppDelegate *delegate=[[UIApplication sharedApplication] delegate];

	if([imageBotanicalNames count] != delegate.dataHandler.itemNum
	   ||[imageURLs count] != delegate.dataHandler.itemNum)
	{
		return YES;
	}
	
	FusionTableData *record;
	for(int i=0;i<delegate.dataHandler.itemNum;i++)
	{
		record = [delegate.dataHandler getFusionTableData:i];
		if(record->strURL && [record->strURL compare:(NSString*)[imageURLs objectAtIndex:i]]!=0)
			return YES;
	}


	return NO;
}

- (void)  initImageInfo
{
	// retrieve the botanical name
	GardeningAppDelegate  *delegate = [[UIApplication sharedApplication] delegate];

	if(imageBotanicalNames)
	{
		[imageBotanicalNames removeAllObjects];
	}else{
		imageBotanicalNames = [[NSMutableArray alloc]init];
	}
	if(imageURLs)
	{
		[imageURLs removeAllObjects];
	}else{
		imageURLs = [[NSMutableArray alloc]init];
	}
	currentIndex = 0;

	for (int i=0; i<delegate.dataHandler.itemNum; i++)
	{
		FusionTableData *item = [delegate.dataHandler getFusionTableData:i];
		if(nil == item->strBotanicalName || [item->strBotanicalName length]==0)
			continue;
		[imageBotanicalNames addObject:item->strBotanicalName];
		if(nil != item->strURL)
		{
			[imageURLs    addObject:item->strURL];
		}else{
			[imageURLs    addObject:[NSString stringWithString:@"-"]];
		}
//		NSLog(@"load image:%d",i );
	}
}

- (void)  startDownloading
{

	[self asyncDownload:0];
}

#pragma mark -
- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
//	NSString *responseString = [request responseString];

	// Use when fetching binary data

	// retrieve the complete path
//	NSString *strURL = [[request url] absoluteString];
//	int index = [imageURLs indexOfObject: strURL];
	int index = currentIndex;
	NSString *strName = [imageBotanicalNames objectAtIndex:index];
	NSString *strFile = [self getFilePath:strName];

	//write to file
	NSData *responseData = [request responseData];
	[responseData writeToFile:strFile atomically:TRUE];

	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate updateTableView];


	[self asyncDownload:(currentIndex+1)];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Image download error! %@  %@",[error localizedDescription],[[request url] absoluteString]);
	
	[self asyncDownload:(currentIndex+1)];
}


- (void)  downloadCompleted
{
	
	
}


@end
