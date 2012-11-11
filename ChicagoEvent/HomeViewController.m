//
//  ViewController.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-09-29.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "HomeViewController.h"
#import "EventCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNib {
    self = [super initWithNibName:@"HomeViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:kEventCellReuseIdentifier];
    if(!cell) {
        cell = [[EventCell alloc] init];
    }
    
//    [cell.textLabel setText:@"This Cell is ok"];
//    [cell.textLabel setTextColor:[UIColor blackColor]];
//    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
//    UIImageView *cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,cell.frame.size.width, 44.0f)];
//    [cell setBackgroundView:cellImage];
    
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

@end
