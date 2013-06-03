//
//  Help.h
//  AD
//
//  Created by Edward on 13-5-11.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#ifndef AD_Help_h
#define AD_Help_h
#define US [NSUserDefaults standardUserDefaults]
#define CITYKEY @"key"

#define BUGAPIKEY               @"407fe0dd"

//ShareSDKAppKey
#define ShareSDKAppKey          @"37cecbd32a0"

//SinaWeibo
#define SinaWeiboAppKey         @"3773964248"
#define SinaWeiboAppSecret      @"36314fe504b0d228ca8404500591ca90"
#define SinaWeiboRedirectURI    @"http://www.hao123.com"

//TencentWeibo
#define TencentWeiboAppKey      @"100711170"
#define TencentWeiboAppSecret   @"884bb83c28ed2d591a4d7e45507484a5"
#define TencentWeiboRedirectURI @"http://www.google.com"

//QZone
#define QZoneAppKey             @"100447377"
#define QZoneAppSecret          @"8dc89d943ba5687c735600c52c032537"

//QQ
#define QQApiID                @"QQ05FD7722"

//KaiXin
#define KaiXinAppKey            @"59964263497550fe9bb6dad8be686091"
#define KaiXinAppSecret         @"c2b3fd74e9774f406251d281396bbfec"
#define KaiXinAppRedirectURI    @"http://www.hao123.com"

//RenRen
#define RenRenAppKey            @"f590ae20eff94bb6924a64890c11ff86"
#define RenRenAppSecret         @"3633f02d4ca049ac88be0d3a10a9d4a3"

//WeiChat
#define WeiChatAppKey           @"wxab8c1d07d0c15e24"
#define WeiChatAppSecret        @"8cab9999ee80dffd0c576837a302de76"


//UTF-8
#define UTF8String(str) [[NSString stringWithFormat:@"%@",str] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//app_key
#define APP_KEY @"f41c8afccc586de03a99c86097e98ccb"//@"1d07b03072c3b0ad9b369dfaaa1f1f06"//

//商户搜索
#define Search_Store(city,store) [NSString stringWithFormat:@"http://openapi.aibang.com/search?app_key=%@&city=%@&q=%@",APP_KEY,UTF8String(city),UTF8String(store)]


//商户详情
#define Store_Detail(store_id) [NSString stringWithFormat:@"http://openapi.aibang.com/biz/%@?app_key=%@",store_id,APP_KEY]

//商户评论
#define Store_Comment(store_id) [NSString stringWithFormat:@"http://openapi.aibang.com/biz/%@/comments?app_key=%@",store_id,APP_KEY]

//商户图片
#define Store_Image(store_id) [NSString stringWithFormat:@"http://openapi.aibang.com/biz/%@/pics?app_key=%@",store_id,APP_KEY]

//发表评论
//#define CommentToStore(store_id,score,content) [NSString stringWithFormat:@"http://openapi.aibang.com/biz/%@/comment?app_key=%@&uname=api_user"]
#endif
