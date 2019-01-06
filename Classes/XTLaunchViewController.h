//
//  XTLaunchViewController.h
//  XTLaunch
//
//  Created by hal on 2018/12/6.
//  Copyright © 2018 hal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern const NSUInteger kXTLaunchImageViewTag;

typedef void(^XTLaunchConfigureBlock)(UIView *context);
typedef void(^XTLaunchAnimateBlock)(UIView *context);
typedef void(^XTLaunchCompleteBlock)(void);

@interface XTLaunchViewController : UIViewController

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, copy) XTLaunchConfigureBlock configure;
@property (nonatomic, copy) XTLaunchAnimateBlock animate;
@property (nonatomic, copy) XTLaunchCompleteBlock complete;

- (instancetype)initWithDuration:(NSTimeInterval)duration
                       configure:(nullable XTLaunchConfigureBlock)configure
                         animate:(nullable XTLaunchAnimateBlock)animate
                        complete:(nullable XTLaunchCompleteBlock)complete;

@end

NS_ASSUME_NONNULL_END
