//
//  TableContainerController.m
//  WellRead
//
//  Created by Aron Dennen on 1/21/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "TableContainerController.h"

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

- (IBAction)notImplementedMessage:(id)sender {
    [UtilityFunctions notImplementedAlert];
}


- (IBAction)addNewItem:(id)sender {
    [self performSegueWithIdentifier:@"InsertEditView" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailView"]) {
        TableViewController *tvc = sender;
        //int theSection = tvc.theSection;
        NSInteger theRow = tvc.theRow;
        
        DetailViewController *vcToPush = segue.destinationViewController;
        
        vcToPush.itemTitle = tvc->completionsArray[theRow][@"title"];
        vcToPush.itemType = tvc->completionsArray[theRow][@"media_type"];
        vcToPush.itemSummary = tvc->completionsArray[theRow][@"summary"];
        vcToPush.itemCompleted = [UtilityFunctions PrettyFormatDate:
                                  tvc->completionsArray[theRow][@"completed_at"]];
    }
    else if ([segue.identifier isEqualToString:@"InsertEditView"]) {
        // Don't do anything
    }

}

@end
