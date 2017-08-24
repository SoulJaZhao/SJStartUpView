//
//  SJStartUpView.m
//  Pods
//
//  Created by SoulJa on 2017/8/24.
//
//

#import "SJStartUpView.h"

static NSTimeInterval const kDefaultCountTime = 5.0;
static CGFloat const kScaleRate = 1.3;

@interface SJStartUpView ()
/** 展示图片的ImageView **/
@property (nonatomic, strong) UIImageView *imageView;
/** 跳过按钮 **/
@property (nonatomic, strong) UIButton *jumpBtn;
/** 定时器 **/
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SJStartUpView
#pragma mark - 初始化方法
- (instancetype)initWithImage:(UIImage *)image countTime:(NSInteger)countTime {
    self = [super init];
    if (self) {
        _image = image;
        if (!countTime || countTime <= 0) {
            _countTime = kDefaultCountTime;
        } else {
            _countTime = countTime;
        }
        _imageView = [[UIImageView alloc] init];
        _imageView.image = image;
        [self addSubview:_imageView];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer setFireDate:[NSDate date]];
        
        //按钮
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _jumpBtn.layer.borderWidth = 1.0;
        _jumpBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _jumpBtn.layer.cornerRadius = 3.0;
        _jumpBtn.layer.masksToBounds = YES;
        _jumpBtn.layer.shouldRasterize = YES;
        _jumpBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过%ld",(long)_countTime] forState:UIControlStateNormal];
        [self addSubview:_jumpBtn];
    }
    return self;
}

#pragma mark - 绘制图片ImageView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //设置ImageView的初始化大小
    CGSize size = CGSizeMake(rect.size.width * kScaleRate, rect.size.height * kScaleRate);
    _imageView.bounds = CGRectMake(0, 0, size.width, size.height);
    _imageView.center = self.center;
    
    //设置jumpBtn
    _jumpBtn.frame = CGRectMake(rect.size.width - 100 - 10, 30, 100, 30);
    
    //开始动画
    [UIView animateWithDuration:_countTime animations:^{
        _imageView.bounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        if (finished == YES) {
            if ([_delegate respondsToSelector:@selector(dismissStartUpView:)]) {
                [self destroyTimer];
                [_delegate dismissStartUpView:self];
            }
        }
    }];
}

#pragma mark - 处理定时器
- (void)handleTimer {
    if (_countTime >= 0) {
        [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过%ld",(long)_countTime] forState:UIControlStateNormal];
        _countTime--;
    } else {
        if ([_delegate respondsToSelector:@selector(dismissStartUpView:)]) {
            [self destroyTimer];
            [_delegate dismissStartUpView:self];
        }
    }
}

#pragma mark - 销毁定时器
- (void)destroyTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - 移除页面
- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self destroyTimer];
}
@end
