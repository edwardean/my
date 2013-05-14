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
@interface ViewControllers (){
@private
UIViewController 
* viewControllerTwo_,
    * viewControllerThree_;
}

@property (nonatomic, retain) UIViewController 
* viewControllerTwo,
* viewControllerThree;

@end

@implementation ViewControllers
@synthesize viewControllerTwo   = viewControllerTwo_,
viewControllerThree = viewControllerThree_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1367143197];
    NSString *Datestr = [formatter stringFromDate:confromTimesp];
    NSLog(@"1363948516  = %@",Datestr);
    
    
    NSString *str = Search_Store(@"南阳", @"网吧");
    NSLog(@"%@",str);
    NSString *str1 = Store_Detail(@"2029602847-421506714");
    NSLog(@"%@",str1);
    
    
    
    self.viewFrame = (CGRect){CGPointZero, {kKYViewWidth, kKYViewHeight}};
    self.viewFrame = CGRectMake(0, 20, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].applicationFrame));

    viewControllerTwo_   = [[UIViewController alloc] init];
    viewControllerThree_ = [[UIViewController alloc] init];
    
    CGRect childViewFrame = self.viewFrame;

    [viewControllerTwo_.view   setFrame:childViewFrame];
    [viewControllerThree_.view setFrame:childViewFrame];
    

    [viewControllerTwo_.view   setBackgroundColor:[UIColor redColor]];
    [viewControllerThree_.view setBackgroundColor:[UIColor greenColor]];
    
    ViewController *VC = [[ViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC];
    
    
    SetCityViewController *secondVC = [[SetCityViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    self.tabBarItems = @[@{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat,1],
                           @"viewController" : nav1},
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 2],
                           @"viewController" : nav2},
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 3],
                           @"viewController" : viewControllerTwo_},
                        
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 4],
                           @"viewController" : viewControllerThree_}];
    
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
