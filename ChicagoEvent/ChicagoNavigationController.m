//
//  ChicagoNavigationController.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-10-28.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "ChicagoNavigationController.h"

@interface ChicagoNavigationController ()

@end

@implementation ChicagoNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UINavigationBar *navBar = [self navigationBar];
        [navBar setTintColor:[UIColor colorWithRed:0.89 green:0.92 blue:0.82 alpha:0.8f]];
    }
    return self;
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
