//
//  SliderView.h
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-11.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderViewDelegate <NSObject>

- (void)didSlideToIndex:(int)index;

@end


@interface SliderView : UIView {
    NSMutableArray *_circularArray;
    UIButton *_rightSliderButton;
    UIButton *_leftSliderButton;
    NSMutableArray *_staticArray; //this array reflects the initial state of the slider
}

@property (nonatomic, weak) id<SliderViewDelegate> delegate;

- (void)resetSliderAtIndex:(int)index;
- (void)insertView:(UIView *)view;
- (void)disableSliderHidden;

@end
