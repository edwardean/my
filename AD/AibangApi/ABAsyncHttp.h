//
//  ABAsyncHttp.h
//  aiguang
//
//  Created by mac on 11-10-25.
//  Copyright 2011年 aibang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABAsyncHttp : NSObject


//Start a connection fro http get method and return it to delegate.
+ (NSURLConnection *)httpGet:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare;

//Start a connection fro http post method and return it to delegate.
+ (NSURLConnection *)httpPost:(NSString *)aUrl queryString:(NSData *)data delegate:(id)aDelegare;

@end
