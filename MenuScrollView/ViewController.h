//
//  ViewController.h
//  MenuScrollView
//
//  Created by 吳宥逵 on 2015/7/21.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MenuScrollViewDelegate> {
    IBOutlet MenuScrollView *menuScrollView;
    __weak IBOutlet UITableView *theTableView;
}


@end

