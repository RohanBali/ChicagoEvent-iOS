//
//  SliderView.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-11.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "SliderView.h"
#import "TicketsView.h"

@interface SliderView()

- (void)setupSliderButton;
- (void)updateSliderArrayWithView:(UIView *)view;
- (void)updateSubviewAllignmentWithView:(UIView *)view;

- (void)switchViews;
- (void)shiftArray;
- (void)animateSliderIn:(UIControl *)control;


@end

@implementation SliderView

- (id)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0f, 0.0f , 240.0f , 44.0f);
        _circularArray = [[NSMutableArray alloc] init];
        [self setClipsToBounds:YES];
        [self setupSliderButton];
    }
    return self;
}

#pragma mark - Setup Methods

- (void)setupSliderButton {
    _rightSliderButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20.0f, 0.0f, 20.0f, self.frame.size.height)];
    [_rightSliderButton setBackgroundColor:[UIColor redColor]];
    [_rightSliderButton addTarget:self action:@selector(sliderDragged:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [_rightSliderButton addTarget:self action:@selector(sliderDragExit:forEvent:) forControlEvents:UIControlEventTouchDragExit];
    [_rightSliderButton addTarget:self action:@selector(sliderDragExit:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightSliderButton];
}

#pragma mark - Public Methods

- (void)insertView:(UIView *)view {
    [self updateSliderArrayWithView:view];
    [self updateSubviewAllignmentWithView:view];
}

- (void)disableSliderHidden {
    [_rightSliderButton setBackgroundColor:[UIColor redColor]];
}

#pragma mark - Helper Methods

- (void)updateSliderArrayWithView:(UIView *)view {
    [_circularArray insertObject:view atIndex:0];
}

- (void)updateSubviewAllignmentWithView:(id)view {
    [self addSubview:view];
    [_rightSliderButton removeFromSuperview];
    [self insertSubview:_rightSliderButton aboveSubview:view];
}

#pragma mark - Slider Methods

- (void)sliderDragged:(id)sender forEvent:(UIEvent *)event {
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    UIControl *control = sender;
    CGRect frame = control.frame;
    frame.origin.x = roundf(point.x - (frame.size.width / 2.0f));
    if (frame.origin.x >= 0.0f && frame.origin.x <= self.frame.size.width - 20.0f) {
        control.frame = frame;
        UIView *view = [_circularArray objectAtIndex:0];
        CGRect viewFrame = view.frame;
        viewFrame.origin.x = CGRectGetMaxX(frame) - viewFrame.size.width;
        view.frame = viewFrame;
        
        CGRect containerViewFrame = [[(TicketsView *)view containerView] frame];
        containerViewFrame.origin.x = 0.0f - viewFrame.origin.x;
        [[(TicketsView *)view containerView] setFrame:containerViewFrame];
    }
}

- (void)sliderDragExit:(id)sender forEvent:(UIEvent *)event {
    UIControl *control = sender;
    __block CGRect frame = control.frame;
    UIView *view = [_circularArray objectAtIndex:0];
    __block CGRect viewFrame = view.frame;
    __block CGRect containerViewFrame = [[(TicketsView *)view containerView] frame];

    if (frame.origin.x <  60.0f) {
        [UIView animateWithDuration:0.4
                         animations:^{
                             frame.origin.x = 0.0f;
                             control.frame = frame;
                             viewFrame.origin.x = 0.0f - viewFrame.size.width;
                             view.frame = viewFrame;
                             
                             containerViewFrame.origin.x = 0.0f - viewFrame.origin.x;
                             [[(TicketsView *)view containerView] setFrame:containerViewFrame];
                         }
                         completion:^(BOOL finished){
                             viewFrame.origin.x = self.frame.size.width - viewFrame.size.width;
                             view.frame = viewFrame;
                             
                             containerViewFrame.origin.x = 0.0f;
                             [[(TicketsView *)view containerView] setFrame:containerViewFrame];
                             
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
                             
                             containerViewFrame.origin.x = 0.0f;
                             [[(TicketsView *)view containerView] setFrame:containerViewFrame];
                             
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
        if ([_circularArray containsObject:view]) {
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
