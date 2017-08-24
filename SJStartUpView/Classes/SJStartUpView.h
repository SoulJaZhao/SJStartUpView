//
//  SJStartUpView.h
//  Pods
//
//  Created by SoulJa on 2017/8/24.
//
//

#import <UIKit/UIKit.h>
@class SJStartUpView;
@protocol SJStartUpViewDelegate <NSObject>

@optional
- (void)dismissStartUpView:(SJStartUpView *)startUpView;

@end

@interface SJStartUpView : UIView
/** 开屏图片 **/
@property (nonatomic, strong) UIImage *image;

/** 倒计时时间 **/
@property (nonatomic, assign) NSInteger countTime;

/** 代理 **/
@property (nonatomic, weak) id<SJStartUpViewDelegate> delegate;

/**
 *  初始化方法
 *  @param  image       初始化图片
 *  @param  countTime   倒计时时间
 */
- (instancetype)initWithImage:(UIImage *)image countTime:(NSInteger)countTime;
@end
