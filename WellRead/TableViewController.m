//
//  TableViewController.m
//  WellRead
//
//  Created by Aron Dennen on 1/21/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController () {

}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init stuff
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    completionsArray = [[NSMutableArray alloc] init];
    
    [self refresh];
}

// Just added to test if embed is necessary
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden: NO animated: YES];
    [self.navigationController setToolbarHidden: NO animated: YES];
}

- (void)refresh {
    // TODO: multithreading
    
    [self.refreshControl beginRefreshing];
    
    // Get JSON data into NSDictionary
    completionsDict = [UtilityFunctions getJSONFromURL:@"http://wellread.io/completions"];
    
    // Populate the mutable array
    NSArray *completions = (NSArray*)completionsDict[@"completions"];
    
    [completionsArray removeAllObjects];
    
    for (int i = 0; i < [completions count]; i++) {
        [completionsArray addObject:completions[i]];
    }
    
    [[self tableView] reloadData];
    //getField.text = [completionsArray lastObject][@"title"];
    
    [self.refreshControl endRefreshing];
}


/*
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    printf("tableView willDisplayHeaderView: called\n");
    // Set the text color of our header/footer text.
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    header.textLabel.text = self.segueValues[section][0][@"completionDate"];
    
    // Set the background color of our header/footer.
    header.contentView.backgroundColor = [UIColor blackColor];
    
    // You can also do this to set the background color of our header/footer,
    //    but the gradients/other effects will be retained.
    // view.tintColor = [UIColor blackColor];
}*/

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42.0;
}*/


/*
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return self.segueValues[section][0][@"completionDate"];
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.theRow = indexPath.row;
    self.theSection = indexPath.section;
    [self performSegueWithIdentifier:@"DetailView" sender:self];
}

// Table cell editing
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *deletionURL =
        [NSString stringWithFormat:@"http://wellread.io/completions/%@",
         completionsArray[indexPath.row][@"id"]];
        
        NSLog(@"Deletion URL:%@", deletionURL);
        
        [UtilityFunctions deleteAtURL:deletionURL];
        
        // TODO: Only delete if success!
        [completionsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - Init tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Return the number of rows for a given section (Required method). "How many rows in each section?"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSArray *myArray = (NSArray*)[self.segueValues objectAtIndex:section];
    return completionsArray.count;
}

// Returns a UITableViewCell given a section and a row (Required method). "Give me a cell to draw at a given row in a given section"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell values
    
    if (completionsArray[indexPath.row][@"media_type"] != [NSNull null]) {
        NSString *mediaType = completionsArray[indexPath.row][@"media_type"];
        NSString *imageToUse = ([mediaType isEqualToString:@"book"]) ? @"book_PNG2116.png" : @"2000px-VHS_diagonal.svg";
        
        cell.imageView.image = [UIImage imageNamed:imageToUse];
    }
    cell.textLabel.text = completionsArray[indexPath.row][@"title"];
    
    return cell;	// And that's it
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailView"]) {
        TableViewController *tvc = sender;
        //int theSection = tvc.theSection;
        NSInteger theRow = tvc.theRow;
        
        DetailViewController *vcToPush = segue.destinationViewController;
        
        vcToPush.itemTitle = completionsArray[theRow][@"title"];
        vcToPush.itemType = completionsArray[theRow][@"media_type"];
        vcToPush.itemSummary = completionsArray[theRow][@"summary"];
        vcToPush.itemCompleted = [UtilityFunctions PrettyFormatDate:
                                  completionsArray[theRow][@"completed_at"]];
    }
    else if ([segue.identifier isEqualToString:@"InsertEditView"]) {
        // Don't do anything
    }
}

@end
