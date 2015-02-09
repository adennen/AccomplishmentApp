//
//  TableViewController.m
//  AccomplishmentApp
//
//  Created by Aron Dennen on 1/21/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "TableViewController.h"
#import "UtilityFunctions.h"

@interface TableViewController () {

}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segueValues = [NSMutableArray arrayWithArray: @[
                        @[
                             @{@"itemTitle":@"1984 - George Orwell", @"completionDate":@"Jan 3rd, 2015",
                               @"mediaType":@"book", @"webAddress":@"http://www.amazon.com/1984-Signet-Classics-George-Orwell/dp/0451524934/" },
                             
                             @{@"itemTitle":@"The Roman Empire", @"completionDate":@"Jan 3rd, 2015",
                               @"mediaType":@"video", @"webAddress":@"http://www.amazon.com/Rome-Order-Chaos-Years-Trial/dp/B002R9LQ6O/" },
                             
                             @{@"itemTitle":@"1984 - George Orwell", @"completionDate":@"Jan 3rd, 2015",
                               @"mediaType":@"video", @"webAddress":@"http://www.amazon.com/1984-John-Hurt/dp/B0039O8AQK/" },
                         ],
                        @[
                             @{@"itemTitle":@"1985 - Anthony Burgess", @"completionDate":@"Jan 9th, 2015",
                               @"mediaType":@"book", @"webAddress":@"http://www.amazon.com/1985/dp/1846689198/" }
                         ],
                        @[
                             @{@"itemTitle":@"Marvel 1985", @"completionDate":@"Jan 18th, 2015",
                               @"mediaType":@"book", @"webAddress":@"http://www.amazon.com/Marvel-1985-Mark-Millar-ebook/dp/B00AAJR14O/" },
                         
                             @{@"itemTitle":@"Programming iOS 7", @"completionDate":@"Jan 18th, 2015",
                               @"mediaType":@"video", @"webAddress":@"http://www.amazon.com/Programming-iOS-7-Matt-Neuburg/dp/1449372341/" }
                         ]
                        ]];
    
    // TODO: multithreading
    
    // Get JSON data into NSDictionary
    completionsDict = [UtilityFunctions getJSONFromURL:@"https://blooming-earth-7934.herokuapp.com/completions"];

    
    //NSLog(@"Count: %zd", completionsArray.count);
    completionsArray = (NSArray*)completionsDict[@"completions"];
    //NSLog(@"Count: %zd", completionsArray.count);
    
    NSLog(@"completions array: %@", completionsArray[1][@"title"]);
    
    
    
    [[self tableView] reloadData];
    //getField.text = [completionsArray lastObject][@"title"];
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
    [self.parentViewController performSegueWithIdentifier:@"MySegue" sender:self];
}

// Edit mode
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSLog(@"1. %@", NSStringFromClass([self.segueValues class]));
        NSLog(@"2. %@", NSStringFromClass([self.segueValues[0] class]));
        [self.segueValues[indexPath.section] removeObjectAtIndex:indexPath.row];
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
    printf("numberOfRows called\n");
    return completionsArray.count;
}

// Returns a UITableViewCell given a section and a row (Required method). "Give me a cell to draw at a given row in a given section"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell values
    
    /*
    NSString *mediaType = self.segueValues[indexPath.section][indexPath.row][@"mediaType"];
    NSString *imageToUse = ([mediaType isEqualToString:@"book"]) ? @"book_PNG2116.png" : @"2000px-VHS_diagonal.svg";
    
    cell.textLabel.text = self.segueValues[indexPath.section][indexPath.row][@"itemTitle"];
    cell.imageView.image = [UIImage imageNamed:imageToUse];
     */
    cell.textLabel.text = completionsArray[indexPath.row][@"title"];
    
    return cell;	// And that's it
}

@end
