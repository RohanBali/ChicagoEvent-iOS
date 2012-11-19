//
//  ViewController.h
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-09-29.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventCell.h"
#import "EventsManager.h"

@interface HomeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,EventCellDelegate, EventsManagerDelegate>{
     UIScrollView *_scrollView;
    IBOutlet UITableView *_tableView;
    NSMutableDictionary *_cellIndexDictionary;
}

- (id)initWithNib;

@end
