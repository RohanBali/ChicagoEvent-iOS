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
- (void)setupSliderButton;
- (void)switchViews;
- (void)shiftArray;
- (void)animateSliderIn:(UIControl *)control;

@end

@implementation EventCell

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kEventCellReuseIdentifier];
    if (self) {
        _circularArray = [[NSMutableArray alloc] init];
        [self setupSliderView];
        [self setupTitle];
        [self setupTicket];
        [self setupSliderButton];
        [self setupImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [_sliderButton setBackgroundColor:[UIColor redColor]];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [_sliderButton setBackgroundColor:[UIColor redColor]];
}

#pragma mark - Setup Methods

- (void)setupSliderView {
    _sliderView = [[SliderView alloc] init];
    CGRect frame = _sliderView.frame;
    frame.origin.x = self.frame.size.width - frame.size.width;
    _sliderView.frame = frame;
    [self addSubview:_sliderView];
}

- (void)setupImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, self.frame.size.height)];
    [imageView setBackgroundColor:[UIColor blueColor]];
    [self addSubview:imageView];
}

- (void)setupTitle {
    _titlevView = [[TitleView alloc] init];
    [_sliderView insertView:_titlevView];
//    CGRect frame = _titlevView.frame;
//    frame.origin.x = self.frame.size.width - frame.size.width;
//    _titlevView.frame = frame;
//    _titlevView.tag = 1;
//    [_circularArray insertObject:_titlevView atIndex:0];
//    [self addSubview:_titlevView];
}

- (void)setupTicket {
    _ticketView = [[TicketsView alloc] init];
    [_sliderView insertView:_ticketView];
//    CGRect frame = _ticketView.frame;
//    frame.origin.x = self.frame.size.width - frame.size.width;
//    _ticketView.frame = frame;
//    _ticketView.tag = 2;
//    [_circularArray insertObject:_ticketView atIndex:0];
//    [self addSubview:_ticketView];
}

- (void)setupSliderButton {
//    _sliderButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20.0f, 0.0f, 20.0f, 44.0f)];
//    [_sliderButton setBackgroundColor:[UIColor redColor]];
//    [_sliderButton addTarget:self action:@selector(sliderDragged:forEvent:) forControlEvents:UIControlEventTouchDragInside];
//    [_sliderButton addTarget:self action:@selector(sliderDragExit:forEvent:) forControlEvents:UIControlEventTouchDragExit];
//    [_sliderButton addTarget:self action:@selector(sliderDragExit:forEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_sliderButton];
}

#pragma mark - Slider Methods

- (void)sliderDragged:(id)sender forEvent:(UIEvent *)event {
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    UIControl *control = sender;
    CGRect frame = control.frame;
    frame.origin.x = roundf(point.x - (frame.size.width / 2.0f));
    if (frame.origin.x >= 80.0f && frame.origin.x <= self.frame.size.width - 20.0f) {
        control.frame = frame;
        UIView *view = [_circularArray objectAtIndex:0];
        CGRect viewFrame = view.frame;
        viewFrame.origin.x = CGRectGetMaxX(frame) - viewFrame.size.width;
        view.frame = viewFrame;
    }
}

- (void)sliderDragExit:(id)sender forEvent:(UIEvent *)event {
    UIControl *control = sender;
    __block CGRect frame = control.frame;
    UIView *view = [_circularArray objectAtIndex:0];
    __block CGRect viewFrame = view.frame;
    
    if (frame.origin.x <  80.0f +  60.0f) {
        [UIView animateWithDuration:0.4
                         animations:^{
                             frame.origin.x = 80.0f;
                             control.frame = frame;
                             viewFrame.origin.x = 80.0f - viewFrame.size.width;
                             view.frame = viewFrame;
                         }
                         completion:^(BOOL finished){
                             viewFrame.origin.x = self.frame.size.width - viewFrame.size.width;
                             view.frame = viewFrame;
                             [self animateSliderIn:control];
                             [self switchViews];
                         }];
    } else {
        [UIView animateWithDuration:0.4
                         animations:^{
                             frame.origin.x = self.frame.size.width-frame.size.width;
                             control.frame = frame;
                             viewFrame.origin.x = self.frame.size.width - viewFrame.size.width;
                             view.frame = viewFrame;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

#pragma mark - Slider Helper Methods

- (void)animateSliderIn:(UIControl *)control {
    CGRect frame = control.frame;
    frame.origin.x = self.frame.size.width-frame.size.width;
    [control setAlpha:0.0f];
    control.frame = frame;
    [UIView animateWithDuration:0.6
                     animations:^{
                         control.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark - Array Mehthods

- (void)switchViews {
    for (int i = 0; i < [[self subviews] count]; i++) {
        UIView *view = [[self subviews] objectAtIndex:i];
        NSLog(@"%d",view.tag);
        if (view.tag > 0) {
            [view removeFromSuperview];
            [self insertSubview:view atIndex:i+1];
            break;
        }
    }
    [self shiftArray];
}

- (void)shiftArray {
    UIView *view = [_circularArray objectAtIndex:0];
    [_circularArray removeObjectAtIndex:0];
    [_circularArray addObject:view];
}

@end
