//
//  StoreDetailViewController.h
//  AD
//
//  Created by Edward on 13-5-12.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,AibangApiDelegate> {
    AibangApi *api;

}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, retain) NSDictionary *detailDictionary;


@property (nonatomic, copy) NSString *store_uid;        //ID
@property (nonatomic, retain) UILabel *starLabel;       //评分
@property (nonatomic, retain) UIImageView *img;         //图片
@property (nonatomic, copy) NSString *storeDesc;        //介绍
@property (nonatomic, retain) UILabel *addrLabel;       //地址
@property (nonatomic, retain) UILabel *cateLabel;       //商户类别
@property (nonatomic, retain) UILabel *countyLabel;     //区县
@property (nonatomic, retain) UILabel *costLabel;       //人均消费
@property (nonatomic, copy)NSString *lng,*lat;          //经纬度
@property (nonatomic, retain) UILabel *workTimeLabel;   //营业时间
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, copy) NSString *tel;              //电话
@property (nonatomic, copy) NSString *wap_url;          //wap链接

- (void)loadInfo;
@end
