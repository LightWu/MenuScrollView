//
//  ViewController.m
//  MenuScrollView
//
//  Created by 吳宥逵 on 2015/7/21.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* // use this code to alloc
    menuScrollView=[[MenuScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 100) style:MSVStyleHorizontal type:MSVTypeTwo titles:@[@"page index 1",@"page index 2",@"page index 3", @"page index 4"]];
    
    menuScrollView.delegate=self;
    
    [self.view addSubview:menuScrollView];
     */
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // if storyboard is using size classes, should setup in viewDidAppear.
    
    // setup with titles
    [menuScrollView setStyle:MSVStyleHorizontal type:MSVTypeTwo titles:@[@"page index 1",@"page index 2",@"page index 3", @"page index 4"]];
    
    // setup with images
//    [menuScrollView setStyle:MSVStyleHorizontal type:MSVTypeTwo images:@[[UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"]]];
    
    menuScrollView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate & Data Source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MenuScrollView Delegate
- (void) reloadDataByCurrentIndex:(NSInteger)index {
    NSLog(@"reloadDataByCurrentIndex :%d", index);
    
    [theTableView reloadData];
}

@end
