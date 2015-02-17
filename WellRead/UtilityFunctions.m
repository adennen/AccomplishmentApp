//
//  UtilityFunctions.m
//  WellRead
//
//  Created by Aron Dennen on 2/8/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "UtilityFunctions.h"

@implementation UtilityFunctions


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

// TODO: Use threading
+ (void)post:(NSString*)post atURL:(NSString*)URLstring {
    // 1
    // Convert post string to NSData
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [[NSNumber numberWithUnsignedInteger:[postData length]] stringValue];
    
    // 2
    // Create urlrequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URLstring]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // 3
    // Connect
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(conn) NSLog(@"Connection successful");
    else NSLog(@"Connection failed");
    
    // 4
    // Use delgate methods to receive data
}

// Post receive data
+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    printf("didReceiveData called\n");
    NSLog(@"Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

// Post error
+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    printf("didFailWithError called\n");
}

// Post finished loading
+ (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    printf("connectionDidFinishLoading called\n");
    //NSLog(@"Connection: %@", connection);
}

#pragma mark - Other functions

+ (void)notImplementedAlert {
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Not implemented yet"
                               message:nil
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alert show];
}

+ (NSString*)PrettyFormatDate:(NSString *)inputDate {
    // "NSDateFormatter uses Unicode Technical Standard #35"
    
    // 1 Convert string to NSDate
    NSDateFormatter *inputDateFormat = [[NSDateFormatter alloc] init];
    [inputDateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [inputDateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [inputDateFormat setLocale:[NSLocale systemLocale]];
    NSDate *myDate =[inputDateFormat dateFromString:inputDate];
    
    // 2 Convert NSDate to pretty formatted string
    NSDateFormatter *outputDateFormat = [[NSDateFormatter alloc] init];
    [outputDateFormat setDateFormat:@"EEE, MMM d yyyy"];
    
    return [outputDateFormat stringFromDate:myDate];;
}

@end
