//
//  FusionDataHandler.m
//  Gardening
//
//  Created by maesinfo on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FusionDataHandler.h"
#import "GardeningAppDelegate.h"

#define TIME_OUT 30



@implementation FusionDataHandler


- (NSString*) sendXMLRequest: (NSString*)url;
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	//NOTE with this way, cookie is send automatically, so it can be ignored
	
	//创建NSURLRequest
	NSString* urlEncoding = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURLRequest* urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEncoding] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:TIME_OUT];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	//通过NSURLConnection 发送NSURLRequest，这里是同步的，因此会又等待的过程，TIME_OUT为超时时间。

	//error可以获取失败的原因。
	NSError* error = nil;
	NSData* data = [NSURLConnection sendSynchronousRequest:urlrequest returningResponse:NULL error:&error];
	if(!error){
		NSString *stringData = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
		return stringData;
	}
	NSString* errorString = [NSString stringWithFormat:@"<error string=\"%@\"/>", [error localizedDescription]];
	return errorString;
}

-(void) sendXMLRequestAsync: (NSString*)url delegateForRequest:(id)delegateForRequest
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	//NOTE with this way, cookie is send automatically, so it can be ignored
	
	//创建NSURLRequest
	NSString* urlEncoding = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURLRequest* urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEncoding] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:TIME_OUT];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	//通过NSURLConnection 发送NSURLRequest，这里是同步的，因此会又等待的过程，TIME_OUT为超时时间。

	//error可以获取失败的原因。
	//[NSURLConnection
//	GardeningAppDelegate *gardening = [[UIApplication sharedApplication] delegate];

	NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlrequest delegate:delegateForRequest];	 
	[connection start];
/*	NSError* error = nil;
	NSData* data = [NSURLConnection sendSynchronousRequest:urlrequest returningResponse:NULL error:&error];
	if(!error){
		NSString *stringData = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
		return stringData;
	}
	NSString* errorString = [NSString stringWithFormat:@"<error string=\"%@\"/>", [error localizedDescription]];
	return errorString;
*/
}

- (NSString*) postURLRequest: (NSString*)url body:(NSString*)body
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:TIME_OUT];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    
    NSString *stringData = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return stringData;
}

@end
