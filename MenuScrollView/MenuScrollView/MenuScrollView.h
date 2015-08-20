//
//  MenuScrollView.h
//  MenuScrollView
//
//  Created by 吳宥逵 on 2015/7/21.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSVIndicatorView.h"

typedef NS_ENUM (NSInteger, MenuScrollViewStyle) {
    MSVStyleHorizontal  =0,
    MSVStyleVertical    =1,
};

typedef NS_ENUM (NSInteger, MenuScrollType) {
    MSVTypeSingle   =0,
    MSVTypeTwo      =1,
    MSVTypeThree    =2,
};

typedef NS_ENUM(NSInteger, MenuSeletedType) {
    MSVSelectedType_First   =0,
    MSVSelectedType_Middle  =1,
    MSVSelectedType_Last    =2,
};

@protocol MenuScrollViewDelegate;

NS_CLASS_AVAILABLE_IOS(6_0) @interface MenuScrollView : UIView {
    
    UIScrollView *theScrollView;
    
    MSVIndicatorView *indicatorView;
    
    NSInteger maxCount;
    
    NSInteger targetIndex;
    
    CGFloat offsetDistance;
    
    MenuScrollViewStyle scrollStyle;
    
    MenuScrollType scrollType;
    
    MenuSeletedType selectedType;
    
}

@property (assign, nonatomic) id<MenuScrollViewDelegate>delegate;

@property (nonatomic) BOOL showIndicator;

@property (weak, nonatomic) UIColor *indicatorColor;

@property (weak, nonatomic) UIColor *indicatorTinColor;

- (id) initWithFrame:(CGRect)frame style:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected titles:(NSArray*)titles;
- (id) initWithFrame:(CGRect)frame style:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected images:(NSArray*)images;

- (void) setStyle:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected titles:(NSArray*)titles;
- (void) setStyle:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected images:(NSArray*)images;

@end

@protocol MenuScrollViewDelegate <NSObject>
@optional

- (void) reloadDataByCurrentIndex:(NSInteger)index;

@end
