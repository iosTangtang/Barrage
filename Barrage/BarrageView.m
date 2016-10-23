//
//  BarrageView.m
//  Barrage
//
//  Created by Tangtang on 2016/10/22.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "BarrageView.h"

static int const padding = 10;
static int const viewHeight = 30;
static int const headViewHeight = 40;

@interface BarrageView ()

@property (nonatomic, strong) UILabel       *containerLabel;
@property (nonatomic, strong) NSTimer       *time;
@property (nonatomic, strong) UIImageView   *headView;

@end

@implementation BarrageView

- (UILabel *)containerLabel {
    if (!_containerLabel) {
        _containerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _containerLabel.font = [UIFont systemFontOfSize:14];
        _containerLabel.textColor = [UIColor whiteColor];
        _containerLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_containerLabel];
    }
    return _containerLabel;
}

- (UIImageView *)headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headView.layer.masksToBounds = YES;
        
        [self addSubview:_headView];
    }
    return _headView;
}

- (instancetype)initWithContainer:(NSString *)container {
    return [self initWithContainer:container trajectory:0];
}

- (instancetype)initWithContainer:(NSString *)container trajectory:(int)trajectory {
    return [self initWithContainer:container trajectory:0 image:[UIImage imageNamed:@"sixin_img2"]];
}

- (instancetype)initWithContainer:(NSString *)container trajectory:(int)trajectory image:(UIImage *)image {
    self = [super init];
    if (self) {
        self.trajectory = trajectory;
        
        CGSize size = [container sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        self.bounds = CGRectMake(0, 0, size.width + 2 * padding + headViewHeight, viewHeight);
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:136 / 255.0 blue:194 / 255.0 alpha:0.8];
        self.layer.cornerRadius = viewHeight / 2.f;
        self.containerLabel.text = container;
        self.containerLabel.frame = CGRectMake(headViewHeight - padding / 2.0, 0, size.width, viewHeight);
        
        self.headView.image = image;
        self.headView.layer.cornerRadius = headViewHeight / 2.0;
        self.headView.frame = CGRectMake(-padding, (viewHeight - headViewHeight) / 2.0, headViewHeight, headViewHeight);
    }
    
    return self;
}

- (void)startAnimation {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.f;
    CGFloat wholeWidth = CGRectGetWidth(self.bounds) + screenWidth;
    
    if (self.statusBlock) {
        self.statusBlock(Begin);
    }
    
    CGFloat speed = wholeWidth / duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / speed;
    
    [self performSelector:@selector(enterAction) withObject:nil afterDelay:enterDuration];
    
    __block CGRect fa = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fa.origin.x -= wholeWidth;
        self.frame = fa;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.statusBlock) {
            self.statusBlock(End);
        }
    }];
    
}

- (void)stopAnimation {
    //取消延迟调用
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)enterAction {
    if (self.statusBlock) {
        self.statusBlock(Enter);
    }
}

@end
