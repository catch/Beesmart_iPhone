//
//  Copyright 2011 Catch.com, Inc.
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//      http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

//
//  NSObject+JsonParanoia.h
//  CatchClient
//
//  Created by Jeff Meininger on 4/18/11.
//

#import <Foundation/Foundation.h>


@interface NSObject (JsonParanoia)

// Quick type check.  Throws on error or type mismatch.
+ (void)verifyJsonObject:(NSObject *)obj isOfClass:(Class)class;

@end
