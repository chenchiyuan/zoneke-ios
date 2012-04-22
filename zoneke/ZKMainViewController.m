//
//  ZKMainViewController.m
//  zoneke
//
//  Created by tukeQ tukeQ on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZKMainViewController.h"
#import "ZKItemCell.h"
#import "ZKMapViewController.h"
#import "ZKPublishViewController.h"

@implementation ZKMainViewController
@synthesize scrollView = _scrollView;
@synthesize tableView = _tableView;
@synthesize backView = _backView;
@synthesize publishViewController = _publishViewController;
@synthesize origin;

- (void)dealloc{
    [_publishViewController release];
    [_backView release];
    [_tableView release];
    [_scrollView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        origin = CGPointMake(0, 0);
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) selectMap{
    ZKMapViewController *mapViewController = [[[ZKMapViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (void) selectPublish{
    [self.view addSubview: self.publishViewController.view];    
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.title = @"ZoneKe";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStyleBordered target:self action:@selector(selectMap)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"提问" style:UIBarButtonItemStyleBordered target:self action: @selector(selectPublish)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
 
    
    CGRect scrollFrame = self.view.bounds;
    _scrollView = [[UIScrollView alloc] initWithFrame: scrollFrame];
    [self.scrollView setBackgroundColor:[UIColor redColor]];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(scrollFrame.size.width + 100, scrollFrame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    [self.view addSubview: self.scrollView];    
    
    _tableView = [[UITableView alloc] initWithFrame:scrollFrame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    self.tableView.tableFooterView =  imageView;
    [imageView release];
    [self.scrollView addSubview: _tableView];
    
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.3;
    self.backView.hidden = YES;
    [self.view addSubview:self.backView];
    
    _publishViewController = [[ZKPublishViewController alloc] initWithNibName:nil bundle:nil];
    _publishViewController.view.frame = self.view.bounds;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{     
    NSLog(@"offset x %f", scrollView.contentOffset.x);
    CGPoint offset = scrollView.contentOffset;
    if (offset.x < 0){
        self.scrollView.contentOffset = CGPointMake(0, offset.y);
    }
    if ((offset.x - origin.x) > 0){
        if (offset.x > 40) self.scrollView.contentOffset = CGPointMake(offset.x, offset.y);
    }else{
        if (offset.x <= 40) self.scrollView.contentOffset = CGPointMake(0, offset.y); 
    }
    
    self.origin = scrollView.contentOffset;
}


#pragma TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * itemCellIdentifier = @"ZKItemCell";
    ZKItemCell *itemCell = [self.tableView dequeueReusableCellWithIdentifier: itemCellIdentifier];
    if (itemCell == nil){
        itemCell = [[[ZKItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier] autorelease];
    }
    [itemCell loadData: [indexPath row]];
    return itemCell;
    
}

#pragma TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"did select %d", [indexPath row]);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma AlertView Delegate
- (void)alertViewCancel:(UIAlertView *)alertView{
    self.backView.hidden = YES;
}

@end
