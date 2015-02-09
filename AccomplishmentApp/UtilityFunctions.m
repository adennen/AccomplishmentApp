//
//  UtilityFunctions.m
//  AccomplishmentApp
//
//  Created by Aron Dennen on 2/8/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "UtilityFunctions.h"

@implementation UtilityFunctions

#pragma mark - Utility functions

+ (NSDictionary*)getJSONFromURL:(NSString*)inputURL {
    // 1
    // Web data to String
    NSURL *theURL = [NSURL URLWithString: inputURL];
    NSError __autoreleasing *error;
    NSString *webContents = [[NSString alloc] initWithContentsOfURL:theURL encoding: NSUTF8StringEncoding error: &error];
    
    if (webContents == nil) NSLog(@"Error reading url at %@\n%@", theURL, error.localizedFailureReason);
    else {
        // 2
        // JSON dictionary from String
        error = nil;
        id jsonDictionary = [NSJSONSerialization JSONObjectWithData:
                             [webContents dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
        if (error) NSLog(@"NSJSON error occurred.\n%@", error.localizedFailureReason);
        
        // 3
        // Get JSON values
        if ([jsonDictionary isKindOfClass:[NSDictionary class]]) {
            return jsonDictionary;
        }
    }
    return nil;
}

#pragma mark - Web post request

+ (void)post:(NSString*)post atURL:(NSString*)URLstring {
    // 1
    // Convert post to data
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [[NSNumber numberWithUnsignedInteger:[postData length]] stringValue];
    
    // 2
    // Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URLstring]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // 3
    // Connection
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(conn) NSLog(@"Connection Successful");
    else NSLog(@"Connection could not be made");
    
    // 4
    // Use delgate methods to receive data
}

// Post receive data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    printf("didReceiveData called\n");
    NSLog(@"Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

// Post error
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    printf("didFailWithError called\n");
}

// Post finished loading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    printf("connectionDidFinishLoading called\n");
    //NSLog(@"Connection: %@", connection);
}

@end
