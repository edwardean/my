//
//  ViewControllers.m
//  AD
//
//  Created by Edward on 13-5-10.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "ViewControllers.h"
#import "ViewController.h"
@interface ViewControllers (){
@private
UIViewController * viewControllerOne_,
* viewControllerTwo_,
    * viewControllerThree_,
    * viewControllerFour;

}

@property (nonatomic, retain) UIViewController * viewControllerOne,
* viewControllerTwo,
* viewControllerThree,
* viewControllerFour;

@end

@implementation ViewControllers
@synthesize viewControllerOne   = viewControllerOne_,
viewControllerTwo   = viewControllerTwo_,
viewControllerThree = viewControllerThree_,
viewControllerFour  = viewControllerFour_;

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
    
    
    
    
    NSString *str = Search_Store(@"南阳", @"网吧");
    NSLog(@"%@",str);
    NSString *str1 = Store_Detail(@"2029602847-421506714");
    NSLog(@"%@",str1);
    
    
    
    self.viewFrame = (CGRect){CGPointZero, {kKYViewWidth, kKYViewHeight}};
    self.viewFrame = CGRectMake(0, 20, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].applicationFrame));
    viewControllerOne_   = [[UIViewController alloc] init];
    viewControllerTwo_   = [[UIViewController alloc] init];
    viewControllerThree_ = [[UIViewController alloc] init];
    
    CGRect childViewFrame = self.viewFrame;
    [viewControllerOne_.view   setFrame:childViewFrame];
    [viewControllerTwo_.view   setFrame:childViewFrame];
    [viewControllerThree_.view setFrame:childViewFrame];
    
    [viewControllerOne_.view   setBackgroundColor:[UIColor cyanColor]];
    [viewControllerTwo_.view   setBackgroundColor:[UIColor redColor]];
    [viewControllerThree_.view setBackgroundColor:[UIColor greenColor]];
    
    ViewController *VC = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.viewController = VC;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    self.navigationController = nav;
    
    self.tabBarItems = @[@{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat,1],
                           @"viewController" : _navigationController},
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 2],
                           @"viewController" : viewControllerOne_},
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 3],
                           @"viewController" : viewControllerTwo_},
                        
                         @{@"image"          : [NSString stringWithFormat:kKYITabBarItemImageNameFormat, 4],
                           @"viewController" : viewControllerThree_}];
    
//    UIImage * gestureImage = [UIImage imageNamed:kKYIArcTabGestureHelp];
//    CGRect gestureImageViewFrame =
//    (CGRect){{(kKYViewWidth - gestureImage.size.width) / 2.f,
//        (kKYViewHeight - kKYTabBarHeight - gestureImage.size.height) / 2.f},
//        gestureImage.size};
//    UIImageView * gestureImageView = [[UIImageView alloc] initWithFrame:gestureImageViewFrame];
//    [gestureImageView setImage:gestureImage];
//    [gestureImageView setUserInteractionEnabled:YES];
//    [viewControllerOne_.view addSubview:gestureImageView];
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
