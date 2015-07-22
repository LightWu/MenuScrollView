//
//  MSVIndicatorView.h
//  MenuScrollView
//
//  Created by 吳宥逵 on 2015/7/22.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MSVIndicatorDirection) {
    MSVIDirectionHorizontal  =0,
    MSVIDirectionVertical    =1,
};

NS_CLASS_AVAILABLE_IOS(6_0) @interface MSVIndicatorView : UIView

@property (weak, nonatomic) UIColor *indicatorColor;

@property (weak, nonatomic) UIColor *indicatorTinColor;

@property (nonatomic) NSInteger currentIndex;

- (void) createIndicatorWithParentFrame:(CGRect)frame direction:(MSVIndicatorDirection)direction count:(NSInteger)count;

@end
