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

@interface StoreSearchViewController ()

@end

@implementation StoreSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 480) style:UITableViewStylePlain];
        [self.table setDelegate:self];
        [self.table setDataSource:self];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.table setFrame:CGRectMake(0, 0, 320, 480)];
	[self.view addSubview:_table];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 1)];
    [_table setTableFooterView:footerView];
    [_table setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"search_table_bg"]]];
    


    api = [[AibangApi alloc] init];
    api.delegate = self;
    storeDetail = [[StoreDetailViewController alloc] initWithNibName:nil bundle:nil];
}
- (void)passStoreSearchArray:(NSArray *)arry {
    self.array = arry;
    [self.table reloadData];
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
    if ([tableView isEqual:_table]) {
        @autoreleasepool {
        NSDictionary *dictionary = [_array objectAtIndex:[indexPath row]];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 50)];
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 190, 50)];
            UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(112, 36, 30, 20)];
            UILabel *cateLabel = [[UILabel alloc] initWithFrame:CGRectMake(147, 36, 140, 20)];
            titleLabel.tag = 1;
            detailLabel.tag = 2;
            commentLabel.tag = 3;
            cateLabel.tag = 4;
            [cell.contentView addSubview:titleLabel];
            [cell.contentView addSubview:detailLabel];
            [cell.contentView addSubview:commentLabel];
            [cell.contentView addSubview:cateLabel];
        }
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
        [cell.contentView addSubview:imgView];
        [imgView.layer setCornerRadius:4.0f];
        imgView.layer.masksToBounds = YES;
        [imgView setImageWithURL:[dictionary objectForKey:@"img_url"] placeholderImage:[UIImage imageNamed:@"photoDefault.jpg"]];

        UILabel *Titlelable = (UILabel *)[cell.contentView viewWithTag:1];
        UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:2];
        [detailLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [Titlelable setText:[dictionary objectForKey:@"name"]];
        [Titlelable setAdjustsFontSizeToFitWidth:YES];
        [detailLabel setText:[dictionary objectForKey:@"addr"]];
        [detailLabel setTextColor:[UIColor lightGrayColor]];
        [detailLabel setNumberOfLines:0];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [Titlelable setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *accessTory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"soft_cell_detail_button"]];
        cell.accessoryView = accessTory;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *commentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart"]];
        [commentView setFrame:CGRectMake(96, 40, 16, 16)];
        [cell.contentView addSubview:commentView];
        UILabel *_commentLabel = (UILabel *)[cell.contentView viewWithTag:3];
        [_commentLabel setBackgroundColor:[UIColor clearColor]];
        [_commentLabel setTextColor:[UIColor grayColor]];
        [_commentLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [_commentLabel setText:[NSString stringWithFormat:@"%@分",[dictionary objectForKey:@"rate"]]];
        UILabel *_cateLabel = (UILabel *)[cell.contentView viewWithTag:4];
        [_cateLabel setBackgroundColor:[UIColor clearColor]];
        [_cateLabel setTextColor:[UIColor grayColor]];
        [_cateLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [_cateLabel setAdjustsFontSizeToFitWidth:NO];
        [_cateLabel setText:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"cate"]]];
        return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [_array objectAtIndex:[indexPath row]];
    NSString *store_id = [dic objectForKey:@"id"];
    NSString *store_detail = [dic objectForKey:@"desc"];
    NSLog(@"%@ %@",store_id,store_detail);
    [api bizWithBid:store_id];
    
    [self.navigationController pushViewController:storeDetail animated:YES];
}

- (void)requestDidFailedWithError:(NSError *)error aibangApi:(id)aibangApi {
    NSLog(@"%s",__func__);
}

- (void)requestDidFinishWithData:(NSData *)data aibangApi:(id)aibangApi {
    NSLog(@"%s",__func__);
    ParseData *paser = [[ParseData alloc] init];
    storeDetail.detailDictionary = [paser ParseStoreDetailData:data];
    NSLog(@"Dic......%@",storeDetail.detailDictionary);
    [storeDetail.table reloadData];
    [storeDetail loadInfo];
}
@end
