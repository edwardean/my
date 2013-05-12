//
//  ViewControllers.h
//  AD
//
//  Created by Edward on 13-5-10.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "KYArcTabViewController.h"

@class ViewController;
@interface ViewControllers : KYArcTabViewController {
    ViewController *_viewController;
}
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) ViewController *viewController;
@end
