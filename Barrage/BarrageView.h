//
//  BarrageView.h
//  Barrage
//
//  Created by Tangtang on 2016/10/22.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Begin,
    Enter,
    End
} AnimationStatus;

typedef void(^ViewAnimationStatusBlock)(AnimationStatus status);

@interface BarrageView : UIView

@property (nonatomic, assign)   int                         trajectory;
@property (nonatomic, copy)     ViewAnimationStatusBlock    statusBlock;

- (instancetype)initWithContainer:(NSString *)container;
- (instancetype)initWithContainer:(NSString *)container trajectory:(int)trajectory;
- (instancetype)initWithContainer:(NSString *)container trajectory:(int)trajectory image:(UIImage *)image;

- (void)startAnimation;

- (void)stopAnimation;

@end
