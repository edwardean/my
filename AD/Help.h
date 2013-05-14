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

//UTF-8
#define UTF8String(str) [[NSString stringWithFormat:@"%@",str] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//app_key
#define APP_KEY @"1d07b03072c3b0ad9b369dfaaa1f1f06"//@"f41c8afccc586de03a99c86097e98ccb"

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
