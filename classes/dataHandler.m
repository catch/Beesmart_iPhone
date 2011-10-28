//
//  dataHandler.m
//  Gardening
//
//  Created by maesinfo on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "dataHandler.h"
#import "GardeningAppDelegate.h"

//#import <ExternalAccessory/ExternalAccessory.h>


BOOL  isStringInArray(NSString* str ,NSArray* array)
{
	if(nil == array)
		return NO;

//	ExternalAccessory *ea = [[ExternalAccessory alloc]init];
	NSString *strTmp;
	int i;
	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	for(i=0;i<array.count; i++)
	{
		if(strTmp = [array objectAtIndex:i])
		{
			if(0 == [str compare:strTmp])
			{
				return TRUE;
			}
		}
	}
	return FALSE;
}

void  removeInArrayByText(NSMutableArray *array,NSString *str)
{
	NSString *strTmp;
	NSInteger i;
	BOOL bFound=TRUE;
	//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	while(bFound)
	{
		for(i=0;i<array.count; i++)
		{
			strTmp = [array objectAtIndex:i];
			if(0 == [strTmp compare:str])
			{
				[array removeObjectAtIndex:i];
//				[strTmp release];
				bFound = TRUE;
				break;
			}
		}
		
		if(i == array.count)
    		bFound = FALSE;
	}
}



@implementation SectionObj
@synthesize  count;



- (id) init
{
	[super init];
	
	size = 200;
	rowIndex = malloc(sizeof(int)*(size));
	memset(rowIndex,0,sizeof(int)*size);

	return self;
}

-(void) dealloc{

	size = 0;
	if(rowIndex)
	{
		free(rowIndex);
		rowIndex = nil;
	}
	if(title)
	{
		[title release];
	}


	[super dealloc];
}



-(void) setTitle:(NSString*)str{
	if(title)
		[title release];
	title = str;
	[title retain];
}


-(void) addRow:(NSInteger)row{

	if(count == size) //expand more 10
	{
		size += 50;
		NSInteger *tmp = malloc(sizeof(int)*(size));
		memset(tmp,0,sizeof(int)*size);
		NSInteger i;
		for(i=0; i<count; i++)
		{
			memcpy(tmp,rowIndex,sizeof(int)*count);
		//	tmp[i]= rowIndex[i];
		}
		if(rowIndex)
		{
			free(rowIndex);
		}
		rowIndex = tmp;
	}
	rowIndex[count] = row;
	count++;
}


-(NSInteger) getCount
{
    return count;
}


-(NSString*) getTitle
{
	return title;
}

-(int) getRow:(NSInteger)index
{
	if(index < count)
	{
		return rowIndex[index];	
	}

	return -1;
}



@end


#pragma mark -
@implementation  SectionDatas

-(id) init
{
	[super init];
	datas = [[NSMutableArray alloc] init];
	return self;
}

- (void) dealloc
{
	if(datas)
		[datas release];
	[super dealloc];
}

- (NSInteger) count
{
	return [datas count];
}

- (void) setDataHandler:(DataHandler*)aHandler
{
	handler = aHandler;
}

- (void) retrieveDataAll_OneSection
{
	if(datas.count>0)
	{
		[datas removeAllObjects];
	}
	SectionObj *obj = [[SectionObj alloc]init];
	[datas addObject:obj];
	
	for(int i= 0; i< handler.itemNum; i++)
	{
		[obj addRow:i];
	}
}

- (void) retrieveDataByArray_OneSection:(NSMutableArray*)nameArray
{
	if(datas.count>0)
	{
		[datas removeAllObjects];
	}
	SectionObj *obj = [[SectionObj alloc]init];
	[datas addObject:obj];

	FusionTableData *record;
	for (int i=0; i< handler.itemNum; i++)
	{
		record = [handler getFusionTableData:i];
		if(isStringInArray(record->strBotanicalName, nameArray))
		{
			[obj addRow:i];
		}
	}
}

- (void) retrieveDataByName_OneSection:(NSString*) plantName
{
	if(handler.itemNum <1)
		return;

	// first,clear up
	if(datas.count>0)
	{
		[datas removeAllObjects];
	}

	if(plantName == nil || 0== [plantName length])
		return ;
	
	SectionObj *obj = [[SectionObj alloc]init];
	[datas addObject:obj];

	FusionTableData *record;
	NSRange range;
	for (int i=0; i< handler.itemNum; i++)
	{
		record = [handler getFusionTableData:i];
		if (record)
		{
			if(record->strBotanicalName)
			{
				range = [record->strBotanicalName rangeOfString: plantName];
				if(range.location ==0)
				{
					[obj addRow:i];
					continue;
				}
			}
			
			if(record->strPreferedCommonName)
			{
				range = [record->strPreferedCommonName rangeOfString: plantName];
				if(range.location ==0)
				{
					[obj addRow:i];
					continue;
				}
			}
		}
	}
}

- (void) retrieveDataByBoolArray_OneSection:(SectionDatas*)sectionDatas :(NSMutableArray*)comparedArray :(NSArray*)pair1Array  :(NSArray*)pair2Array
{
    int count = [sectionDatas count];
	if(count <1)
		return ;
	
	// first,clear up
	if(datas.count>0)
	{
		[datas removeAllObjects];
	}

	int i,n;
	FusionTableData *record;
	SectionObj  *obj = [[SectionObj alloc] init];
	[datas addObject:obj];
	NSUInteger  foundCount = 0;
	
	for(i=0; i<[sectionDatas getCountInSection:0]; i++)
	{
		record = [sectionDatas getFusionTableData:0 :i];
		BOOL bNextRecord = NO;
		if(record)
		{
			if(comparedArray || (pair1Array && pair2Array))
			{
				for(n=0; n< [record->boolAttributes count]; n++)
				{
					NSString  *key =[record->boolAttributes getStringByIndex:n];
					if(![record->boolAttributes getBoolByIndex:n])
					{
						if(	isStringInArray(key,comparedArray))//abandon this record,improve efficiency
						{
							bNextRecord = YES;
							break;
						}
						continue;
					}
					if(	isStringInArray(key,comparedArray))
					{
						foundCount++;
					}
					else if(isStringInArray(key,pair1Array) || 	isStringInArray(key,pair2Array))
					{
						foundCount++;
					}
	
				}

				if(bNextRecord)
				{
					NSLog(@"\ngo next record");
					continue;
				}
				
				NSUInteger pairCount = pair1Array ? [pair1Array count] : 0;
				if(foundCount == [comparedArray count]+pairCount)
				{
					[obj addRow: [sectionDatas getRecordStorageIndex:0 :i] ];
				}
				foundCount=0;
			}
			else // add directly
			{
				[obj addRow: [sectionDatas getRecordStorageIndex:0 :i] ];
			}
		}
	}

}




- (void) retrieveDataAll
{
    int count = handler.itemNum;
	if(count <1)
		return ;

	// first,clear up
	int i;
	FusionTableData  *item;
	if(datas.count>0)
	{
		[datas removeAllObjects];
	}

	// then,retrieve
	char beginNow=0;
	SectionObj  *obj=nil;
	for (i=0; i<count ; i++) 
	{
		item = [handler getFusionTableData:i];
	    if(beginNow ==0 || beginNow != item->titleBegining)
		{
			beginNow = item->titleBegining;
			obj = [[SectionObj alloc]init];
			char  str[2];
			str[0] = item->titleBegining;
			str[1] = 0;
			[obj setTitle:[[NSString alloc] initWithUTF8String:(const char*)str]];
			[datas addObject:obj];
		}
//		obj = [datas objectAtIndex: ([datas count]-1)];

		[obj addRow:i];
	}
}

- (void) retrieveDataByArray:(NSMutableArray*)nameArray;  // for zone,search,favorite
{
    int count = handler.itemNum;
	if(count <1)
		return ;

	// first,clear up
	int i;
	FusionTableData  *item;
	if(datas.count>0)
	{
		[datas removeAllObjects];
	}

	// then,retrieve
	char beginNow=0;
	SectionObj  *obj=nil;
	for (i=0; i<count ; i++) {
		item = [handler getFusionTableData:i];
		if(! isStringInArray(item->strBotanicalName, nameArray))
		   continue;

	    if(beginNow ==0 || beginNow != item->titleBegining)
		{
			beginNow = item->titleBegining;
			obj = [[SectionObj alloc]init];
			char  str[2];
			str[0] = item->titleBegining;
			str[1] = 0;
			[obj setTitle:[[NSString alloc] initWithUTF8String:(const char*)str]];
			[datas addObject:obj];
		}
		//		obj = [datas objectAtIndex: ([datas count]-1)];

		[obj addRow:i];
	}
}

- (FusionTableData*) getFusionTableData:(NSIndexPath*)indexPath
{
	if( 0 == datas.count )
		return nil;

	SectionObj *secObj = (SectionObj*)[datas objectAtIndex:indexPath.section];
	int storageIndex = [secObj getRow:indexPath.row];
	if(storageIndex<0)
	{
		NSLog(@"getFusionTableData:invalid index");
		return nil;
	}
	else
	{
    	return [handler getFusionTableData:storageIndex];
	}
}

- (FusionTableData*) getFusionTableData:(NSInteger)section :(NSInteger)row
{
	if( 0 == datas.count )
		return nil;

	SectionObj *secObj = (SectionObj*)[datas objectAtIndex:section];
	int storageIndex = [secObj getRow:row];
	if( storageIndex<0)
	{
		NSLog(@"getFusionTableData:invalid index");
		return nil;
	}
	else
	{
    	return [handler getFusionTableData:storageIndex];
	}
}

- (NSInteger)       getRecordStorageIndex:(NSInteger)section :(NSInteger)row
{
	if( 0 == datas.count )
		return -1;
	
	SectionObj *secObj = (SectionObj*)[datas objectAtIndex:section];
	return [secObj getRow:row];
}

// the index in the items that has value.
-(NSString*) getSectionTitle:(NSInteger)section
{
	if( 0 == datas.count )
		return nil;

	SectionObj *secObj = (SectionObj*)[datas objectAtIndex:section];

	return [secObj getTitle];
}

-(NSInteger) getCountInSection:(NSInteger)section
{
	if( 0 == datas.count )
		return 0;
	
	SectionObj *secObj = (SectionObj*)[datas objectAtIndex:section];
	return [secObj getCount];
}

@end


#pragma mark -
@implementation DataHandler


@synthesize itemNum;
@synthesize archivedData;
@synthesize imageHandler;


-(FusionTableData*) getFusionTableData:(int)index
{
	if(index >=0 && index <itemNum)
	{
		return items+index;
	}
	else {
		return NULL;
	}
}



-(FusionTableData*) getFusionTableDataByName:(NSString*)strKeyName // get actual record data by name
{
	int i;
	for(i =0; i< itemNum; i++)
	{
		if( 0 == [strKeyName compare:items[i].strBotanicalName])
		{
			return items + i;
		}
	}

	return NULL;
}

/*
-(int) getStorageIndex:(NSIndexPath*)indexPath
{
	return [[sectionInfo objectAtIndex:indexPath.section] getRow:indexPath.row];
}



-(id) getDataByIndexAndID:(NSIndexPath*)indexPath :(NSInteger)contentID{
	NSInteger index=0;
	
	if(nil == sectionInfo)
		return nil;

	index = [[sectionInfo objectAtIndex:indexPath.section] getRow:indexPath.row];

	if(index < 0)
		return nil;

	switch (contentID)
	{
		case BOTANICAL_NAME:
			return items[index].strBotanicalName;
			break;
		case PREFERED_COMMON_NAME:
			return items[index].strPreferedCommonName;
			break;
		case URL:
			return items[index].strURL;
			break;
		default:
			return nil;
	}
}
*/


-(void) parseData
{
	[self clearItems];

	//format:  xxx,xxx,xxx,xxx,...\n

	itemNum = 0;
	//int rowCount = 3;
	//NSString
//    NSInteger  ii = [allData 
	NSUInteger buflen = [archivedData length];
	char letter = 'A';
	char *buf = malloc(buflen*2+2);

	NSLog(@"parseData: string  length:%d    buffer:%p",buflen,buf);

	NSUInteger encoding = NSNEXTSTEPStringEncoding;
	BOOL bRet = [archivedData getCString:buf maxLength:(buflen+1)*2  encoding:encoding ];
	if(!bRet)
	{
		NSLog(@"Fail to get Buffer!");
		return ;
	}

	NSLog(@"parseData:getBuffer ok!  length:%d",buflen);
	
	if(0 == buflen)
	{
		return ;
	}


	NSInteger start=0,end=0,current=0,i=0,strCount=0,index=0,n;
	NSInteger start_row=0;
	char tmpBuf[256];

	// parse the title
	while(0x0a != buf[end] || 0x0a == buf[end+1])
	{
		end++;
	}
    current = ++end;
	NSMutableArray    *titleArray = [[NSMutableArray alloc] init];
	for(n=0,start_row=0; n<current-1;n++)
	{
		if(',' == buf[n])
		{
			for(i=start_row;i<n;i++)
			{
				tmpBuf[i-start_row] = buf[i];
			}
			tmpBuf[i-start_row]=0;
			start_row = n+1;

			[titleArray addObject: [[NSString alloc ]initWithUTF8String:(const char*)tmpBuf]];
		}
	}
	// the last one
	for(i=start_row;i<n &&(0x0a!=buf[i]);i++)
	{
		tmpBuf[i-start_row] = buf[i];
	}
	tmpBuf[i-start_row]=0;
	start_row = n+1;
	[titleArray addObject: [NSString stringWithUTF8String:(const char*)tmpBuf]];

	//extract the name and url string,separated by','
	for(;current < buflen; current++)
	{
		start = current;
		while(0x0a != buf[end] && end<buflen)
		{
			end++;
		}
//		start = ++current;
		items[index].boolAttributes = [[NSKeyBool alloc]init];
		start_row = start;
		for(n= start; n<=end; n++) // each record
		{
			if(',' == buf[n]  || n == end)// each row            //|| 0x0a == buf[current]) && current>start)
			{
				//the row include ','
				if('"' == buf[start_row] && '"'!= buf[n-1])
				{
					continue;
				}

				for(i=start_row;i<n;i++)
				{
					tmpBuf[i-start_row] = buf[i];
				}
				tmpBuf[i-start_row]=0;

				//sequencely: 'Botanical Name','Prefered Common Name',URL
	//			NSLog(@"parseData:retrieve item:%d - %d",index, strCount);
				switch(strCount)
				{
					case 0:
						items[index].strBotanicalName = [[NSString alloc ]initWithUTF8String:(const char*)tmpBuf];// length:(start-current) encoding:encoding];
						items[index].titleBegining = tmpBuf[0];
						if(buf[start] != letter)
						{
							letter = buf[start];
	//						[sectionInfo addObject:[[SectionObj alloc]init]];
	//						[[sectionInfo objectAtIndex:++sectionCount] setTitle:[NSString stringWithFormat:@"%C",letter]];
						}
	//					[[sectionInfo objectAtIndex:sectionCount] addRow:index];
						break;

					case 1:
						items[index].strPreferedCommonName = [[NSString alloc ]initWithUTF8String:(const char*)tmpBuf];// length:(start-current) encoding:encoding];

						break;
						
					case 2:
						items[index].strURL = [[NSString alloc ]initWithUTF8String:(const char*)tmpBuf];// length:(start-current) encoding:encoding];

						break;

					case 3:
					{
						items[index].arrayEcoregion = [[NSMutableArray alloc]init];
						if('"' == buf[start_row])// more than one
						{
							int m,k;
							for(k=m=1; m<strlen(tmpBuf)-1; m++)
							{
								if(',' == tmpBuf[m])
								{
									if(m>k)
									{
									
										[items[index].arrayEcoregion addObject:
											[[NSString alloc ]initWithBytes:(tmpBuf+k) length:(m-k) encoding:NSUTF8StringEncoding]];
									}
									int j=1;
									while(0x20 ==tmpBuf[j + m] )
										++j;
									k = m+j;
								}
							}
							// last one
							if(m>k)
							{
								[items[index].arrayEcoregion addObject:
									[[NSString alloc ]initWithBytes:(tmpBuf+k) length:(m-k) encoding:NSUTF8StringEncoding]];
							}
						}
						else
						{
							if(!tmpBuf)
							{
								[items[index].arrayEcoregion addObject:
									[[NSString alloc ]initWithUTF8String:(const char*)tmpBuf]];
							}
						}
						//items[index].strURL = [[NSString alloc ]initWithUTF8String:(const char*)tmpBuf];// length:(start-current) encoding:encoding];
					}
						break;
					case 4:
						
						if(strlen(tmpBuf)>0)
						{
							char *heightBuf = tmpBuf;
							if(-1 == (int)(tmpBuf[strlen(tmpBuf)-1]))
							{
								tmpBuf[strlen(tmpBuf)-1] = 0;
							}
							if('"' == tmpBuf[0])
							{
								heightBuf++;
								tmpBuf[strlen(tmpBuf)-2]=0;
							}
							items[index].strHeight       = [[NSString alloc ]initWithUTF8String:(const char*)heightBuf];
						}
						break;
					case 5:
						items[index].strFlowerSeason = [[NSString alloc ]initWithUTF8String:(const char*)tmpBuf];
						break;
					default:
						if(strCount < titleArray.count)
						{
							BOOL bValue;
							if(0 == tmpBuf[0])
								bValue = NO;
							else
								bValue = YES;

							[items[index].boolAttributes addBool:[titleArray objectAtIndex:strCount] :bValue];
						}// default
				}//switch

				strCount++;
				start_row = n+1;
	//		NSLog(@"parseData:retrieve item:%d - %d ok",index, strCount-1);
			}//if

		}
		if(index == 340)
		{
			int ii;
			ii++;
		}
			NSLog(@"%d",index);
		strCount = 0;
//		if(0x0a == buf[current] || strCount == rowCount) // ',' or row count
		{
		index++;
		}

		itemNum = index;
		if(itemNum >= itemSize)
		{
			[self expandSize];
		}

		while(0x0a == buf[end+1])
		{
			end++;
		}
		current = end++;
	}//for

/*	items[0].strBotanicalName = @"Abronia umbellata";
	items[0].strURL = @"http://plants.usda.gov/gallery/pubs/abum_010_php.jpg";


	items[0].strBotanicalName = @"Acacia greggii";
	items[0].strURL = @"http://plants.usda.gov/gallery/pubs/acgr_003_php.jpg";
	
	items[2].strBotanicalName = @"Acer macrophyllum";
	items[2].strURL = @"http://plants.usda.gov/gallery/pubs/acma3_001_php.jpg";
*/

	//...
    [titleArray removeAllObjects];
	[titleArray release];
	free(buf);

	NSLog(@"parseData finished!  num:%d",itemNum);
	[(GardeningAppDelegate*)[[UIApplication sharedApplication] delegate] updateTableView];
}

- (id) init
{
	[super init];
	imageHandler = [[ImageHandler alloc] init];

	itemSize = 900;
//	NSUInteger size=2000;
//	NSInteger  sectionCount=0;
	items = (FusionTableData*)malloc(sizeof(FusionTableData)*itemSize);
	if(!items)
	{
		NSLog(@"Fail to alloc Buffer for items!");
		//return ;
	}
	else
	{
		memset(items,0,sizeof(FusionTableData)*itemSize);
	}

	return self;
}


-(void) dealloc{
	if(archivedData)
	{
		[archivedData release];
	}
	if (requestData) {
		[requestData release];
	}

	if(itemNum > 0)
	{
		NSUInteger i=0;
		for(i=0;i<itemNum;i++)
		{
			[items[i].strBotanicalName release];
			[items[i].strURL release];
		}
		free( items);
		items = nil;
	}
//	[letterArray release];
//
//	if(sectionInfo)
//	{
//		[sectionInfo release];
//	}

//	if(allRows)
//	{
//		[allRows release];
//	}
//	if(currentRows)
//	{
//		[currentRows release];
//	}

//	if(currentData)
//	{
//		[currentData release];
//	}

	
	if(imageHandler)
		[imageHandler release];
	
	[self clearItems];
	free(items);

	[super dealloc];
}

-(void) clearItems
{
	int i;
	FusionTableData *record;
	for(i=0;i<itemNum;i++)
	{
		record = [self getFusionTableData:i];
		if(record)
		{
			SAFE_RELEASE(record->strBotanicalName);
			SAFE_RELEASE(record->strPreferedCommonName);
			SAFE_RELEASE(record->strURL);
			SAFE_RELEASE(record->strHeight);
			SAFE_RELEASE(record->strFlowerSeason);

			if(record->boolAttributes)
			{
				[record->boolAttributes removeAll];
				SAFE_RELEASE(record->boolAttributes);
			}
			if(record->arrayEcoregion)
			{
				[record->arrayEcoregion removeAllObjects];
				SAFE_RELEASE(record->arrayEcoregion);
			}
		}
	}
	itemNum = 0;
}

-(void) expandSize
{
	itemSize += 500;
	FusionTableData *tmp = (FusionTableData*)malloc(sizeof(FusionTableData)*itemSize);
	int i;
	for(i=0;i<itemNum;i++)
	{
		tmp[i].strBotanicalName     = items[i].strBotanicalName;
		tmp[i].strPreferedCommonName= items[i].strPreferedCommonName;
		tmp[i].strURL               = items[i].strURL;
		tmp[i].boolAttributes       = items[i].boolAttributes;
		tmp[i].strHeight               = items[i].strHeight;
		tmp[i].strFlowerSeason       = items[i].strFlowerSeason;
	}
	free(items);
	items = tmp;
}

//- (void) retriveDataAll:(NSMutableArray *) array
//{
//	for(int i=0; i< itemNum; i++)
//	{
//		[array addObject:items[i].strBotanicalName];
//	}
//}

//
//- (void) archiveFusionString
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	[delegate archive:ARCHIVE_FUSIONSTRINGS];
//
//	//	NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
////	[NSKeyedArchiver archiveRootObject:archivedData 
////								toFile: [docDir stringByAppendingPathComponent:FILENAME_FUSIONSTRING]];
//}
//
//- (void) unarchiveFusionString
//{
//	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	[delegate unarchive:ARCHIVE_FUSIONSTRINGS];
//
////	NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
////	archivedData = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_FUSIONSTRING]];
////    if( requestData == nil)
////		requestData = [[NSString alloc]init];
//}	


-(BOOL) doAfterRequest:(NSString *)newString
{
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if(0 == newString.length)
	{
		return NO;
	}
	BOOL bNew=NO;
	if(newString != archivedData)
	{
		if(0==[newString compare:archivedData])
		{
			NSLog(@"the downloaded data is the same!");
			return NO;
		}
		else
		{
			NSLog(@"the downloaded data is not the same!");
			//[archivedData release];
			//[delegate deleteDocFiles];
			self.archivedData = newString;
			bNew = YES;
		}
	}
//	
//	SAFE_RELEASE(allData);
//	self.allData = newString;
	
	[self parseData];

	if(![imageHandler isImageInit])
	{
		[imageHandler initImageInfo];
	}
	else if([imageHandler isImageInfoChanged])
	{
		[delegate deleteDataFiles];
		[imageHandler initImageInfo];
	}

	if(bNew)
	{
		[delegate archive:ARCHIVE_FUSIONSTRINGS];

		delegate.versionString = CURRENT_VERSION;
		[delegate archive:ARCHIVE_VERSION];
		NSLog(@"the downloaded data has been archived!");
	}

	[imageHandler startDownloading];

	return YES;
}

#pragma mark 
#pragma mark - Google Fusion access

-(void) requestFusionData{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	//NOTE with this way, cookie is send automatically, so it can be ignored


	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate unarchive:ARCHIVE_FUSIONSTRINGS];
//	[self unarchiveFusionString];
	if(archivedData)
	{
		[self doAfterRequest:archivedData];
		//return;
	}

//	NSString *url;
	NSString *url = @"https://www.google.com/fusiontables/api/query?sql=SELECT 'Botanical Name','Prefered Common Name',URL,'Ecoregion Numbers',Height,'Flower Season'";

	NSString *appending = @",Bats,Bees,Butterflies,Moths,Flies,Hummingbirds,Beetles,Wasps,Insects";
	url = [url stringByAppendingString:appending];
	appending = @",Dry,'Well-drained','Moist/wet',Flooded";
	url = [url stringByAppendingString:appending];
	appending = @",White,Orange,Yellow,Pink,Purple,Blue,Red,Green";
	url = [url stringByAppendingString:appending];
	appending = @",Sun,'Partial Sun',Shade";
	url = [url stringByAppendingString:appending];
	appending = @",Acidic,Clay,Loam,Rich,Rocky,Sandy,Silty,Caliche";
	url = [url stringByAppendingString:appending];
	appending = @",Perennial,'Tree/Shrub',Annual,Vine";
	url = [url stringByAppendingString:appending];

	appending = @" FROM 1257668 ORDER BY 'Prefered Common Name'";
	url = [url stringByAppendingString:appending];	

	NSLog(@"%@",url);


	//create NSURLRequest
	NSString* urlEncoding = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURLRequest* urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEncoding] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	
	NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlrequest delegate:self];	 

	NSLog(@"connection start");
	[connection start];
	NSLog(@"connection start ok!");

}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{  
	//   [receivedData setLength:0];
	NSLog(@"Receive response");
}  

- (void)connection:(NSURLConnection *)connection 
	didReceiveData:(NSData *)data  
{  
	NSLog(@"Receive data");

	NSString *stringData = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];

	if(nil == stringData)
	{
		return;
	}
	
	if(nil == requestData)
	{
		requestData = [[NSString alloc]initWithString:@""];
	}
	NSString *tmp = [[NSString alloc]initWithString: [requestData stringByAppendingString:stringData]];

//	[requestData release];
	requestData = tmp;


	[stringData release];

}


- (void)connectionDidFinishLoading :(NSURLConnection *)connection
{
	NSLog(@"Finish Loading!");

	BOOL bRet=[self doAfterRequest:requestData];

	NSLog(@"requestData retainCount:%d",[requestData retainCount]);
	SAFE_RELEASE(requestData);
	
	if(bRet)///refresh
	{		
		GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
		[delegate updateTableView];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	//stop handling...
	if(requestData)
	{
	    [requestData release];
		requestData = nil;
	}
}


@end
