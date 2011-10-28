//
//  EcoregionMapController.m
//  Gardening
//
//  Created by maesinfo on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EcoregionMapController.h"
#import "GardeningAppDelegate.h"


@implementation EcoregionMapController
@synthesize routeView = _routeView;
@synthesize mapView   = _mapView;

- (void) dealloc
{
	SAFE_RELEASE(web);
	[super dealloc];
}

- (void)showInWeb
{
	if(nil == web)
	{
		web = [[UIWebView alloc]initWithFrame:CGRectMake(0, startY, SCREEN_WIDTH, MAIN_VIEW_HEIGHT)];
		web.scalesPageToFit = YES;
		[self.view addSubview:web];
	}
	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *url = [NSString stringWithFormat:@"%@%@", @"http://wildlifedisease.nbii.gov/ecoregions/index.jsp?zipcode=",delegate.zipCode];
	NSString* urlEncoding = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURLRequest* urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEncoding] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
	[web loadRequest:urlrequest];
}

- (void)showMap :(NSString*)fileContents
{
	//
	// load the points from our local resource
	//
//	NSString* filePath = [[NSBundle mainBundle] pathForResource:@"polygon" ofType:@"csv"];
//	NSString* fileContents = [NSString stringWithContentsOfFile:filePath];
	//	NSString* fileContents = [fileCon stringByTrimmingCharactersInSet:
	NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSMutableArray* points = [[NSMutableArray alloc] initWithCapacity:pointStrings.count];
	
	for(int idx = 0; idx < pointStrings.count; idx++)
	{
		// break the string down even further to latitude and longitude fields. 
		NSString* currentPointString = [pointStrings objectAtIndex:idx];
		NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
		if(latLonArr.count <3)
			continue;
		CLLocationDegrees latitude  = [[latLonArr objectAtIndex:1] doubleValue];
		CLLocationDegrees longitude = [[latLonArr objectAtIndex:0] doubleValue];
		
		CLLocation* currentLocation = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
		[points addObject:currentLocation];
	}
	
	
	//
	// Create our map view and add it as as subview. 
	//

	SAFE_RELEASE(_mapView);
	if(nil == _mapView)
	{
		_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, startY, self.view.frame.size.width, self.view.frame.size.height)];
		[self.view addSubview:_mapView];
	}

	// create our route layer view, and initialize it with the map on which it will be rendered. 
	SAFE_RELEASE(_routeView);
	_routeView = [[CSMapRouteLayerView alloc] initWithRoute:points mapView:_mapView];
	
	[points release];
}

#pragma mark 
#pragma mark - Google Fusion access

-(void) requestFusionData{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	//NOTE with this way, cookie is send automatically, so it can be ignored
	if(_mapView)
		_mapView.hidden=YES;
	SAFE_RELEASE(requestData);

	GardeningAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	//	NSString *url;
	NSString *url = [NSString stringWithFormat: @"https://www.google.com/fusiontables/api/query?sql=SELECT  kml   FROM 1802652 WHERE 'Zipcode'='%@'",delegate.zipCode];

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
	NSLog(@"%@",requestData);
	
	//[self doAfterRequest:requestData];

	int bufLen = [requestData length]+80;
	unsigned char *buf=malloc(bufLen);
	[requestData getCString:(char*)(buf+1) maxLength:bufLen-2  encoding:NSUTF8StringEncoding ];

	NSRange range1 =[requestData rangeOfString:@"<coordinates>"];
	NSRange range2 =[requestData rangeOfString:@"</coordinates>"];

	if(range1.length >0 && range2.length>0)
	{
		NSRange range;
		range.location = range1.location+range1.length+1;
		range.length = range2.location - range.location;
		[self showMap:[requestData substringWithRange:range]];
	}
	//	
//	NSData *data=[NSData dataWithBytes:buf length:[requestData length]];
//	
//	SAFE_RELEASE(xmlParser);
//	xmlParser = [[NSXMLParser alloc] initWithData:data];
//	[xmlParser setDelegate:self];
//	[xmlParser parse];
//
//	bParse = NO;

	SAFE_RELEASE(requestData);
//	free(buf);
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


#pragma mark NSXMLParserDelegate

#define ELTYPE(typeName) (NSOrderedSame == [elementName caseInsensitiveCompare:@#typeName])

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{

	if([elementName compare:@"coordinate"]==0)
		bParse = YES;
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(bParse)
	{
		[self showMap:string];
	} 
}
@end
