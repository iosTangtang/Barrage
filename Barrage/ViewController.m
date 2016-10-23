//
//  ViewController.m
//  Barrage
//
//  Created by Tangtang on 2016/10/22.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "ViewController.h"
#import "BarrageManager.h"
#import "BarrageView.h"

@interface ViewController ()

@property (nonatomic, strong) BarrageManager *barrageManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barrageManager = [[BarrageManager alloc] init];
    self.barrageManager.dataSource = ^{
        return @[@{@"barrage" : @"这是弹幕1++++++",
                   @"headImage" : @"sixin_img1"},
                 @{@"barrage" : @"这是弹幕2++++++++",
                   @"headImage" : @"sixin_img2"},
                 @{@"barrage" : @"这是弹幕3+++",
                   @"headImage" : @"sixin_img3"},
                 @{@"barrage" : @"这是弹幕4😁😂😁😂",
                   @"headImage" : @"sixin_img4"},
                 @{@"barrage" : @"这是弹幕5+++++$$$$$$$😁😂😁😂😁😂+",
                   @"headImage" : @"sixin_img1"},
                 @{@"barrage" : @"这是弹幕6++=========+++++",
                   @"headImage" : @"sixin_img2"},
                 @{@"barrage" : @"这是弹幕7++",
                   @"headImage" : @"sixin_img3"},
                 @{@"barrage" : @"这是弹幕8++========++",
                   @"headImage" : @"sixin_img4"},
                 @{@"barrage" : @"这是弹幕9+++++_____-------+++++++++++",
                   @"headImage" : @"sixin_img3"}];
    };
    
    __weak typeof(self) weakSelf = self;
    self.barrageManager.viewBlock = ^(BarrageView *view) {
        [weakSelf addBarrageView:view];
    };
    
}

- (IBAction)startAction:(id)sender {
    
    [self.barrageManager start];
}

- (IBAction)stopAction:(id)sender {
    
    [self.barrageManager stop];
}

- (void)addBarrageView:(BarrageView *)view {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 80 + view.trajectory * 40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
