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
    self.nameLabel = name;
    [self.scrollView addSubview:_nameLabel];
        
        UILabel *cost = [[UILabel alloc] initWithFrame:CGRectMake(115, 30, 160, 20)];
        self.costLabel = cost;
        [self.scrollView addSubview:_costLabel];
        [_costLabel setTextColor:[UIColor redColor]];
        [_costLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
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
        
    }

}
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
