//
//  UtilityFunctions.h
//  WellRead
//
//  Created by Aron Dennen on 2/8/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilityFunctions : NSObject

+ (NSDictionary*)getJSONFromURL:(NSString*)inputURL;

+ (void)post:(NSString*)post atURL:(NSString*)URLstring;
+ (void)put:(NSString*)put atURL:(NSString*)URLstring;
+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data;
+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
+ (void)connectionDidFinishLoading:(NSURLConnection *)connection;

+ (void)deleteAtURL:(NSString*)URLstring;

+ (void)notImplementedAlert;
+ (NSString*)PrettyFormatDate:(NSString *)inputDate;
    
@end
