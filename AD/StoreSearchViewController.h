//
//  StoreSearchViewController.h
//  AD
//
//  Created by Edward on 13-5-11.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AibangApi.h"
@class StoreDetailViewController;
@interface StoreSearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,AibangApiDelegate,StoreSearchDelegate> {
    AibangApi *api;
    StoreDetailViewController *storeDetail;
}
- (void)loadInfo;
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) UITableView *table;
@end
