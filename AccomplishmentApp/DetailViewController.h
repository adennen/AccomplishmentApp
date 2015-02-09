//
//  DetailViewController.h
//  AccomplishmentApp
//
//  Created by Aron Dennen on 1/21/15.
//  Copyright (c) 2015 Aron Dennen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property(strong, nonatomic) NSString *itemTitle;
@property(strong, nonatomic) NSString *itemType;
@property(strong, nonatomic) NSString *itemSummary;
@property(strong, nonatomic) NSString *itemCompleted;

@end
