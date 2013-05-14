//
//  SetCityViewController.h
//  AD
//
//  Created by Edward on 13-5-13.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SetCityViewController : UIViewController  <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UITableView *table;

@end
