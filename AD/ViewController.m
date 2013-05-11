//
//  ViewController.m
//  AD
//
//  Created by 斌 on 12-12-3.
//  Copyright (c) 2012年 斌. All rights reserved.
//

#import "ViewController.h"
#import "CHDraggableView+Avatar.h"
@interface ViewController ()
@property (nonatomic, retain) NSArray *array;

@property (nonatomic, retain) NSArray *iconArray;

@property (nonatomic, retain) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    api = [[AibangApi alloc] init];
    api.delegate = self;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    self.array = @[@"ktv",@"spa",@"健身",@"咖啡",@"推拿",@"棋牌",@"游泳",@"网吧",@"茶艺",@"足疗",@"马术",@"高尔夫"];
    
    self.iconArray = @[@"电影院_icon",@"ktv_icon",@"spa_icon",@"健身_icon",@"coffie",@"按摩_icon",@"游泳_icon",@"网吧_icon",@"茶艺_icon",@"象棋_icon",@"horse_icon",@"高尔夫_icon"];
    [self AddImg];
    [self setCurrentPage:page.currentPage];
    
    
    float width = self.view.frame.size.width/4.0;
    float height = self.view.frame.size.height - 240;
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
    self.arr = @[@"电影院",@"KTV",@"SPA",@"健身",@"Coffie",@"按摩",@"游泳",@"网吧",@"茶艺",@"象棋",@"马术",@"高尔夫"];
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
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [api searchBizWithCity:@"北京"
//                     Query:@"餐馆"
//                   Address:@""
//                  Category:@""
//                       Lng:@""
//                       Lat:@""
//                    Radius:@""
//                  Rankcode:@"0"
//                      From:@"1"
//                        To:@"10"];
   ParseData *parse =  [[ParseData alloc] init];
   NSLog(@"%@",[parse ParseStoreCommentData:nil]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnTapped:(id)sender {

    NSLog(@"%@",[_arr objectAtIndex:(int)((UIButton *)sender).tag]);
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
        size.height = 24/2;
        size.width = 24/2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"a.png"]];
        else [subview setImage:[UIImage imageNamed:@"d.png"]];
    }
}

- (void)requestDidFinishWithData:(NSData *)data aibangApi:(id)aibangApi {
   NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",str);
}
@end
