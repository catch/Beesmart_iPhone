//
//  imageHandler.h
//  Gardening
//
//  Created by maesinfo on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


@interface ImageHandler : NSObject <ASIHTTPRequestDelegate> {
	NSMutableArray    *imageBotanicalNames;
	NSMutableArray    *imageURLs;   //NNString*

	NSMutableArray    *currentDownloading;
//	NSString          *imageDir;
	NSInteger         currentIndex;
}


- (NSString*)   getFilePath: (NSString*)strBotanicalName; //get image file path by botanical name
- (NSString*)   getLocalPath:(NSString*)strBotanicalName;

- (BOOL)  isImageInit;
- (BOOL)  isImageInfoChanged;
- (void)  initImageInfo;
- (void)  startDownloading;
- (void)  asyncDownload:(NSUInteger)index;
- (void)  downloadCompleted;

@end
