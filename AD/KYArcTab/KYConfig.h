//
//  KYConfig.h
//  AD
//
//  Created by Edward on 13-5-10.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#ifndef AD_KYConfig_h
#define AD_KYConfig_h

#pragma mark - View  - prefix: KY

// App View Basic
#define kKYViewHeight CGRectGetHeight([UIScreen mainScreen].applicationFrame)
#define kKYViewWidth  CGRectGetWidth([UIScreen mainScreen].applicationFrame)

// Button Size
#define kKYButtonInMiniSize   16.f
#define kKYButtonInSmallSize  32.f

#define kKYButtonInNormalSize 64.f

#define DEBUG NS(@"%s",__func__)
#pragma mark - KYArcTab Configuration

#define kKYTabBarHeight     70.f
#define kKYTabBarWdith      kKYViewWidth
#define kKYTabBarItemHeight 44.f
#define kKYTabBarItemWidth  44.f

// Tab Bar
#define kKYITabBarBackground          @"KYITabBarBackground.png"
#define kKYITabBarArrow               @"KYITabBarArrow.png"
#define kKYITabBarItemImageNameFormat @"KYTabBarItem%.2d.png"
// Gesture
#define kKYIArcTabGestureHelp @"KYIArcTabGestureHelp.png"

#endif
