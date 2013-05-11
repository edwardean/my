//
//  ViewController.h
//  AD
//
//  Created by 斌 on 12-12-3.
//  Copyright (c) 2012年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <AibangApiDelegate>{

    IBOutlet UIScrollView *sv;
    
    IBOutlet UIPageControl *page;
    int TimeNum;
    BOOL Tend;
    AibangApi *api;
}

@end
