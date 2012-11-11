//
//  ChicagoTabBarController.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-10-27.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "ChicagoTabBarController.h"

@interface ChicagoTabBarController ()

- (void)setupTabBarButton;

@end

@implementation ChicagoTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTabBarButton];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabBarButton {
        [self.tabBar setHidden:YES];
        
        UIView *tabBarContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - 49.0f, 320.0f, 49.0f)];
        [tabBarContainer setBackgroundColor:[UIColor blackColor]];
        
        _tabBarButtons = [[NSMutableArray alloc] init];
        
        UIButton *allEventsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allEventsButton setFrame:CGRectMake(0.0f, 0.0f, 160.0f, 49.0f)];
        [allEventsButton setAdjustsImageWhenHighlighted:NO];
        [allEventsButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [allEventsButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected];
        [allEventsButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected | UIControlStateHighlighted];
        [allEventsButton addTarget:self action:@selector(dashboardButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [tabBarContainer addSubview:allEventsButton];
        [_tabBarButtons addObject:allEventsButton];
        
               
        UIButton *calenderEventsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [calenderEventsButton setFrame:CGRectMake(160.0f, 0.0f, 160.0f, 49.0f)];
        [calenderEventsButton setAdjustsImageWhenHighlighted:NO];
        [calenderEventsButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [calenderEventsButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected];
        [calenderEventsButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected | UIControlStateHighlighted];
        [calenderEventsButton addTarget:self action:@selector(profileButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [tabBarContainer addSubview:calenderEventsButton];
        [_tabBarButtons addObject:calenderEventsButton];
        
        [self.view addSubview:tabBarContainer];
}

#pragma mark - Override Methods

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex == [self selectedIndex]) {
        [[self.viewControllers objectAtIndex:selectedIndex] popToRootViewControllerAnimated:YES];
    }
    for (int i = 0; i < [_tabBarButtons count]; i++) {
        UIButton *button = [_tabBarButtons objectAtIndex:i];
        [button setSelected:(i == selectedIndex)];
    }
    [super setSelectedIndex:selectedIndex];
}

#pragma mark - Button Methods

- (void)dashboardButtonPressed:(id)sender {
    [self setSelectedIndex:0];
}

- (void)profileButtonPressed:(id)sender {
    [self setSelectedIndex:1];
}


@end
