//
//  NSString+composing.m
//  zoneke
//
//  Created by  on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+composing.h"

@implementation NSString (composing)

- (Composing *)composing{
    int length = [self length];
    
    Composing *result;
    
    if (length < MAX_LINE_WIDTH){
        result->width = length;
        result->height = MIN_DIALOG_HEIGHT;
        result->lines = 1;
        
    }else if( length > MAX_LINE_WIDTH * 3){
        result->width = MAX_LINE_WIDTH;
        result->height = MIN_DIALOG_HEIGHT - 20 + 3*16;
        result->lines = 3;
        
    }else if( length>2*MAX_LINE_WIDTH && length<3*MAX_LINE_WIDTH*3){
        float avg_width = length/3 + 20 < MAX_LINE_WIDTH? length/3 + 20: MAX_LINE_WIDTH;
        result->width = avg_width;
        result->lines = (length/avg_width + 1);
        result->height = MIN_DIALOG_HEIGHT - 20 + result->lines*16;
        
    }else{
        float avg_width = length/2 + 20 < MAX_LINE_WIDTH? length/2 + 20: MAX_LINE_WIDTH;
        result->width = avg_width;
        result->lines = (length/avg_width + 1);
        result->height = MIN_DIALOG_HEIGHT - 20 + result->lines*16;        
    }
    
    return result;
}

@end
