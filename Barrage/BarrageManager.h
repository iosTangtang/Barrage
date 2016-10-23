//
//  BarrageManager.h
//  Barrage
//
//  Created by Tangtang on 2016/10/22.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BarrageView;

typedef void(^ViewBlock)(BarrageView *view);
typedef NSArray *(^DataSourceBlock)(void);

@interface BarrageManager : NSObject

@property (nonatomic, copy) ViewBlock       viewBlock;
@property (nonatomic, copy) DataSourceBlock dataSource;

- (void)start;

- (void)stop;

@end
