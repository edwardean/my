//
//  ShareViewController.m
//  AD
//
//  Created by Edward on 13-5-16.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
   ////grgrthrtjtyjythuhiuui
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self performSelector:@selector(share) withObject:nil afterDelay:2.0f];
}
- (void)share {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ohh" ofType:@"png"];
    id <ISSContent> publishContent = [ShareSDK content:@"content" defaultContent:@"" image:[ShareSDK imageWithPath:imagePath] title:nil url:nil description:nil mediaType:SSPublishContentMediaTypeText];
    
    id <ISSContainer> container = [ShareSDK container];
    
    [container setIPhoneContainerWithViewController:self];
    
    [ShareSDK showShareViewWithType:ShareTypeSinaWeibo container:container content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        if (state == SSPublishContentStateSuccess) {
            NSLog(@"发表成功");
        } else if (state == SSPublishContentStateFail) {
            NSLog(@"发表失败.error = %d,error = %@",[error errorCode],[error errorDescription]);
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
