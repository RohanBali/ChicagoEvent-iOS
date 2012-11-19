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
    _cellIndexDictionary = [[NSMutableDictionary alloc] init]; //Cell array is used to use the same cell at that index path, so the slider state is maintained
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[EventsManager getSharedInstance] setDelegate:self];
    [[EventsManager getSharedInstance] getMoreEvents];
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
    NSString *evetDateKey = [[[EventsManager getSharedInstance] sortedKeys] objectAtIndex:indexPath.section];
    NSArray *eventForDate = [[[EventsManager getSharedInstance] eventsDictionary] objectForKey:evetDateKey];
    [cell configureWithIndex:indexPath andEvent:[eventForDate objectAtIndex:indexPath.row]];
    
    NSString *indexString = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    
    if ([[_cellIndexDictionary allKeys] count] > indexPath.section) {
        [cell resetSliderAtIndex:[(NSNumber *)([_cellIndexDictionary objectForKey:indexString]) intValue]];
    } else {
        [_cellIndexDictionary setObject:[NSNumber numberWithInt:0] forKey:indexString];
        [cell resetSliderAtIndex:0];
    }
    
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[[EventsManager getSharedInstance] eventsDictionary] allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keysArray = [[EventsManager getSharedInstance] sortedKeys];
    return [[[[EventsManager getSharedInstance] eventsDictionary] objectForKey:[keysArray objectAtIndex:section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keysArray = [[EventsManager getSharedInstance] sortedKeys];
    return (NSString *)[keysArray objectAtIndex:section];
}

#pragma mark - EventCell Delegate Methods
//
//- (void)cellAtRow:(int)row didSlideToIndex:(int)index {
//    [_cellIndexArray replaceObjectAtIndex:row withObject:[NSNumber numberWithInt:index]];
//}

- (void)cellAtIndex:(NSIndexPath *)cellIndex didSlideToIndex:(int)index {
    [_cellIndexDictionary setObject:[NSString stringWithFormat:@"%d",index] forKey:[NSString stringWithFormat:@"%d-%d",cellIndex.section,cellIndex.row]];
}

#pragma mark - EventManagerDelegate Methods

- (void)eventsFetchComplete {
    [_tableView reloadData];
}

@end
