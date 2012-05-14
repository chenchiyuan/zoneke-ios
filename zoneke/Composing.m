//
//  Composing.m
//  zoneke
//
//  Created by  on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Composing.h"
#define MAX_LINE_WIDTH 180
#define MIN_DIALOG_HEIGHT 60

@implementation Composing

@synthesize height = _height;
@synthesize width = _width;
@synthesize lines = _lines;

- (id)initWithLines:(int) lines height:(float) height width:(float) width{
    self = [super init];
    if (self){
        self.height = height;
        self.width = width;
        self.lines = lines;
    }
    return self;
}

- (id) initWithString:(NSString *)content{
    int length = [content length]*10    ;
    int lines = 1;
    float height = MIN_DIALOG_HEIGHT;
    float width = MAX_LINE_WIDTH;
    
    NSLog(@"Content length is %d", length);
    
    if (length < MAX_LINE_WIDTH){
        width = length;
        height = MIN_DIALOG_HEIGHT;
        lines = 1;
        
    }else if( length > MAX_LINE_WIDTH * 3){
        width = MAX_LINE_WIDTH;
        height = MIN_DIALOG_HEIGHT - 20 + 3*16;
        lines = 3;
        
    }else if( length>2*MAX_LINE_WIDTH && length<3*MAX_LINE_WIDTH*3){
        float avg_width = length/3 + 20 < MAX_LINE_WIDTH? length/3 + 20: MAX_LINE_WIDTH;
        width = avg_width;
        lines = (length/avg_width + 1);
        height = MIN_DIALOG_HEIGHT - 20 +  lines*16;
        
    }else{
        float avg_width = length/2 + 20 < MAX_LINE_WIDTH? length/2 + 20: MAX_LINE_WIDTH;
        width = avg_width;
        lines = (length/avg_width + 1);
        height = MIN_DIALOG_HEIGHT - 20 +  lines*16;        
    }
    
    width += 20;
    
    NSLog(@"Result width %f, height %f, lines %i", width, height, lines);
    
    return [self initWithLines:lines height:height width:width];
}

@end
