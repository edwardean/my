//
//  AboutViewController.h
//  AD
//
//  Created by DolBy on 13-5-15.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) UITableView *table;
@property(strong,nonatomic) NSArray *array;

@end
