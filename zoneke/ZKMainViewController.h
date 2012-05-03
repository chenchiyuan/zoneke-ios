//
//  ZKMainViewController.h
//  zoneke
//
//  Created by tukeQ tukeQ on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKPublishViewController.h"
#import "MTStatusBarOverlay.h"

@interface ZKMainViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, MTStatusBarOverlayDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) ZKPublishViewController *publishViewController;
@property (nonatomic, assign) CGPoint origin; 
@property (nonatomic, assign) bool freshing;
@property (nonatomic, retain) MTStatusBarOverlay *statusBar;
@end
