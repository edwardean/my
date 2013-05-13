//
//  StoreDetailViewController.m
//  AD
//
//  Created by Edward on 13-5-12.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "StoreDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "DLStarRatingControl.h"
#import "AURosetteView.h"
#import "AURosetteItem.h"
#import "BlockActionSheet.h"
#import "MapViewController.h"
@interface StoreDetailViewController ()
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, strong) DLStarRatingControl *starRating;
@end

@implementation StoreDetailViewController
@synthesize table = _table;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    @autoreleasepool {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"diwen"]];
    UIScrollView *scrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 800)];
    self.scrollView = scrol;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table = tableView;
    [self.table setFrame:CGRectMake(0, 400, 320, 600)];
    [_scrollView addSubview:_table];
    [self.view addSubview:_scrollView];
    [_table setDataSource:self];
    [_table setDelegate:self];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
    self.img = imgView;
    self.img.layer.cornerRadius = 3.0f;
    self.img.layer.masksToBounds = YES;
    [self.scrollView addSubview:_img];
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 105, 50, 30)];
    [startLabel setBackgroundColor:[UIColor clearColor]];
    self.starLabel = startLabel;
    [self.scrollView addSubview:_starLabel];
    
    DLStarRatingControl *customNumberOfStars = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(2, 130, 105, 23) andStars:5 isFractional:YES];
    customNumberOfStars.backgroundColor = [UIColor clearColor];
    
	customNumberOfStars.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.starRating = customNumberOfStars;
    [self.scrollView addSubview:_starRating];
     [_starRating setUserInteractionEnabled:NO];
        
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(115, 0, 200, 30)];
        [name setBackgroundColor:[UIColor clearColor]];
    self.nameLabel = name;
    [self.scrollView addSubview:_nameLabel];
        
        UILabel *cost = [[UILabel alloc] initWithFrame:CGRectMake(115, 30, 160, 20)];
        self.costLabel = cost;
        [self.scrollView addSubview:_costLabel];
        [_costLabel setTextColor:[UIColor redColor]];
        [_costLabel setBackgroundColor:[UIColor clearColor]];
        [_costLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        
        UILabel *workTime = [[UILabel alloc] initWithFrame:CGRectMake(115, 50, 208, 20)];
        
        self.workTimeLabel = workTime;
        [_workTimeLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:13.0]];
        [_workTimeLabel setTextColor:[UIColor greenColor]];
        [_workTimeLabel setBackgroundColor:[UIColor clearColor]];
        [_workTimeLabel setAdjustsFontSizeToFitWidth:YES];
        [self.scrollView addSubview:_workTimeLabel];
        
    
        
        UILabel *county = [[UILabel alloc] initWithFrame:CGRectMake(115, 80, 40, 30)];
        [county setText:@"我要:"];
        [county setBackgroundColor:[UIColor clearColor]];
        [self.scrollView addSubview:county];
        
        
        UIImage* locateImage = [UIImage imageNamed:@"/Bundle.bundle/Resources/locate"];
        UIImage* phoneImage = [UIImage imageNamed:@"/Bundle.bundle/Resources/phone"];
        UIImage* websetImage = [UIImage imageNamed:@"/Bundle.bundle/Resources/webset"];
        
        AURosetteItem* locateItem = [[AURosetteItem alloc] initWithNormalImage:locateImage
                                                               highlightedImage:nil
                                                                         target:self
                                                                         action:@selector(locateAction:)];
        
        AURosetteItem* phoneItem = [[AURosetteItem alloc] initWithNormalImage:phoneImage
                                                                highlightedImage:nil
                                                                          target:self
                                                                          action:@selector(phoneAction:)];
        
        AURosetteItem* websetItem = [[AURosetteItem alloc] initWithNormalImage:websetImage
                                                            highlightedImage:nil
                                                                      target:self
                                                                      action:@selector(websetAction:)];
        
        // create rosette view
        AURosetteView* rosette = [[AURosetteView alloc] initWithItems: @[locateItem,phoneItem,websetItem]];
        [rosette setCenter:CGPointMake(170.0f, 93.0f)];
        [self.scrollView addSubview:rosette];
        
        
        
//        self.countyLabel = county;
//        [_countyLabel setAdjustsFontSizeToFitWidth:YES];
//        [_countyLabel setNumberOfLines:0];
//        [self.scrollView addSubview:_countyLabel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadView {

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)loadInfo {
    @autoreleasepool {
        
    if (_detailDictionary) {
        self.title = [_detailDictionary objectForKey:@"name"];
        __weak typeof(self) weakSelf = self;
        [self.img setImageWithURL:[NSURL URLWithString:[_detailDictionary objectForKey:@"img_url"]] placeholderImage:[UIImage imageNamed:@"placeholder_bg"] options:SDWebImageProgressiveDownload success:^(UIImage *image) {
            
        } failure:^(NSError *error) {
            NSLog(@"加载失败");
            [weakSelf.img setImage:[UIImage imageNamed:@"photoDefault.jpg"]];
        }];
        
        NSString *rateStr = [_detailDictionary objectForKey:@"rate"];
        float starNum = .1f;
        starNum = [rateStr floatValue];
        _starRating.rating = starNum;
        [_starLabel setText:[NSString stringWithFormat:@"%@分",rateStr]];
       
        [_nameLabel setText:[NSString stringWithFormat:@"%@",[_detailDictionary objectForKey:@"name"]]];
        [_costLabel setText:[NSString stringWithFormat:@"人均消费%@￥",[_detailDictionary objectForKey:@"cost"]]];
        
        [_workTimeLabel setText:[NSString stringWithFormat:@"%@营业",[_detailDictionary objectForKey:@"work_time"]]];
        
        //[_countyLabel setText:[NSString stringWithFormat:@"%@",[_detailDictionary objectForKey:@"county"]]];
        
        self.tel = [_detailDictionary objectForKey:@"tel"];
        
        self.wap_url = [_detailDictionary objectForKey:@"web_url"];
        
        self.lat = [_detailDictionary objectForKey:@"lat"];
        self.lng = [_detailDictionary objectForKey:@"lng"];
        
    }

}
}


- (void)locateAction:(id)sender {
    NSLog(@"%s",__func__);
    if ([_lat length]==0 || [_lng length]==0) {
        [MNMToast showWithText:@"该店铺没有留下位置信息" autoHidding:YES priority:MNMToastPriorityNormal completionHandler:^(MNMToastValue *toast) {
            
        } tapHandler:^(MNMToastValue *toast) {
            
        }];
        return;
    }
    MapViewController *map = [[MapViewController alloc] initWithLat:_lat andLng:_lng andName:[_detailDictionary objectForKey:@"name"] andCounty:[_detailDictionary objectForKey:@"county"]];
    [self.navigationController pushViewController:map animated:YES];
}
- (void)phoneAction:(id)sender {
    NSLog(@"%s",__func__);
    if ([_tel length]==0) {
        [MNMToast showWithText:@"该店铺没有留下电话号码" autoHidding:YES priority:MNMToastPriorityNormal completionHandler:^(MNMToastValue *toast) {
            
        } tapHandler:^(MNMToastValue *toast) {
            
        }];
        return;
    }
    
    NSArray *array = [_tel componentsSeparatedByString:@" "];
    NSLog(@"array:%@",array);
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"拨打热线咨询"];
    [sheet setCancelButtonWithTitle:@"取消" atIndex:0 block:NULL];
    for (NSString *str in array) {
        [sheet addButtonWithTitle:str block:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]];
        }];
    }
    [sheet showInView:self.scrollView];
}
- (void)websetAction:(id)sender {
    NSLog(@"%s",__func__);
    if ([_wap_url length]==0) {
        [MNMToast showWithText:@"该店铺没有主页信息" autoHidding:YES priority:MNMToastPriorityNormal completionHandler:^(MNMToastValue *toast) {
            
        } tapHandler:^(MNMToastValue *toast) {
            
        }];
        return;
    }
    
SVWebViewController *webController = [[SVWebViewController alloc] initWithAddress:_wap_url];
[self.navigationController pushViewController:webController animated:YES];

}

#pragma UITableViewDelegate And UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_table]) {
        return 50;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_table]) {
        return _commentsArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"ILOVEYOU,DONGXUE";
    @autoreleasepool {
    if ([tableView isEqual:_table]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        
        
        return cell;
     }
    }
    return nil;
}
@end
