//
//  ViewControllers.m
//  AD
//
//  Created by Edward on 13-5-10.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "ViewControllers.h"
#import "ViewController.h"
#import "SetCityViewController.h"
#import "AboutViewController.h"
@interface ViewControllers (){
@private
UIViewController 
    * viewControllerTwo_;
}

@property (nonatomic, retain) UIViewController 
* viewControllerTwo;

@end

@implementation ViewControllers
@synthesize viewControllerTwo   = viewControllerTwo_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)setup {
    
    self.viewFrame = (CGRect){CGPointZero, {kKYViewWidth, kKYViewHeight}};
    viewControllerTwo_   = [[UIViewController alloc] init];
    
    CGRect childViewFrame = self.viewFrame;

    [viewControllerTwo_.view   setFrame:childViewFrame];
    

    [viewControllerTwo_.view   setBackgroundColor:[UIColor redColor]];
    
    ViewController *VC = [[ViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC];
    
    
    SetCityViewController *secondVC = [[SetCityViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    
    self.tabBarItems = @[@{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat,3],
                           @"viewController" : nav1},
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 1],
                           @"viewController" : nav2},
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 2],
                           @"viewController" : viewControllerTwo_},
                        
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 4],
                           @"viewController" : nav4}];
    
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
