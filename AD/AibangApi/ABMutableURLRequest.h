//
//  ABMutableURLRequest.h
//  aiguang
//
//  Created by mac on 11-10-25.
//  Copyright 2011年 aibang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABMutableURLRequest : NSObject

//Return a request for http get method
+ (NSMutableURLRequest *)requestGet:(NSString *)aUrl queryString:(NSString *)aQueryString;

//Return a request for http post method
+ (NSMutableURLRequest *)requestPost:(NSString *)aUrl queryString:(NSData *)data;


@end
