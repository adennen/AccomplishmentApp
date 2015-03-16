//
//  InsertEditViewController.m
//  WellRead
//
//  Created by Aron Dennen on 2/15/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "InsertEditViewController.h"

@interface InsertEditViewController () {
    
    __weak IBOutlet UITextField *titleField;
    __weak IBOutlet UITextField *mediaField;
    __weak IBOutlet UITextField *summaryField;
    
    __weak IBOutlet UIButton *submitButton;
    
}

@end

@implementation InsertEditViewController

// TODO:
// Spinner for date and media type
// Increase summary size to multiline

- (void)viewDidLoad {
    [super viewDidLoad];
    
    submitButton.layer.borderWidth = 2.0f;
    submitButton.layer.cornerRadius = 10;
    submitButton.layer.borderColor =
        [[UIColor colorWithRed: 0.0f green: 0.5f blue: 1.0f alpha: 1.0f] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insertNewRecord:(id)sender {
    [UtilityFunctions post:[NSString stringWithFormat:@"completion[title]=%@&completion[media_type]=%@&completion[summary]=%@",
                titleField.text, mediaField.text, summaryField.text]
         atURL:@"http://wellread.io/completions"];
    
    // TODO: Add insert view logic
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Success?"
                               message:nil
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alert show];
}

- (IBAction)updateExistingRecord:(id)sender {
    // TODO: Get the ID of the record being edited from somewhere
    NSString *updateURL = [NSString stringWithFormat:@"http://wellread.io/completions/%d", 4];
    
    [UtilityFunctions put:[NSString stringWithFormat:@"completion[title]=%@&completion[media_type]=%@&completion[summary]=%@",
    titleField.text, mediaField.text, summaryField.text]
    atURL:updateURL];
    
    // TODO: Check for actual success and update views accordingly
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Success?"
                               message:nil
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alert show];
    
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
