//
//  XTLaunchViewController.m
//  XTLaunch
//
//  Created by hal on 2018/12/6.
//  Copyright © 2018 hal. All rights reserved.
//

#import "XTLaunchViewController.h"

const NSUInteger kXTLaunchImageViewTag = 1000;

@interface XTLaunchViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XTLaunchViewController

#pragma mark - life cycle
- (void)dealloc {
}

- (instancetype)initWithDuration:(NSTimeInterval)duration
                       configure:(nullable XTLaunchConfigureBlock)configure
                         animate:(nullable XTLaunchAnimateBlock)animate
                        complete:(nullable XTLaunchCompleteBlock)complete {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.duration = duration;
        self.configure = configure;
        self.animate = animate;
        self.complete = complete;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSArray *images = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *imageInfo in images) {
        
        CGSize imageSize = CGSizeFromString(imageInfo[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(screenSize, imageSize) && [imageInfo[@"UILaunchImageOrientation"] isEqualToString:@"Portrait"]) {
            self.imageView.image = [UIImage imageNamed:imageInfo[@"UILaunchImageName"]];
        }
    }
    
    if (self.configure) {
        self.configure(self.view);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.animate) {
        self.animate(self.view);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.complete) {
            self.complete();
        }
    });
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - event response

#pragma mark - private methods

#pragma mark - getter & setter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _imageView.tag = kXTLaunchImageViewTag;
    }
    return _imageView;
}

@end
