//
//  commonUtils.m
//  Gardening
//
//  Created by maesinfo on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "commonUtils.h"
#import "Configuration.h"

@implementation NSBoolArray


- (id) init
{
	[super init];

	size  = 10;
	length= 0;
	buffer = (BOOL*)malloc(size*sizeof(BOOL));

	return self;
}


- (void) removeAll
{
	length = 0;
}

-(void) add:(BOOL)bValue
{
	if(++length >= size)
	{
		size += 10;
		BOOL *tmp = (BOOL*)malloc(size*sizeof(BOOL));
		int i;
		for(i=0; i<length-1;i++)
		{
			tmp[i] = buffer[i];
		}
		free(buffer);
		buffer = tmp;
	}
	buffer[length-1] = bValue;
}

- (void) set:(NSUInteger)index :(BOOL)bValue
{
	if(index <length)
	{
		buffer[index] = bValue;
	}
	else {
		NSLog(@"NSBoolArray:set  -  Invalid idex!");
	}

}

-(BOOL) get:(NSUInteger)index
{
	if(index <length)
	{
		return buffer[index];
	}
	else {
		NSLog(@"NSBoolArray:get  -  Invalid idex!");
		return FALSE;
	}
}

-(void) dealloc
{
	if(buffer)
		free(buffer);

	[super dealloc];
}

@end



#pragma mark -

@implementation NSKeyBool

- (id) init
{
	[super init];

	boolArray = [[NSBoolArray alloc]init];
	keyArray  = [[NSMutableArray alloc]init];
	
	return self;
}

- (NSUInteger) count;
{
	return [keyArray count];
}

- (void) dealloc
{
	SAFE_RELEASE(boolArray);
	SAFE_RELEASE(keyArray);
	
	[super dealloc];
}

- (void) removeAll
{
	[keyArray removeAllObjects];
	[boolArray removeAll];	
}

- (void) addBool:(NSString*)key :(BOOL)bValue
{
	[keyArray addObject:key];
	[boolArray add:bValue];
}

- (void) setBool:(NSString*)key :(BOOL)bValue
{
	int i;
	i = [keyArray indexOfObject:key];
	[boolArray set:i :bValue];
}

- (BOOL) getBool:(NSString*)key
{
	int i;
	i = [keyArray indexOfObject:key];
	return [boolArray get:i];
}

- (BOOL) getBoolByIndex:(NSUInteger)index
{
	if(index <keyArray.count)
	{
		return [boolArray get:index];
	}
	else {
		NSLog(@"Invalid Index!:NSKeyBool - getBoolByIndex");
		return NO;
	}
}

-(NSString*) getStringByIndex:(NSUInteger)index
{
	if(index <keyArray.count)
	{
		return [keyArray objectAtIndex:index];
	}
	else {
		return nil;
	}
}

@end
