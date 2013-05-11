//
//  StoreSearchViewController.h
//  AD
//
//  Created by Edward on 13-5-11.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreSearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) UITableView *table;
@end
