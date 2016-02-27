//
//  PunchhZBarReaderViewController.m
//  Punchh Framework
//
//  Created by Hemant on 10/7/13.
//  Copyright (c) 2013 Punchh. All rights reserved.
//

#import "PunchhZBarReaderViewController.h"

@interface PunchhZBarReaderViewController ()

@end

@implementation PunchhZBarReaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView {
	self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
