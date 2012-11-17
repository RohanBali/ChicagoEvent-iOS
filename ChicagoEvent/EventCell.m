//
//  EventCell.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-10-30.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "EventCell.h"
#import "TitleView.h"
#import "TicketsView.h"
#import "SliderView.h"

@interface EventCell()

- (void)setupSliderView;
- (void)setupImageView;
- (void)setupTitle;
- (void)setupTicket;
- (void)setupSocial;

@end

@implementation EventCell

@synthesize delegate = _delegate;

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kEventCellReuseIdentifier];
    if (self) {
        [self setupSliderView];
        [self setupTitle];
        [self setupTicket];
        [self setupSocial];
        [self setupImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [_backgroundImageView setBackgroundColor:[UIColor blueColor]];
    [_sliderView disableSliderHidden];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [_backgroundImageView setBackgroundColor:[UIColor blueColor]];
    [_sliderView disableSliderHidden];
}

#pragma marl - Public Methods

- (void)resetSliderAtIndex:(int)index {
    [_sliderView resetSliderAtIndex:index];
}

- (void)configureWithIndex:(int)index {
    _index = index;
}

#pragma mark - Setup Methods

- (void)setupSliderView {
    _sliderView = [[SliderView alloc] init];
    _sliderView.delegate = self;
    CGRect frame = _sliderView.frame;
    frame.origin.x = self.frame.size.width - frame.size.width;
    _sliderView.frame = frame;
    [self addSubview:_sliderView];
}

- (void)setupImageView {
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, self.frame.size.height)];
    [_backgroundImageView setBackgroundColor:[UIColor blueColor]];
    [self addSubview:_backgroundImageView];
}

- (void)setupTitle {
    _titlevView = [[TitleView alloc] init];
    [_sliderView insertView:_titlevView];
}

- (void)setupTicket {
    _ticketView = [[TicketsView alloc] init];
    [_sliderView insertView:_ticketView];
}

- (void)setupSocial {
    _socialView = [[SocialView alloc] init];
    [_sliderView insertView:_socialView];
}

#pragma mark - Delegate Methods

- (void)didSlideToIndex:(int)index {
    if ([_delegate respondsToSelector:@selector(cellAtRow:didSlideToIndex:)]) {
        [_delegate cellAtRow:_index didSlideToIndex:index];
    }
}

@end
