//
//  commonUtils.h
//  Gardening
//
//  Created by maesinfo on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBoolArray : NSObject
{
	BOOL   *buffer;
	NSUInteger length;
	NSUInteger size;
}

-(void) add:(BOOL)bValue;
-(BOOL) get:(NSUInteger)index;

-(void) removeAll;
@end



@interface NSKeyBool : NSObject {
	NSBoolArray    *boolArray;
	NSMutableArray *keyArray;
}

- (NSUInteger) count;

- (void) addBool:(NSString*)key :(BOOL)bValue;
- (void) setBool:(NSString*)key :(BOOL)bValue;
- (BOOL) getBool:(NSString*)key;

- (BOOL) getBoolByIndex:(NSUInteger)index;
- (NSString*) getStringByIndex:(NSUInteger)index;

-(void) removeAll;
@end
