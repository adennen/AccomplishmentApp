//
//  ViewController.m
//  AccomplishmentApp
//
//  Created by Aron Dennen on 1/13/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSTimer *loginTimer;
}
@property (weak, nonatomic) IBOutlet UIView *loginBox;
@property (weak, nonatomic) IBOutlet UIButton *theButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _loginBox.layer.cornerRadius = 8;
    
    _theButton.layer.borderWidth = 2.0f;
    _theButton.layer.cornerRadius = 10;
    _theButton.layer.borderColor =
        [[UIColor colorWithRed: 0.0f green: 0.5f blue: 1.0f alpha: 1.0f] CGColor];
    
    // Set background gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:160/255. green:156/255. blue:213/255. alpha:1.0] CGColor],
                       (id)[[UIColor colorWithRed:9/255. green:7/255. blue:37/255. alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    
    // Setup
    self.loginBox.alpha = 0.0;
    CGPoint savedLocation = self.loginBox.center;
    self.loginBox.center = CGPointMake(self.view.bounds.size.width/2,
                                       self.view.bounds.size.height);
    
    // Initial animation
    [UIView animateWithDuration: 1.2
                          delay: 0.25
         usingSpringWithDamping: .6
          initialSpringVelocity: 10
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.loginBox.alpha = 1.0;
                         self.loginBox.center = savedLocation;
                     }
                     completion:^(BOOL done){
                     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden: YES animated: YES];
    [self.navigationController setToolbarHidden: YES animated: YES];
}

- (IBAction)loginPressed:(id)sender {
    [self disableButton];
    [self.activityIndicator startAnimating];
    loginTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self
                                                selector:@selector(timerFired) userInfo:nil repeats:NO];
}

- (void)timerFired {
    [self.activityIndicator stopAnimating];
    [self enableButton];
    [self performSegueWithIdentifier:@"LogIn" sender:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)enableButton {
    _theButton.enabled = true;
    _theButton.layer.borderColor =
    [[UIColor colorWithRed: 0.0f green: 0.5f blue: 1.0f alpha: 1.0f] CGColor];
}

- (void)disableButton {
    _theButton.enabled = false;
    _theButton.layer.borderColor =
    [[UIColor colorWithRed: 0.4f green: 0.4f blue: 0.4f alpha: 1.0f] CGColor];
}

@end
