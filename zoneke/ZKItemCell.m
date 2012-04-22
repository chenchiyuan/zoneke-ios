//
//  ZKItemCell.m
//  zoneke
//
//  Created by tukeQ tukeQ on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZKItemCell.h"

@implementation ZKItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) loadData:(int) num{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    label.text = [NSString stringWithFormat:@"tukeQ num %d", num];
    [self.contentView addSubview: label];
}

@end
