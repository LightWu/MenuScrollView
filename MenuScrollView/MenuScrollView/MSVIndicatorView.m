//
//  MSVIndicatorView.m
//  MenuScrollView
//
//  Created by 吳宥逵 on 2015/7/22.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MSVIndicatorView.h"

#define MAX_WIDTH 3.0

@interface MSVIndicatorView () {
    MSVIndicatorDirection indicatorDirection;
    
    NSInteger maxCount;
    
    UIView *bar;
    
    BOOL canMove;
}

@end

@implementation MSVIndicatorView

@synthesize indicatorColor=_indicatorColor;
@synthesize indicatorTinColor=_indicatorTinColor;
@synthesize currentIndex=_currentIndex;

- (void) createIndicatorWithParentFrame:(CGRect)frame direction:(MSVIndicatorDirection)direction count:(NSInteger)count {
    
    indicatorDirection=direction;
    maxCount=count;
    
    if (indicatorDirection==MSVIDirectionVertical) {
        
        if (frame.origin.x==0) {
            self.frame=CGRectMake(0, 0, MAX_WIDTH, frame.size.height);
        } else {
            self.frame=CGRectMake(frame.size.width-MAX_WIDTH, 0, MAX_WIDTH, frame.size.height);
        }
        
    } else {
        
        self.frame=CGRectMake(0, frame.size.height-MAX_WIDTH, frame.size.width, MAX_WIDTH);
    }
    
    [self setIndicatorTinColor:[UIColor clearColor]];
    
    [self setIndicatorColor:[UIColor darkGrayColor]];
    
    [self show];
    
    canMove=YES;
}

#pragma mark - Settings
- (void) setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor=indicatorColor;
    
    [bar removeFromSuperview];
    bar=nil;
    
    bar=[[UIView alloc] init];
    
    if (indicatorDirection==MSVIDirectionVertical) {
        bar.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/maxCount);
    } else {
        bar.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame)/maxCount, CGRectGetHeight(self.frame));
    }
    
    bar.backgroundColor=_indicatorColor;
    bar.layer.cornerRadius=MAX_WIDTH/2;
    bar.alpha=0.6;
    
    [self addSubview:bar];
}

- (void) setIndicatorTinColor:(UIColor *)indicatorTinColor {
    _indicatorTinColor=indicatorTinColor;
    
    self.backgroundColor=_indicatorTinColor;
}

- (void) setCurrentIndex:(NSInteger)currentIndex {
    
    [self show];
    
    if (canMove) {
        
        canMove=NO;
        
        _currentIndex=currentIndex;
        
        CGAffineTransform move;
        
        if (indicatorDirection==MSVIDirectionVertical) {
            move=CGAffineTransformMakeTranslation(0, _currentIndex*CGRectGetHeight(bar.frame));
        } else {
            move=CGAffineTransformMakeTranslation(_currentIndex*CGRectGetWidth(bar.frame), 0);
        }
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            bar.transform=move;
        } completion:^(BOOL finished) {
            canMove=YES;
        }];
    }
}

#pragma mark - Show/Hide
- (void) show {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:1];
    
    self.alpha=1;
}

- (void) hide {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha=0;
    }];
}

#pragma mark -
- (void) dealloc {
    
}

@end
