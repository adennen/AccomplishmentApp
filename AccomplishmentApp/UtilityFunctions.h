//
//  UtilityFunctions.h
//  AccomplishmentApp
//
//  Created by Aron Dennen on 2/8/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityFunctions : NSObject

+ (NSDictionary*)getJSONFromURL:(NSString*)inputURL;
+ (void)post:(NSString*)post atURL:(NSString*)URLstring;
    
@end
