//
//  ZKLoadMoreCell.m
//  zoneke
//
//  Created by Chiyuan on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZKLoadMoreCell.h"
#define TEXT_COLOR [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]

@implementation ZKLoadMoreCell
@synthesize loadMoreLable = _loadMoreLabel;
@synthesize activityView = _activityView;

-(void)dealloc{
    [_loadMoreLabel release];
    [_activityView release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
        _loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_loadMoreLabel.backgroundColor = [UIColor clearColor];
        _loadMoreLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        _loadMoreLabel.textAlignment = UITextAlignmentCenter;
        _loadMoreLabel.text = NSLocalizedString(@"Load More...", @"Load more page");
        _loadMoreLabel.textColor = TEXT_COLOR;
		_loadMoreLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		_loadMoreLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [self addSubview:_loadMoreLabel];
        
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview: _activityView];
    }
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    _loadMoreLabel.frame = self.bounds;
    CGSize indicatorSize = _activityView.bounds.size;
    
    CGFloat y = (self.bounds.size.height - indicatorSize.height) / 2;
    CGFloat x = self.bounds.size.width - indicatorSize.width - y;
    
    _activityView.frame = CGRectMake(x, y, indicatorSize.width, indicatorSize.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected){
        self.loadMoreLable.text = @"加载中，请稍后...";
        [self.activityView startAnimating];
    }else{
        self.loadMoreLable.text = @"载入更多";
        [self.activityView stopAnimating];
    }
    
    // Configure the view for the selected state
}

@end
