//
//  ViewController.h
//  AD
//
//  Created by 斌 on 12-12-3.
//  Copyright (c) 2012年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StoreSearchDelegate <NSObject>

- (void)passStoreSearchArray:(NSArray *)array;
@end
@interface ViewController : UIViewController <AibangApiDelegate,UIScrollViewDelegate>{

    IBOutlet UIScrollView *sv;
    
    IBOutlet UIPageControl *page;
    int TimeNum;
    BOOL Tend;
    AibangApi *api;
}
@property (nonatomic, retain) UIScrollView *sv;
@property (nonatomic, retain) UIPageControl *page;

@property (nonatomic, assign) id <StoreSearchDelegate> searchStoreDelegate;
@end
