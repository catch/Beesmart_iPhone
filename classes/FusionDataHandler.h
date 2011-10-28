//
//  FusionDataHandler.h
//  Gardening
//
//  Created by maesinfo on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FusionDataHandler : NSObject {

}

- (NSString*) sendXMLRequest: (NSString*)url;
- (void) sendXMLRequestAsync: (NSString*)url delegateForRequest:(id)delegateForRequest;
- (NSString*) postURLRequest: (NSString*)url body:(NSString*)body;

@end
