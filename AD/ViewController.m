//
//  ViewController.m
//  AD
//
//  Created by 斌 on 12-12-3.
//  Copyright (c) 2012年 斌. All rights reserved.
//

#import "ViewController.h"
#import "CHDraggableView+Avatar.h"
#import "StoreSearchViewController.h"
#import "AURosetteView.h"
#import "AURosetteItem.h"
@interface ViewController ()
@property (nonatomic, retain) NSArray *array;

@property (nonatomic, retain) NSArray *iconArray;

@property (nonatomic, retain) NSArray *arr;
@end

@implementation ViewController
@synthesize sv,page;
- (void)viewDidLoad
{
    [super viewDidLoad];

}



- (void)loadView {

    [super loadView];
    [self.view setFrame:(CGRect){CGPointZero,{kKYViewWidth,kKYViewHeight}}];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 138)];
    self.sv = scrollView;
    [sv setShowsHorizontalScrollIndicator:NO];
    self.sv.delegate = self;
    
    [self.view addSubview:sv];
    UIPageControl *p = [[UIPageControl alloc] initWithFrame:CGRectMake(133, -20, 37, 320)];
    self.page = p;
    [self.view addSubview:page];
    api = [[AibangApi alloc] init];
    api.delegate = self;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    self.array = @[@"ktv",@"spa",@"健身",@"咖啡",@"推拿",@"棋牌",@"游泳",@"网吧",@"茶艺",@"足疗",@"马术",@"高尔夫"];
    
    self.iconArray = @[@"电影院_icon",@"ktv_icon",@"spa_icon",@"健身_icon",@"coffie",@"按摩_icon",@"游泳_icon",@"网吧_icon",@"茶艺_icon",@"象棋_icon",@"horse_icon",@"高尔夫_icon"];
    [self AddImg];
    [self setCurrentPage:page.currentPage];
    
    
    float width = self.view.frame.size.width/4.0;
    float height = self.view.frame.size.height - 300;
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    [_iconArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CHDraggableView *view = [CHDraggableView viewWithImage:[UIImage imageNamed:[_iconArray objectAtIndex:idx]]];
        [array addObject:view];
        
    }];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CHDraggableView *icon = (CHDraggableView *)obj;
        [self.view addSubview:icon];
        int i=idx%3+1;
        int j=idx%4+1;
        [icon setCenter:CGPointMake(j*width-40, height+(i-1)*65)];
        [self.view addSubview:icon];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:icon.frame];
        [btn setTag:idx];
        [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }];
    self.arr = @[@"电影院",@"KTV",@"SPA",@"健身",@"酒吧",@"按摩",@"游泳",@"网吧",@"茶艺",@"象棋",@"马术",@"高尔夫"];
    [_arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int i=idx%3+1;
        int j=idx%4+1;
        float x_point = j*width-40;
        float y_point = height+(i-1)*65+30;
        
        
        float width = 60.0f;
        float height = 30.0f;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [lable setText:[_arr objectAtIndex:idx]];
        [lable setCenter:CGPointMake(x_point, y_point)];
        [lable setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [lable setBackgroundColor:[UIColor clearColor]];
        [lable setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:lable];
    }];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.title = @"休闲娱乐";
    
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)btnTapped:(id)sender {

    //NSLog(@"%@",[_arr objectAtIndex:(int)((UIButton *)sender).tag]);
    NSString *cityStr = [US objectForKey:CITYKEY];
    if (!cityStr) {
        [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"None city Selected!" delegate:nil cancelButtonTitle:@"I get it." otherButtonTitles:nil, nil] show];
        return;
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////
        [api searchBizWithCity:cityStr
                        Query:[_arr objectAtIndex:(int)((UIButton *)sender).tag]
                       Address:@""
                      Category:@""
                           Lng:@""
                           Lat:@""
                        Radius:@""
                      Rankcode:@"0"
                          From:@"1"
                            To:@"100"];
//////////////////////////////////////////////////////////////////////////////////////////////////////////
 
    StoreSearchViewController *storeSearchVC = [[StoreSearchViewController alloc]initWithNibName:nil bundle:nil];
    self.searchStoreDelegate = storeSearchVC;
    [self.navigationController pushViewController:storeSearchVC animated:YES];
    
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////    
//    ParseData *parse =  [[ParseData alloc] init];
//    NSArray *array = [parse ParseSearchStoreData:nil];
//    [self.searchStoreDelegate passStoreSearchArray:array];
//////////////////////////////////////////////////////////////////////////////////////////////////////////

}

#pragma mark - 5秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 5 == 0 ) {
        
        if (!Tend) {
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             sv.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
        
        
    }
    TimeNum ++;
}
#pragma mark - 下载图片

- (void)AddImg{
    [sv setContentSize:CGSizeMake(320*[_array count], 100)];
    page.numberOfPages = [_array count];
    for (int i=0; i<[_array count]; i++) {
        NSString *str = [_array objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 140)];
        [imgView setImage:[UIImage imageNamed:str]];
        [sv addSubview:imgView];
    }
    
}


#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    page.currentPage=scrollView.contentOffset.x/320;
    [self setCurrentPage:page.currentPage];
    
    
}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        UIImageView* subview = [page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 7;
        size.width = 7;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"/Bundle.bundle/Resources/poin_hover"]];
        else [subview setImage:[UIImage imageNamed:@"/Bundle.bundle/Resources/poin_normal"]];
    }
}

#pragma mark AibangApi Delegate
- (void)requestDidFinishWithData:(NSData *)data aibangApi:(id)aibangApi {
   NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    ParseData *parse =  [[ParseData alloc] init];
    NSArray *array = [parse ParseSearchStoreData:data];
    [self.searchStoreDelegate passStoreSearchArray:array];
}

- (void)requestDidFailedWithError:(NSError *)error aibangApi:(id)aibangApi {
        [UIAlertView showErrorWithMessage:[error localizedDescription] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}





@end
