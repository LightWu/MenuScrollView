//
//  MenuScrollView.m
//  MenuScrollView
//
//  Created by 吳宥逵 on 2015/7/21.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "MenuScrollView.h"
#import "AppDelegate.h"

#define BASE 5000

typedef NS_ENUM(NSInteger, MoveDirection) {
    kMoveDirection_Front    =0,
    kMoveDirection_Back     =1,
};

@interface MenuScrollView ()  <UIScrollViewDelegate> {
    
    MoveDirection moveDirection;
    
    NSInteger didUpdatedIndex;
}

@end

@implementation MenuScrollView

@synthesize showIndicator=_showIndicator;
@synthesize indicatorColor=_indicatorColor;
@synthesize indicatorTinColor=_indicatorTinColor;

- (void) awakeFromNib {
    self.showIndicator=YES;
}

- (id) initWithFrame:(CGRect)frame style:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected  titles:(NSArray*)titles {
    if (self=[super initWithFrame:frame]) {
        self.showIndicator=YES;
        [self setStyle:style type:type selectedType:selected titles:titles];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame style:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected  images:(NSArray *)images {
    if (self=[super initWithFrame:frame]) {
        self.showIndicator=YES;
        [self setStyle:style type:type selectedType:selected images:images];
    }
    return self;
}

- (void) setStyle:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected  titles:(NSArray *)titles {
    
    if (theScrollView!=nil) {
        for (UIView *view in theScrollView.subviews) {
            [view removeFromSuperview];
        }
    } else {
        theScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        theScrollView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
    
    maxCount=titles.count;
    
    theScrollView.bounces=NO;
    theScrollView.delegate=self;
    
    theScrollView.showsVerticalScrollIndicator=NO;
    theScrollView.showsHorizontalScrollIndicator=NO;
    theScrollView.backgroundColor=[UIColor clearColor];
    
    scrollStyle=style;
    
    [self setType:type];
    
    int total = (titles.count<=type+1) ? 0 : BASE;
    
    if (total==0) {
        selectedType=MSVSelectedType_First;
    } else {
        if (type!=MSVTypeThree && selected==MSVSelectedType_Middle) {
            selectedType=MSVSelectedType_First;
        } else if (type==MSVTypeSingle && selected!=MSVSelectedType_First) {
            selectedType=MSVSelectedType_First;
        } else {
            selectedType=selected;
        }
    }
    
    targetIndex=total/2;
    
    if (scrollStyle==MSVStyleVertical) {
        
        for (int i = 0; i < titles.count; i++) {
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, offsetDistance*(i+total/2), CGRectGetWidth(self.frame), offsetDistance)];
            label.text=titles[i];
            label.textAlignment=NSTextAlignmentCenter;
            label.tag=(i+total/2)+[self getAttachNumber];
            label.layer.backgroundColor=[UIColor clearColor].CGColor;
            if (label.tag==targetIndex+[self getAttachNumber]) {
                label.layer.opacity=1;
            } else {
                label.layer.opacity=0.5;
            }
            label.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
            tap.numberOfTapsRequired=1;
            [label addGestureRecognizer:tap];
            
            label.layer.borderWidth=0.5;
            label.layer.borderColor=[UIColor lightGrayColor].CGColor;
            
            [theScrollView addSubview:label];
        }
        
        if (titles.count>(scrollType+1)) {
            
            for (int i = 0; i < titles.count; i++) {
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, offsetDistance*(total/2-(titles.count-i)), CGRectGetWidth(self.frame), offsetDistance)];
                label.text=titles[i];
                label.textAlignment=NSTextAlignmentCenter;
                label.tag=(total/2-(titles.count-i))+[self getAttachNumber];
                label.layer.backgroundColor=[UIColor clearColor].CGColor;
                if (label.tag==targetIndex+[self getAttachNumber]) {
                    label.layer.opacity=1;
                } else {
                    label.layer.opacity=0.5;
                }
                label.userInteractionEnabled=YES;
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
                tap.numberOfTapsRequired=1;
                [label addGestureRecognizer:tap];
                
                label.layer.borderWidth=0.5;
                label.layer.borderColor=[UIColor lightGrayColor].CGColor;
                
                [theScrollView addSubview:label];
            }
        }
        
        theScrollView.contentSize=CGSizeMake(CGRectGetWidth(self.frame), offsetDistance*total);
        
    } else {
        
        for (int i = 0; i < titles.count; i++) {
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(offsetDistance*(i+total/2), 0, offsetDistance, CGRectGetHeight(self.frame))];
            label.text=titles[i];
            label.textAlignment=NSTextAlignmentCenter;
            label.tag=(i+total/2)+[self getAttachNumber];
            label.layer.backgroundColor=[UIColor clearColor].CGColor;
            if (label.tag==targetIndex+[self getAttachNumber]) {
                label.layer.opacity=1;
            } else {
                label.layer.opacity=0.5;
            }
            label.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
            tap.numberOfTapsRequired=1;
            [label addGestureRecognizer:tap];
            
            label.layer.borderWidth=0.5;
            label.layer.borderColor=[UIColor lightGrayColor].CGColor;
            
            [theScrollView addSubview:label];
        }
        
        if (titles.count>(scrollType+1)) {
            
            for (int i = 0; i < titles.count; i++) {
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(offsetDistance*(total/2-(titles.count-i)), 0, offsetDistance, CGRectGetHeight(self.frame))];
                label.text=titles[i];
                label.textAlignment=NSTextAlignmentCenter;
                label.tag=(total/2-(titles.count-i))+[self getAttachNumber];
                label.layer.backgroundColor=[UIColor clearColor].CGColor;
                if (label.tag==targetIndex+[self getAttachNumber]) {
                    label.layer.opacity=1;
                } else {
                    label.layer.opacity=0.5;
                }
                label.userInteractionEnabled=YES;
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
                tap.numberOfTapsRequired=1;
                [label addGestureRecognizer:tap];
                
                label.layer.borderWidth=0.5;
                label.layer.borderColor=[UIColor lightGrayColor].CGColor;
                
                [theScrollView addSubview:label];
            }
        }
        
        theScrollView.contentSize=CGSizeMake(offsetDistance*total, CGRectGetHeight(self.frame));
    }
    
    [self addSubview:theScrollView];
    
    [self scrollToCurrentIndex:NO];
    
    [self setShowIndicator:self.showIndicator];
}

- (void) setStyle:(MenuScrollViewStyle)style type:(MenuScrollType)type selectedType:(MenuSeletedType)selected  images:(NSArray *)images {
    
    if (theScrollView!=nil) {
        for (UIView *view in theScrollView.subviews) {
            [view removeFromSuperview];
        }
    } else {
        theScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        theScrollView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
    
    maxCount=images.count;
    
    theScrollView.bounces=NO;
    theScrollView.delegate=self;
    
    theScrollView.showsVerticalScrollIndicator=NO;
    theScrollView.showsHorizontalScrollIndicator=NO;
    
    scrollStyle=style;
    
    [self setType:type];
    
    int total = (images.count<=type+1) ? 0 : BASE;
    
    if (total==0) {
        selectedType=MSVSelectedType_First;
    } else {
        if (type!=MSVTypeThree && selected==MSVSelectedType_Middle) {
            selectedType=MSVSelectedType_First;
        } else if (type==MSVTypeSingle && selected!=MSVSelectedType_First) {
            selectedType=MSVSelectedType_First;
        } else {
            selectedType=selected;
        }
    }
    
    targetIndex=total/2;
    
    if (scrollStyle==MSVStyleVertical) {
        for (int i = 0; i < images.count; i++) {
            
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, offsetDistance*(i+total/2+[self getAttachNumber]), CGRectGetWidth(self.frame), offsetDistance)];
            
            imgView.image=images[i];
            imgView.tag=(i+total/2)+[self getAttachNumber];
            imgView.layer.backgroundColor=[UIColor clearColor].CGColor;
            if (imgView.tag==targetIndex+[self getAttachNumber]) {
                imgView.layer.opacity=1;
            } else {
                imgView.layer.opacity=0.5;
            }
            imgView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
            tap.numberOfTapsRequired=1;
            [imgView addGestureRecognizer:tap];
            
            [theScrollView performSelectorOnMainThread:@selector(addSubview:) withObject:imgView waitUntilDone:NO];
        }
        
        if (images.count>(scrollType+1)) {
            
            for (int i = 0; i < images.count; i++) {
                
                UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, offsetDistance*(total/2-(images.count-i)+[self getAttachNumber]), CGRectGetWidth(self.frame), offsetDistance)];
                
                imgView.image=images[i];
                imgView.tag=(total/2-(images.count-i))+[self getAttachNumber];
                imgView.layer.backgroundColor=[UIColor clearColor].CGColor;
                if (imgView.tag==targetIndex+[self getAttachNumber]) {
                    imgView.layer.opacity=1;
                } else {
                    imgView.layer.opacity=0.5;
                }
                imgView.userInteractionEnabled=YES;
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
                tap.numberOfTapsRequired=1;
                [imgView addGestureRecognizer:tap];
                
                [theScrollView performSelectorOnMainThread:@selector(addSubview:) withObject:imgView waitUntilDone:NO];
            }
        }
        
        theScrollView.contentSize=CGSizeMake(CGRectGetWidth(self.frame), offsetDistance*total);
        
    } else {
        for (int i = 0; i < images.count; i++) {
            
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(offsetDistance*(i+total/2+[self getAttachNumber]), 0, offsetDistance, CGRectGetHeight(self.frame))];
            
            imgView.image=images[i];
            imgView.tag=(i+total/2)+[self getAttachNumber];
            imgView.layer.backgroundColor=[UIColor clearColor].CGColor;
            if (imgView.tag==targetIndex+[self getAttachNumber]) {
                imgView.layer.opacity=1;
            } else {
                imgView.layer.opacity=0.5;
            }
            imgView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
            tap.numberOfTapsRequired=1;
            [imgView addGestureRecognizer:tap];
            
            [theScrollView performSelectorOnMainThread:@selector(addSubview:) withObject:imgView waitUntilDone:NO];
        }
        
        if (images.count>(scrollType+1)) {
            
            for (int i = 0; i < images.count; i++) {
                
                UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(offsetDistance*(total/2-(images.count-i)+[self getAttachNumber]), 0, offsetDistance, CGRectGetHeight(self.frame))];
                
                imgView.image=images[i];
                imgView.tag=(total/2-(images.count-i))+[self getAttachNumber];
                imgView.layer.backgroundColor=[UIColor clearColor].CGColor;
                if (imgView.tag==targetIndex+[self getAttachNumber]) {
                    imgView.layer.opacity=1;
                } else {
                    imgView.layer.opacity=0.5;
                }
                imgView.userInteractionEnabled=YES;
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
                tap.numberOfTapsRequired=1;
                [imgView addGestureRecognizer:tap];
                
                [theScrollView performSelectorOnMainThread:@selector(addSubview:) withObject:imgView waitUntilDone:NO];
            }
        }
        
        theScrollView.contentSize=CGSizeMake(offsetDistance*total, CGRectGetHeight(self.frame));
    }
    
    [self addSubview:theScrollView];
    
    [self scrollToCurrentIndex:NO];
    
    [self setShowIndicator:self.showIndicator];
}

#pragma mark - Settings
- (void) setType:(MenuScrollType)type {
    
    scrollType=type;
    
    if (scrollStyle==MSVStyleVertical) {
        
        switch (scrollType) {
            case MSVTypeSingle:
                offsetDistance=self.frame.size.height;
                break;
            case MSVTypeTwo:
                offsetDistance=self.frame.size.height/2;
                break;
            case MSVTypeThree:
                offsetDistance=self.frame.size.height/3;
                break;
            default:
                break;
        }
    } else {
        
        switch (scrollType) {
            case MSVTypeSingle:
                offsetDistance=self.frame.size.width;
                break;
            case MSVTypeTwo:
                offsetDistance=self.frame.size.width/2;
                break;
            case MSVTypeThree:
                offsetDistance=self.frame.size.width/3;
                break;
            default:
                break;
        }
    }
}

- (void) setShowIndicator:(BOOL)showIndicator {
    
    _showIndicator=showIndicator;
    
    if (_showIndicator) {
        [self setIndicator];
    } else {
        [indicatorView removeFromSuperview];
        indicatorView=nil;
    }
}

- (void) setIndicator {
    
    if (indicatorView!=nil) {
        [indicatorView removeFromSuperview];
        indicatorView=nil;
    }
    
    indicatorView=[[MSVIndicatorView alloc] init];
    
    [indicatorView createIndicatorWithParentFrame:self.frame direction:(MSVIndicatorDirection)scrollStyle count:maxCount];
    
    [self addSubview:indicatorView];
    
    [self bringSubviewToFront:indicatorView];
}

- (void) setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor=indicatorColor;
    [indicatorView setIndicatorColor:_indicatorColor];
}

- (void) setIndicatorTinColor:(UIColor *)indicatorTinColor {
    _indicatorTinColor=indicatorTinColor;
    [indicatorView setIndicatorTinColor:_indicatorTinColor];
}

#pragma mark - ScrollView Delegate
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDragging");
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(resetViews) object:nil];
    
    if (scrollStyle==MSVStyleVertical) {
        if ([scrollView.panGestureRecognizer velocityInView:self].y>=0) {
            moveDirection=kMoveDirection_Back;
        } else {
            moveDirection=kMoveDirection_Front;
        }
    } else {
        if ([scrollView.panGestureRecognizer velocityInView:self].x>0) {
            moveDirection=kMoveDirection_Back;
        } else {
            moveDirection=kMoveDirection_Front;
        }
    }
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    NSLog(@"scrollViewWillEndDragging");
    
    if (scrollStyle==MSVStyleVertical) {
        
        targetIndex=scrollView.contentOffset.y/offsetDistance;
        
        if (moveDirection==kMoveDirection_Front) {
            
            if (scrollView.contentOffset.y/offsetDistance>targetIndex) {
                
                targetIndex++;
            }
        }
    } else {
        
        targetIndex=scrollView.contentOffset.x/offsetDistance;
        
        if (moveDirection==kMoveDirection_Front) {
            
            if (scrollView.contentOffset.x/offsetDistance>targetIndex) {
                
                targetIndex++;
            }
        }
    }
    
    if (CGPointEqualToPoint(velocity, CGPointZero)) {
        [self scrollToCurrentIndex:YES];
    }
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDecelerating");
    
    [self scrollToCurrentIndex:YES];
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
    
    [self replaceNextView:(int)targetIndex complete:^(BOOL finished) {
        
        if (didUpdatedIndex!=targetIndex) {
            
            NSInteger currentIndex=0;
            
            if (targetIndex<BASE/2) {
                currentIndex=((targetIndex-BASE/2)%maxCount+maxCount)%maxCount;
            } else {
                currentIndex=(targetIndex-BASE/2)%maxCount;
            }
            
            if ([self.delegate respondsToSelector:@selector(reloadDataByCurrentIndex:)]) {
                [self.delegate reloadDataByCurrentIndex:currentIndex];
            }
            
            didUpdatedIndex=targetIndex;
            
            [self performSelector:@selector(resetViews) withObject:nil afterDelay:1];
        }
    }];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidScroll");
    
    if (scrollView.isDragging) {
        
        int currentIndex;
        
        if (scrollStyle==MSVStyleVertical) {
            currentIndex=scrollView.contentOffset.y/offsetDistance;
        } else {
            currentIndex=scrollView.contentOffset.x/offsetDistance;
        }
        
        if (currentIndex!=targetIndex) {
            
            [self resetIndicatorView:currentIndex];
            
            [self replaceNextView:currentIndex complete:nil];
        }
    } else {
        
        [self resetIndicatorView:targetIndex];
    }
}

#pragma mark - GestureRecognizers
- (void) handleTapGestureRecognizer:(UITapGestureRecognizer*)tapGestureRecognizer {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(resetViews) object:nil];
    
    UIView *view=tapGestureRecognizer.view;
    
    targetIndex=view.tag-[self getAttachNumber];
    
    [self scrollToCurrentIndex:YES];
    
    if (maxCount<=scrollType+1) {
        
        if ([self.delegate respondsToSelector:@selector(reloadDataByCurrentIndex:)]) {
            [self.delegate reloadDataByCurrentIndex:targetIndex];
        }
        
        [indicatorView setCurrentIndex:targetIndex];
    }
}

#pragma mark - Other Methods
- (void) scrollToCurrentIndex:(BOOL)animated {
//    NSLog(@"scrollToCurrentIndex");
    
    if (scrollStyle==MSVStyleVertical) {
        
        [theScrollView scrollRectToVisible:CGRectMake(0, targetIndex*offsetDistance, CGRectGetWidth(theScrollView.frame), CGRectGetHeight(theScrollView.frame)) animated:animated];
    } else {
        
        [theScrollView scrollRectToVisible:CGRectMake(targetIndex*offsetDistance, 0, CGRectGetWidth(theScrollView.frame), CGRectGetHeight(theScrollView.frame)) animated:animated];
    }
    
    for (UIView *view in theScrollView.subviews) {
        if (view.tag==targetIndex+[self getAttachNumber]) {
            view.layer.opacity=0.5;
        } else {
            view.layer.opacity=1;
        }
    }
}

- (void) replaceNextView:(int)currentIndex complete:(void(^)(BOOL finished))complete {
    NSLog(@"replaceNextView");
    
    if (moveDirection==kMoveDirection_Front) {
        
        for (UIView *view in theScrollView.subviews) {
            
            if (view.tag<currentIndex-maxCount) {
                view.tag=(currentIndex+maxCount)-(currentIndex-maxCount-view.tag);
                        // 2502 + 5 - (2502 - 5 - 2495)
                        // 2507 - (2497-2495)
                        // 2507 - 2
                if (scrollStyle==MSVStyleVertical) {
                    view.frame=CGRectMake(0, offsetDistance*view.tag, CGRectGetWidth(view.frame), offsetDistance);
                } else {
                    view.frame=CGRectMake(offsetDistance*view.tag, 0, offsetDistance, CGRectGetHeight(view.frame));
                }
                
            }
        }
    } else {
        for (UIView *view in theScrollView.subviews) {
            
            if (view.tag>currentIndex+maxCount) {
                
                view.tag=currentIndex-maxCount+1;
                
                if (scrollStyle==MSVStyleVertical) {
                    view.frame=CGRectMake(0, offsetDistance*view.tag, CGRectGetWidth(view.frame), offsetDistance);
                } else {
                    view.frame=CGRectMake(offsetDistance*view.tag, 0, offsetDistance, CGRectGetHeight(view.frame));
                }
                
            }
        }
    }
    
    if (complete==nil) {
        complete=^(BOOL finished){};
    }
    complete(YES);
}

- (void) resetViews {
//    NSLog(@"resetViews");
    
    // reset views in center, and scroll to center
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(resetViews) object:nil];
    
    NSInteger tempIndex=(targetIndex-BASE/2)%maxCount;
    
    NSInteger baseIndex=BASE/2-targetIndex+tempIndex;
    
    for (UIView *view in theScrollView.subviews) {
        
        view.tag+=baseIndex;
        
        if (scrollStyle==MSVStyleVertical) {
            view.frame=CGRectMake(0, view.tag*offsetDistance, CGRectGetWidth(view.frame), offsetDistance);
        } else {
            view.frame=CGRectMake(view.tag*offsetDistance, 0, offsetDistance, CGRectGetHeight(view.frame));
        }
    }
    
    targetIndex+=baseIndex;
    
    didUpdatedIndex=0;
    
    [self scrollToCurrentIndex:NO];
}

- (void) resetIndicatorView:(NSInteger)d {
    
    NSInteger index=0;
    
    if (d<BASE/2) {
        index=((d-BASE/2)%maxCount+maxCount)%maxCount;
    } else {
        index=(d-BASE/2)%maxCount;
    }
    
    [indicatorView setCurrentIndex:index];
}

- (NSInteger) getAttachNumber {
    switch (selectedType) {
        case MSVSelectedType_First:
            break;
        case MSVSelectedType_Middle:
            return 1;
            break;
        case MSVSelectedType_Last:
            if (scrollType==MSVTypeTwo) {
                return 1;
            } else if (scrollType==MSVTypeThree) {
                return 2;
            }
            break;
        default:
            break;
    }
    
    return 0;
}

#pragma mark - 
- (void) dealloc {
    
}

@end
