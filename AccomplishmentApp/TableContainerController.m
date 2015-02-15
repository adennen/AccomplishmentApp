//
//  TableContainerController.m
//  AccomplishmentApp
//
//  Created by Aron Dennen on 1/21/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "TableContainerController.h"
#import "TableViewController.h"
#import "DetailViewController.h"

@implementation TableContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden: NO animated: YES];
    [self.navigationController setToolbarHidden: NO animated: YES];
}

- (IBAction)notImplementedAlert:(id)sender {
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Not implemented yet"
                               message:nil
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"MySegue"]) {
        TableViewController *tvc = sender;
        //int theSection = tvc.theSection;
        NSInteger theRow = tvc.theRow;
        
        DetailViewController *vcToPush = segue.destinationViewController;
        
        vcToPush.itemTitle = tvc->completionsArray[theRow][@"title"];
        vcToPush.itemType = tvc->completionsArray[theRow][@"media_type"];
        vcToPush.itemSummary = tvc->completionsArray[theRow][@"summary"];
        
        // TODO: Pretty format the date
        // "It uses Unicode Technical Standard #35"
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormat setLocale:[NSLocale systemLocale]];
        
        NSString *dateTimeString = tvc->completionsArray[theRow][@"completed_at"];
        NSLog(@"completed_at: %@", dateTimeString);
        NSDate *myDate =[dateFormat dateFromString:dateTimeString];
        NSLog(@"myDate:          %@", myDate);
        
        // Now convert the date object to a good format
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"EEE, MMM d yyyy"];
        
        NSString *localDateString = [dateFormat2 stringFromDate:myDate];
        NSLog(@"localDateString: %@", localDateString);
        
        vcToPush.itemCompleted = localDateString;
    }
}

@end
