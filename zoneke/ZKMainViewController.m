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
#import "ZKExploreViewController.h"
#import "ZKLoadMoreCell.h"
#import "MTStatusBarOverlay.h"

@implementation ZKMainViewController
@synthesize scrollView = _scrollView;
@synthesize tableView = _tableView;
@synthesize backView = _backView;
@synthesize publishViewController = _publishViewController;
@synthesize origin;
@synthesize freshing;
@synthesize statusBar = _statusBar;

- (void)dealloc{
    [_statusBar release];
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
        freshing = NO;
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
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    freshing = NO;
    NSLog(@"did load view");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_statusBar == nil){
        _statusBar = [MTStatusBarOverlay sharedInstance];
        _statusBar.animation = MTStatusBarOverlayAnimationFallDown;  // MTStatusBarOverlayAnimationShrink
        _statusBar.detailViewMode = MTDetailViewModeCustom;         // enable automatic history-tracking and show in detail-view
        _statusBar.delegate = self;
        _statusBar.progress = 0.0;
        [_statusBar postMessage:@"发送问题..."];
        _statusBar.progress = 0.1;
        // ...
        [_statusBar postMessage:@"网络传输中..." animated:NO];
        _statusBar.progress = 0.5;
        // ...
        [_statusBar postImmediateFinishMessage:@"得到数据，处理中..." duration:2.0 animated:YES];
        _statusBar.progress = 1.0;
    }
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
    NSLog(@"offset x %f, y %f", scrollView.contentOffset.x, scrollView.contentOffset.y);
    float totalOffsetY = ([[UIFont familyNames] count] + 1) *60 - self.tableView.bounds.size.height;
    if (scrollView.contentOffset.y > totalOffsetY + 100 && !freshing){
        freshing = YES;
        NSIndexPath *path = [NSIndexPath indexPathForRow:[[UIFont familyNames] count] inSection:0];
        [self.tableView selectRowAtIndexPath: path animated:YES scrollPosition: UITableViewScrollPositionNone];
    }
    CGPoint offset = scrollView.contentOffset;
    if (offset.x < 0){
        self.scrollView.contentOffset = CGPointMake(0, offset.y);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"End deceleratiing");
    CGPoint currentOffset = self.scrollView.contentOffset;
    if (currentOffset.x < 40){
        self.scrollView.contentOffset = CGPointMake(0, currentOffset.y);
    }else{
        self.scrollView.contentOffset = CGPointMake(100, currentOffset.y);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"End Dragging");
    CGPoint currentOffset = self.scrollView.contentOffset;
    if (currentOffset.x < 40){
        self.scrollView.contentOffset = CGPointMake(0, currentOffset.y);
    }else{
        self.scrollView.contentOffset = CGPointMake(100, currentOffset.y);
    }
}


#pragma TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == [[UIFont familyNames] count]) {
        static NSString * moreCellIdentifier = @"ZKLoadMoreCell";
        ZKLoadMoreCell * more = [self.tableView dequeueReusableCellWithIdentifier: moreCellIdentifier];
        if (more == nil){
            more = [[[ZKLoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellIdentifier] autorelease];
        }
        more.selectionStyle = UITableViewCellSelectionStyleNone;    
        return more;
    }
    
    static NSString * itemCellIdentifier = @"ZKItemCell";
    ZKItemCell *itemCell = [self.tableView dequeueReusableCellWithIdentifier: itemCellIdentifier];
    if (itemCell == nil){
        itemCell = [[[ZKItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier] autorelease];
    }
    itemCell.num = [indexPath row];
    [itemCell loadData];
    return itemCell;
    
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[UIFont familyNames] count] + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == [[UIFont familyNames] count]){
        return;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZKExploreViewController *exploreViewController = [[ZKExploreViewController alloc] initWithName: [NSString stringWithFormat:@"tukeqQ num %d", [indexPath row]]];
    [self.navigationController pushViewController:exploreViewController animated:YES];
    [exploreViewController release];
}

#pragma mark - AlertView Delegate
- (void)alertViewCancel:(UIAlertView *)alertView{
    self.backView.hidden = YES;
}

@end
