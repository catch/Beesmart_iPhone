//
//  dataHandler.h
//  Gardening
//
//  Created by maesinfo on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imageHandler.h"
#import "commonUtils.h"

// Google Fusion Table Item
enum{
	BOTANICAL_NAME = 0,
	ECOREGION_NUMBERS,
	PREFERED_COMMON_NAME,
	WHITE,
	ORANGE,
	YELLOW,
	PINK,
	PURPLE,
	BLUE,
	RED,
	GREEN,
	HEIGHT,
	URL,
	NUM_OF_ROW_IN_FUSIONTABLE
};

/*
enum {
	WHITE   = 1,
	ORANGE  = 1<<1,
	YELLOW  = 1<<2,
	PINK    = 1<<3,
	PURPLE  = 1<<4,
	BLUE    = 1<<5,
	RED     = 1<<6,
	GREEN   = 1<<7
}; */

enum{
	ACIDIC   = 1,
	CLAY     = 1<<1,
	LOAM     = 1<<2,
	RICH     = 1<<3,
	ROCKY    = 1<<4,
};

typedef struct _fusionTableData{
	NSString *strBotanicalName;
	NSString *strURL;
	NSMutableArray *arrayEcoregion;
	NSString *strPreferedCommonName;
	NSString *strHeight;
	NSString *strFlowerSeason;
	NSKeyBool *boolAttributes;
	char      titleBegining;
}FusionTableData;

typedef struct _itemByLetter{
	char c;
	NSInteger count;
}ItemByLetter;

BOOL  isStringInArray(NSString* str ,NSArray* array);
void  removeInArrayByText(NSMutableArray *array,NSString *str);

@class DataHandler;


//just store section infos,don't stroe actual items
@interface SectionObj : NSObject
{
	NSString  *title;
	NSInteger size;
	NSInteger count;
	NSInteger *rowIndex;
}
@property (nonatomic,readonly) NSInteger  count;

- (id) init;

-(void) setTitle:(NSString*)str;
-(void) addRow:(NSInteger)row;
-(NSInteger) getCount;
-(NSString*) getTitle;
-(int) getRow:(NSInteger)index;
-(void) dealloc;

@end


@interface SectionDatas: NSObject
{
	DataHandler  *handler;
	NSMutableArray *datas;
}


- (void) setDataHandler:(DataHandler*)aHandler;
- (FusionTableData*) getFusionTableData:(NSIndexPath*)indexPath;
- (FusionTableData*) getFusionTableData:(NSInteger)section :(NSInteger)row;
- (NSInteger)       getRecordStorageIndex:(NSInteger)section :(NSInteger)row;

// there's just one section
- (void) retrieveDataAll_OneSection;
- (void) retrieveDataByArray_OneSection:(NSMutableArray*)nameArray; 
- (void) retrieveDataByBoolArray_OneSection:(SectionDatas*)sectionDatas :(NSMutableArray*)comparedArray :(NSArray*)pair1Array  :(NSArray*)pair2Array;
- (void) retrieveDataByName_OneSection:(NSString*) plantName;

// alphabetically
- (void) retrieveDataAll;
// for zone,search,favorite, array store botanical name
- (void) retrieveDataByArray:(NSMutableArray*)nameArray; 


-(NSInteger) count;
-(NSString*) getSectionTitle:(NSInteger)section;
-(NSInteger) getCountInSection:(NSInteger)section;

@end






@interface DataHandler : NSObject {

	ImageHandler       *imageHandler;


	FusionTableData       *items;
	NSUInteger		      itemNum;
	NSUInteger            itemSize;
//	NSMutableDictionary   *letterArray;
//	NSUInteger            letterNum;
//	ItemByLetter          currentSection[26];
	
//	NSMutableArray        *sectionInfo;
//	NSMutableArray        *allRows;
//	NSMutableArray        *currentRows;
	
	NSString *requestData;

	//archived data:
	NSString      *archivedData;
}

@property(nonatomic, retain) NSString *archivedData;
@property(nonatomic, readonly) NSUInteger itemNum;
@property(nonatomic, readonly) ImageHandler *imageHandler;


- (void) expandSize;
// request from Google Fusion
-(void) requestFusionData;
-(BOOL) doAfterRequest:(NSString *)newString;
//-(void) updateByFusionData:(NSString *)newData;


-(void) parseData;
-(FusionTableData*) getFusionTableData:(int)index; // get actual record data
-(FusionTableData*) getFusionTableDataByName:(NSString*)strName; // get actual record data

- (void) clearItems;

//- (void) retriveDataAll:(NSMutableArray *) array;


//- (void) archiveFusionString;
//- (void) unarchiveFusionString;

//-(int) getStorageIndex:(NSIndexPath*)indexPath;
//-(id) getDataByIndexAndID:(NSIndexPath*)indexPath :(NSInteger)contentID;

//-(NSInteger) getSectionCount;
//-(NSString*) getSectionTitle:(NSInteger)index;
//-(NSInteger) getCountInSection:(NSInteger)index;

@end
