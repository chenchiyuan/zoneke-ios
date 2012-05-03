//
//  ZKItemCellText.m
//  zoneke
//
//  Created by tukeQ tukeQ on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZKItemCellText.h"

@implementation ZKItemCellText
@synthesize zk_num;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithNum:(int)num andFrame:(CGRect)frame{
    self = [self initWithFrame: frame];
    self.zk_num = num;
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect: rect];
    
    UIImage* image = [UIImage imageNamed:@"bg-addbutton.png"];
    [image drawInRect: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    
    NSArray *fontNames = [UIFont familyNames];
    UIFont* font = [UIFont fontWithName: [fontNames objectAtIndex:self.zk_num] size: 15];
    
    
    NSString *text = [NSString stringWithFormat:@"%@ A table view uses cell objects to draw its visible rows and caches those objects as long as the rows are visible. These objects inherit from the UITableViewCell class. The table view’s data source provides the cell objects to the table view by implementing the tableView:cellForRowAtIndexPath: method, a required method of the UITableViewDataSource protocol. The following sections describe the characteristics of table-view cell objects, explain how to use the default capabilities of UITableViewCell for setting cell content, and show how to create custom UITableViewCell objects %d", [fontNames objectAtIndex:self.zk_num], self.zk_num];
    
    [text drawInRect:CGRectMake(10, 5, 200, 50) withFont:font lineBreakMode:UILineBreakModeMiddleTruncation alignment:UITextAlignmentLeft];
}


@end
