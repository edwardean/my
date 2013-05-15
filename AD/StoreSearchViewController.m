//
//  StoreSearchViewController.m
//  AD
//
//  Created by Edward on 13-5-11.
//  Copyright (c) 2013年 斌. All rights reserved.
//
#import "ViewController.h"
#import "StoreSearchViewController.h"
#import "StoreDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
@interface StoreSearchViewController ()
@property (nonatomic, retain) UIImageView *ohhImg;
@end

@implementation StoreSearchViewController
typedef enum {
    titleLabelTag = 1,
    detailLabelTag,
    commentLabelTag,
    cateLabelTag,
    accessoryViewTag,
    imgViewTag,
} CellContentSubView;
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
    self.title = @"地点";
    UITableView *tabeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 480) style:UITableViewStylePlain];
    self.table = tabeView;
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    [self.table setFrame:CGRectMake(0, 0, 320, 480)];
	[self.view addSubview:_table];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 1)];
    [_table setTableFooterView:footerView];
    [_table setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"search_table_bg"]]];
    


    api = [[AibangApi alloc] init];
    api.delegate = self;
    storeDetail = [[StoreDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ohh"]];
    self.ohhImg = imgView;
    [_ohhImg setCenter:self.view.center];
    [_ohhImg setHidden:YES];
    [self.view addSubview:_ohhImg];
    [DejalKeyboardActivityView activityViewForView:self.view withLabel:@"正在加载..."];
}
- (void)passStoreSearchArray:(NSArray *)arry {
    self.array = arry;
    if ([arry count]>0) {
        [DejalActivityView removeView];
        [_ohhImg setHidden:YES];
        [self.table reloadData];
    } else {
        [DejalActivityView removeView];
        [_ohhImg setHidden:NO];
        //NSLog(@"没有数据");
         
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark UITableViewDelegate

- (void)setImageFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath completion:(void (^)(void))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        UIImage *avatar = nil;
        avatar = [UIImage imageWithData:responseData];
        if (avatar) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
                cell.imageView.image = avatar;
                [_table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
            
        }
        
    });
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_table]) {
        return _array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"ILOVEYOU,DONGXUE";
    UITableViewCell *cell = nil;
    if ([tableView isEqual:_table]) {
        @autoreleasepool {
        cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 50)];
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 190, 50)];
            UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(112, 36, 30, 20)];
            UILabel *cateLabel = [[UILabel alloc] initWithFrame:CGRectMake(147, 36, 140, 20)];
            UIImageView *likeHeartView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart"]];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
            [imgView.layer setCornerRadius:4.0f];
            [imgView.layer setMasksToBounds:YES];
            [likeHeartView setFrame:CGRectMake(96, 40, 16, 16)];
            
            [titleLabel setTag:titleLabelTag];
            [detailLabel setTag:detailLabelTag];
            [commentLabel setTag:commentLabelTag];
            [cateLabel setTag:cateLabelTag];
            [imgView setTag:imgViewTag];
            [cell.contentView addSubview:titleLabel];
            [cell.contentView addSubview:detailLabel];
            [cell.contentView addSubview:commentLabel];
            [cell.contentView addSubview:cateLabel];
            [cell.contentView addSubview:likeHeartView];
            [cell.contentView addSubview:imgView];
        }
        NSDictionary *dictionary = [_array objectAtIndex:[indexPath row]];

        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImageView *_imgView = (UIImageView *)[cell.contentView viewWithTag:imgViewTag];
            [_imgView setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"img_url"]] placeholderImage:[UIImage imageNamed:@"photoDefault.jpg"] options:SDWebImageProgressiveDownload];
        //});
        

        UILabel *Titlelable = (UILabel *)[cell.contentView viewWithTag:titleLabelTag];
        UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:detailLabelTag];
        [detailLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [Titlelable setText:[dictionary objectForKey:@"name"]];
        [Titlelable setAdjustsFontSizeToFitWidth:YES];
        [detailLabel setText:[dictionary objectForKey:@"addr"]];
        [detailLabel setTextColor:[UIColor lightGrayColor]];
        [detailLabel setNumberOfLines:0];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [Titlelable setBackgroundColor:[UIColor clearColor]];

        UIButton *accessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [accessButton setFrame:CGRectMake(0, 0, 16, 16)];
        [accessButton setBackgroundImage:[UIImage imageNamed:@"soft_cell_detail_button"] forState:UIControlStateNormal];
        cell.accessoryView = accessButton;
            
        UILabel *_commentLabel = (UILabel *)[cell.contentView viewWithTag:commentLabelTag];
        [_commentLabel setBackgroundColor:[UIColor clearColor]];
        [_commentLabel setTextColor:[UIColor grayColor]];
        [_commentLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [_commentLabel setText:[NSString stringWithFormat:@"%@分",[dictionary objectForKey:@"rate"]]];
        UILabel *_cateLabel = (UILabel *)[cell.contentView viewWithTag:cateLabelTag];
        [_cateLabel setBackgroundColor:[UIColor clearColor]];
        [_cateLabel setTextColor:[UIColor grayColor]];
        [_cateLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [_cateLabel setAdjustsFontSizeToFitWidth:NO];
        [_cateLabel setText:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"cate"]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [_array objectAtIndex:[indexPath row]];
    NSString *store_id = [dic objectForKey:@"id"];
    //NSString *store_detail = [dic objectForKey:@"desc"];
    
    //////////////////////////////////////////////////////////////////////////////////////////
    //[api bizWithBid:store_id];                                                            //
    //////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    [self.navigationController pushViewController:storeDetail animated:YES];
    storeDetail.store_uid = store_id;
//////////////////////////////////////////////////////////////////////////////////////////////
    ParseData *paser = [[ParseData alloc] init];
    storeDetail.detailDictionary = [paser ParseStoreDetailData:nil];
    ////NSLog(@"Dic......%@",storeDetail.detailDictionary);
    [storeDetail.table reloadData];
    [storeDetail loadInfo];
///////////////////////////////////////////////////////////////////////////////////////////////
}

- (void)requestDidFailedWithError:(NSError *)error aibangApi:(id)aibangApi {
    [UIAlertView showErrorWithMessage:[error localizedDescription] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)requestDidFinishWithData:(NSData *)data aibangApi:(id)aibangApi {
    ParseData *paser = [[ParseData alloc] init];
    storeDetail.detailDictionary = [paser ParseStoreDetailData:data];
    [storeDetail.table reloadData];
    [storeDetail loadInfo];
}
@end
