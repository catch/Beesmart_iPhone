//
//  EcoregionMapController.h
//  Gardening
//
//  Created by maesinfo on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerBase.h"
#import <MapKit/MapKit.h>
#import "CSMapRouteLayerView.h"


@interface EcoregionMapController : ViewControllerBase <NSXMLParserDelegate>{

	UIWebView  *web;
	
	NSString  *requestData;
	BOOL bParse;
	NSXMLParser  *xmlParser;
	
	MKMapView* _mapView;
	CSMapRouteLayerView* _routeView;
	
}

@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) CSMapRouteLayerView* routeView;

- (void)showMap :(NSString*)fileContents;

- (void)showInWeb;

@end
