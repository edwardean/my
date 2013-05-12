//
//  AibangAsyncApi.h
//  aiguang
//
//  Created by mac on 11-10-25.
//  Copyright 2011年 aibang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ABasyncApi : NSObject {
}

- (NSURLConnection *)searchBizWithCity:(NSString *)city 
                                 Query:(NSString *)query
                               Address:(NSString *)address
                              Category:(NSString *)category
                                   Lng:(NSString *)lng
                                   Lat:(NSString *)lat
                                Radius:(NSString *)radius
                              Rankcode:(NSString *)rc
                                  From:(NSString *)from
                                    To:(NSString *)to
                              Delegate:(id)aDelegate;

- (NSURLConnection *)locateWithCity:(NSString *)city
                                Addr:(NSString *)addr
                           Delegate:(id)aDelegate;

- (NSURLConnection *)bizWithBid:(NSString *)bid
                        Delegate:(id)aDelegate;

- (NSURLConnection *)bizCommentsWithBid:(NSString *)bid
                               Delegate:(id)aDelegate;

- (NSURLConnection *)bizPicsWithBid:(NSString *)bid
                               From:(NSString *)from
                                 To:(NSString *)to
                           Delegate:(id)aDelegate;

- (NSURLConnection *)busTransferWithCity:(NSString *)city
                               StartAddr:(NSString *)startAddr
                                 EndAddr:(NSString *)endAddr
                                StartLng:(NSString *)startLng
                                StartLat:(NSString *)startLat
                                  EndLng:(NSString *)endLng
                                  EndLat:(NSString *)endLat
                                      Rc:(NSString *)rc
                                   Count:(NSString *)count
                                 Withxys:(NSString *)withxys
                                Delegate:(id)aDelegate;

- (NSURLConnection *)buslinesWithCity:(NSString *)city
                              KeyWord:(NSString *)keyword
                              Withxys:(NSString *)withxys
                             Delegate:(id)aDelegate;

- (NSURLConnection *)busStatsWithCity:(NSString *)city
                              Keyword:(NSString *) keyword
                             Delegate:(id)aDelegate;

- (NSURLConnection *)busStatsAroundWithCity:(NSString *)city
                                       Dist:(NSString *)dist
                                        Lng:(NSString *)lng
                                        Lat:(NSString *)lat
                                   Delegate:(id)aDelegate;


- (NSURLConnection *)postCommentToBizWithBid:(NSString *)bid
                                       Uname:(NSString *)uname
                                       Score:(NSString *)score
                                        Cost:(NSString *)cost
                                     Content:(NSString *)content
                                    Delegate:(id)aDelegate;


- (NSURLConnection *)postBizPicWithBid:(NSString *)bid
                                 Uname:(NSString *)uname
                                 Title:(NSString *)title
                             ImageData:(NSData *)imageData
                              Delegate:(id)aDelegate;

- (NSURLConnection *)postModifyBizInfoWithBid:(NSString *)bid
                                        Uname:(NSString *)uname
                                        Bname:(NSString *)bname
                                       Status:(NSString *)status
                                          Tel:(NSString *)tel
                                         City:(NSString *)city
                                       County:(NSString *)county
                                         Addr:(NSString *)addr
                                         Desc:(NSString *)desc
                                          Lng:(NSString *)lng
                                          Lat:(NSString *)lat
                                         Cate:(NSString *)cate
                                     Worktime:(NSString *)worktime
                                         Cost:(NSString *)cost
                                      SiteUrl:(NSString *)siteurl
                                     Delegate:(id)aDelegate;

- (NSURLConnection *)postAddBizInfoWithBname:(NSString *)bname
                                       Uname:(NSString *)uname
                                      Status:(NSString *)status
                                         Tel:(NSString *)tel
                                        City:(NSString *)city
                                      County:(NSString *)county
                                        Addr:(NSString *)addr
                                        Desc:(NSString *)desc
                                         Lng:(NSString *)lng
                                         Lat:(NSString *)lat
                                        Cate:(NSString *)cate
                                    Worktime:(NSString *)worktime
                                        Cost:(NSString *)cost
                                     SiteUrl:(NSString *)siteurl
                                     Delegate:(id)aDelegate;






@end



















