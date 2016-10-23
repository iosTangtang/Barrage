//
//  BarrageManager.m
//  Barrage
//
//  Created by Tangtang on 2016/10/22.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "BarrageManager.h"
#import "BarrageView.h"

static int const trajectoryNumber = 3;

@interface BarrageManager ()

@property (nonatomic, strong)   NSMutableArray  *dataArray;
@property (nonatomic, strong)   NSMutableArray  *tempSourceArray;
@property (nonatomic, strong)   NSMutableArray  *barrageViews;
@property (nonatomic, strong)   NSMutableArray  *trajectorys;
@property (nonatomic, assign)   BOOL            isStopAnimation;

@end

@implementation BarrageManager

#pragma mark - Lazy Method
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:self.dataSource()];
    }
    return _dataArray;
}

- (NSMutableArray *)tempSourceArray {
    if (!_tempSourceArray) {
        _tempSourceArray = [NSMutableArray array];
    }
    return _tempSourceArray;
}

- (NSMutableArray *)barrageViews {
    if (!_barrageViews) {
        _barrageViews = [NSMutableArray array];
    }
    return _barrageViews;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isStopAnimation = YES;
    }
    return self;
}

- (void)start {
    if (!self.isStopAnimation) {
        return ;
    }

    self.isStopAnimation = NO;
    [self.tempSourceArray removeAllObjects];
    [self.tempSourceArray addObjectsFromArray:self.dataArray];
    
    
    [self initBarrageContainer];
}

- (void)stop {
    if (self.isStopAnimation) {
        return ;
    }
    self.isStopAnimation = YES;
    [self.barrageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BarrageView *view = obj;
        [view stopAnimation];
        view = nil;
    }];
    
    [self.barrageViews removeAllObjects];
}

- (void)initBarrageContainer {
    self.trajectorys = [NSMutableArray arrayWithArray:@[@0, @1, @2]];
    for (int index = 0; index < trajectoryNumber; index++) {
        if (self.tempSourceArray.count > 0) {
            int itemNumber = arc4random() % self.trajectorys.count;
            int trajectory = [[self.trajectorys objectAtIndex:itemNumber] intValue];
            [self.trajectorys removeObjectAtIndex:itemNumber];
            
            NSString *message = [[self.tempSourceArray firstObject] objectForKey:@"barrage"];
            UIImage *image = [UIImage imageNamed:[[self.tempSourceArray firstObject] objectForKey:@"headImage"]];
            [self.tempSourceArray removeObjectAtIndex:0];
            
            [self createBarrageViewWithContainer:message trajectory:trajectory image:image];
        }
    }
}

- (void)createBarrageViewWithContainer:(NSString *)container trajectory:(int)trajectory image:(UIImage *)image{
    if (self.isStopAnimation) {
        return;
    }
    
    BarrageView *view = [[BarrageView alloc] initWithContainer:container trajectory:trajectory image:image];
    
    __weak typeof(view) weakView = view;
    __weak typeof(self) weakSelf = self;
    view.statusBlock = ^(AnimationStatus status) {
        if (self.isStopAnimation) {
            return ;
        }
        switch (status) {
            case Begin: {
                [weakSelf.barrageViews addObject:weakView];
                break;
            }
            
            case Enter: {
                NSDictionary *container = [weakSelf nextContainer];
                if (container) {
                    [weakSelf createBarrageViewWithContainer:[container objectForKey:@"barrage"] trajectory:trajectory
                                                       image:[UIImage imageNamed:[container objectForKey:@"headImage"]]];
                }
                break;
            }
                
            case End: {
                
                if ([weakSelf.barrageViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [weakSelf.barrageViews removeObject:weakView];
                }
                
                if (weakSelf.barrageViews.count == 0) {
                    weakSelf.isStopAnimation = YES;
                    [weakSelf start];
                }
                
                break;
            }
    
            default:
                break;
        }
    };
    
    if (self.viewBlock) {
        self.viewBlock(view);
    }
}

- (NSDictionary *)nextContainer {
    if (self.tempSourceArray.count == 0) {
        return nil;
    }
    NSDictionary *dic = [self.tempSourceArray firstObject];
    if (dic) {
        [self.tempSourceArray removeObjectAtIndex:0];
    }
    return dic;
}

@end
