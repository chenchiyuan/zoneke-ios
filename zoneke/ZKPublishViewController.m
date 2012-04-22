//
//  ZKPublishViewController.m
//  zoneke
//
//  Created by tukeQ tukeQ on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZKPublishViewController.h"

@implementation ZKPublishViewController
@synthesize textField = _textField;

- (void)dealloc {
    [_textField release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 90, 200, 30)];
    [self.view addSubview:_textField];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self.textField setBackgroundColor: [UIColor whiteColor]];
    
    UIView *white = [[UIView alloc] initWithFrame: self.view.bounds];
    white.backgroundColor = [UIColor blackColor];
    white.alpha = 0.3;
    [self.view addSubview: white];
    [white release];
    
    [self.view addSubview: self.textField];
    
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

#pragma TextViewDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    NSLog(@"text is %@", textField.text);
    self.textField.text = @"";
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view removeFromSuperview];
}

@end
