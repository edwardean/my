//
//  AboutViewController.h
//  AD
//
//  Created by DolBy on 13-5-15.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class About;
@class Detail;
@interface AboutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    About *about;
    Detail *detail;
}
@property(strong,nonatomic) UITableView *table;
@property(strong,nonatomic) NSArray *array;

@end
