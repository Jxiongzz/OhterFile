//
//  BulgeTabBarController.m
//  MCTabBarController
//
//  Created by caohouhong on 2018/12/7.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  

#import "BulgeTabBarController.h"
#import "ViewController.h"
#import "BaseNavigationController.h"

@interface BulgeTabBarController ()<MCTabBarControllerDelegate>

@end

@implementation BulgeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //选中时的颜色
    //self.mcTabbar.tintColor = [UIColor colorWithRed:75/255.0 green:102/255.0 blue:234/255.0 alpha:1];
//    self.mcTabbar.tintColor = [UIColor redColor];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    self.mcTabbar.translucent = NO;
    //生成背景图片
    UIImage *tabbarImage = [self imageWithColor:[UIColor colorWithRed:130/255.0 green:160/255.0 blue:246/255.0 alpha:0.5f]];
    self.mcTabbar.backgroundImage = tabbarImage;
    //分割线的颜色
    self.mcTabbar.shadowImage = [UIImage new];
    self.mcTabbar.position = MCTabBarCenterButtonPositionBulge;
    //设置中间的图片
    self.mcTabbar.centerImage = [UIImage imageNamed:@"tabbar_add_yellow"];
    //设置中间图片的宽高
    self.mcTabbar.centerWidth = 60.0f;
    self.mcTabbar.centerHeight = 60.0f;
    //设置中间的偏移度
    self.mcTabbar.centerOffsetY = 10.0f;
    self.mcDelegate = self;
    [self addChildViewControllers];
    
    // 添加完childVC后再设置选中的index，如果是中间按钮有动画等动作，再延时执行一下即可
//    self.selectedIndex = 2;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self rotationAnimation];
//    });
}

//根据颜色生成一张图片
- (UIImage *)imageWithColor:(UIColor *)color

{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    [color setFill];
    
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"" andImageName:@"tab1"];
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"" andImageName:@"tab2"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"" andImageName:@""];
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"" andImageName:@"tab3"];
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"" andImageName:@"tab4"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    // 选中的颜色由tabbar的tintColor决定
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:imageName];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}

// 使用MCTabBarController 自定义的 选中代理
- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2){
        //[self rotationAnimation];
    }else {
        [self.mcTabbar.centerBtn.layer removeAllAnimations];
    }
}

//旋转动画
- (void)rotationAnimation{
    if ([@"key" isEqualToString:[self.mcTabbar.centerBtn.layer animationKeys].firstObject]){
        return;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [self.mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}

@end
