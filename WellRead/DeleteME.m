//
//  DeleteME.m
//  WellRead
//
//  Created by Aron Dennen on 1/22/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "DeleteME.h"

@interface DeleteME() {
    __weak IBOutlet UIScrollView *theScrollView;
    __weak IBOutlet UITextField *inputControl;
    __weak IBOutlet UIView *contentView;
}
@end

@implementation DeleteME

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
        addObserver:self selector:@selector(keyboardWillShow:)
        name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
        addObserver:self selector:@selector(keyboardWillHide:)
        name:UIKeyboardWillHideNotification object:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //printf("Scroll: %f, %f\n", theScrollView.contentOffset.x, theScrollView.contentOffset.y);
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Magic formula to follow
    
    CGFloat inputControlAbsPos = [self.view convertPoint:inputControl.frame.origin fromView:contentView].y +
        inputControl.frame.size.height + 8; // Get the bottom coordinate of the input control plus some space
    CGFloat scrollDelta = inputControlAbsPos - (self.view.frame.size.height - keyboardSize.height);
    [theScrollView setContentOffset: CGPointMake(0, theScrollView.contentOffset.y + scrollDelta) animated: NO];
     
    //Apple's shitter magic formula. Ehh it's a toss up. The apple method has better support for keyboard quicktype thing shits
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 8, 0.0);
    //theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
    //[theScrollView scrollRectToVisible:inputControl.frame animated:NO];
     
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    //[theScrollView setContentOffset: CGPointMake(0, 0) animated: NO];
    
    // Apple reset insets - drawback is resetting the insets is required
    // however, it does make the scroll bar pretty. Best of both worlds?
    // Set insets for the scroll bar only.
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
    
    [theScrollView setContentOffset: CGPointMake(0, 0) animated: NO];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
