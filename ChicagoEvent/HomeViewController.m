//
//  ViewController.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-09-29.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNib {
    self = [super initWithNibName:@"HomeViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    _cellIndexArray = [[NSMutableArray alloc] init]; //Cell array is used to use the same cell at that index path, so the slider state is maintained
    
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
    if (!cell) {
        cell = [[EventCell alloc] init]; //Don't reuse becuase it resets
    }
    cell.delegate = self;
    [cell configureWithIndex:indexPath.row];
    if ([_cellIndexArray count] > indexPath.row) {
        [cell resetSliderAtIndex:[(NSNumber *)([_cellIndexArray objectAtIndex:indexPath.row]) intValue]];
    } else {
        [_cellIndexArray addObject:[NSNumber numberWithInt:0]];
        [cell resetSliderAtIndex:0];
    }
    
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

#pragma mark - EventCell Delegate Methods

- (void)cellAtRow:(int)row didSlideToIndex:(int)index {
    [_cellIndexArray replaceObjectAtIndex:row withObject:[NSNumber numberWithInt:index]];
}

@end
