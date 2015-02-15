//
//  TableViewController.h
//  AccomplishmentApp
//
//  Created by Aron Dennen on 1/21/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilityFunctions.h"

@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    @public
    NSDictionary *completionsDict;
    NSArray *completionsArray;
}

@property(strong, nonatomic) NSMutableArray *segueValues;

@property NSInteger theRow;
@property NSInteger theSection;
@end
