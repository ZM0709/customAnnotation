//
//  GMTabBarController.m
//  YYQ
//
//  Created by Z on 16/11/7.
//  Copyright © 2016年 Z. All rights reserved.
//

#import "GMTabBarController.h"
#import "HomeController.h"
#import "TempViewController.h"


@interface GMTabBarController ()

@end

@implementation GMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    HomeController * homeCtrl = [[HomeController alloc] init];
    [self addChildViewController:homeCtrl title:@"自定义方式一" image:@"" selectedImage:@""];
    TempViewController * tempCtrl = [[TempViewController alloc] init];
    [self addChildViewController:tempCtrl title:@"自定义方式二" image:@"" selectedImage:@""];
    
}


- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置文字的样式
    [self.tabBar setTintColor: [UIColor orangeColor]];

    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(51)/255.f green:(171)/255.f blue:(160)/255.f alpha:1.f]];
    
    [self addChildViewController:nav];
}
@end
