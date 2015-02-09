//
//  DetailViewController.m
//  AccomplishmentApp
//
//  Created by Aron Dennen on 1/21/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    __weak IBOutlet UILabel *itemTitleLabel;
    __weak IBOutlet UILabel *itemTypeLabel;
    __weak IBOutlet UILabel *itemSummaryLabel;
    __weak IBOutlet UILabel *itemCompletedLabel;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set labels to the passed in string values
    itemTitleLabel.text = self.itemTitle;
    
    itemTypeLabel.text = self.itemType;
    
    if (self.itemSummary == (NSString*)[NSNull null]) {
        itemSummaryLabel.text = @"No summary has been set";
    } else {
    itemSummaryLabel.text = self.itemSummary;
    }
    
    itemCompletedLabel.text = self.itemCompleted;
}

@end
