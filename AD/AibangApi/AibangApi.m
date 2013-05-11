//
//  AibangApi.m
//  AibangApi
//
//  Created by Liujun Deng on 12-4-9.
//  Copyright (c) 2012年 aibang.com. All rights reserved.
//

#import "AibangApi.h"
#import "ABasyncApi.h"
#import "ABConnection.h"
@implementation AibangApi

@synthesize delegate;

-(void) dealloc {
    [self connectionCancel];
    [http release];
    [super dealloc];
}

-(void)connectionCancel{
    [http.connection cancel];
}

+ (void)setAppkey:(NSString *)appkey{
    [APPKEY release];
    APPKEY = [appkey retain];
}
#pragma mark callback handler

-(void) handleData:(NSData*)data WithConnection:(ABConnection*)connection {
    if (delegate && [delegate respondsToSelector:@selector(requestDidFinishWithData:aibangApi:)]) {
        [delegate performSelector:@selector(requestDidFinishWithData:aibangApi:) withObject:data withObject:self];
    }
}

-(void) handleError:(NSError*)error WithConnection:(ABConnection*)connection {
    if (delegate && [delegate respondsToSelector:@selector(requestDidFailedWithError:aibangApi:)]) {
        [delegate performSelector:@selector(requestDidFailedWithError:aibangApi:) withObject:error withObject:self];
    }
}

#pragma mark api interfaces
- (void) searchBizWithCity:(NSString *)city 
                     Query:(NSString *)query
                   Address:(NSString *)address
                  Category:(NSString *)category
                       Lng:(NSString *)lng
                       Lat:(NSString *)lat
                    Radius:(NSString *)radius
                  Rankcode:(NSString *)rc
                      From:(NSString *)from
                        To:(NSString *)to; {
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api searchBizWithCity:city
                                            Query:query
                                          Address:address
                                         Category:category
                                              Lng:lng
                                              Lat:lat
                                           Radius:radius
                                         Rankcode:rc
                                             From:from
                                               To:to
                                         Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}

- (void) locateWithCity:(NSString *)city
                   Addr:(NSString *)addr {
    
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api locateWithCity:city 
                                          Addr:addr 
                                      Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}
                            
- (void) bizWithBid:(NSString *)bid{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api bizWithBid:bid Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}
                            
- (void) bizCommentsWithBid:(NSString *)bid{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api bizCommentsWithBid:bid
                                          Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}

- (void)bizPicsWithBid:(NSString *)bid
                  From:(NSString *)from
                    To:(NSString *)to{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api bizPicsWithBid:bid 
                                          From:from 
                                            To:to
                                          Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}                            
                            
- (void)busTransferWithCity:(NSString *)city
                  StartAddr:(NSString *)startAddr
                    EndAddr:(NSString *)endAddr
                   StartLng:(NSString *)startLng
                   StartLat:(NSString *)startLat
                     EndLng:(NSString *)endLng
                     EndLat:(NSString *)endLat
                         Rc:(NSString *)rc
                      Count:(NSString *)count
                    Withxys:(NSString *)withxys{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api busTransferWithCity:city
                                         StartAddr:startAddr
                                           EndAddr:endAddr
                                          StartLng:startLng
                                          StartLat:startLat
                                            EndLng:endLng 
                                            EndLat:endLat
                                                 Rc:rc
                                              Count:count
                                           Withxys:withxys
                                           Delegate:http]; 
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}  
                            
-(void)buslinesWithCity:(NSString *)city
                KeyWord:(NSString *)keyword
                Withxys:(NSString *)withxys{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api buslinesWithCity:city
                                         KeyWord:keyword
                                        Withxys:withxys
                                        Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}                              
                            
                            
-(void)busStatsWithCity:(NSString *)city
                Keyword:(NSString *) keyword{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api busStatsWithCity:city
                                         Keyword:keyword
                                        Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}                             
                            
-(void)busStatsAroundWithCity:(NSString *)city
                         Dist:(NSString *)dist
                          Lng:(NSString *)lng
                          Lat:(NSString *)lat{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api busStatsAroundWithCity:city
                                            Dist:dist
                                             Lng:lng
                                             Lat:lat
                                            Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}                             
                            
-(void)postCommentToBizWithBid:(NSString *)bid
                         Uname:(NSString *)uname
                         Score:(NSString *)score
                          Cost:(NSString *)cost
                       Content:(NSString *)content{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api postCommentToBizWithBid:bid
                                                  Uname:uname
                                                  Score:score
                                                   Cost:cost
                                                Content:content
                                               Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}                           
                            
-(void)postBizPicWithBid:(NSString *)bid
                   Uname:(NSString *)uname
                   Title:(NSString *)title
               ImageData:(NSData *)imageData{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api postBizPicWithBid:bid
                                            Uname:uname
                                            Title:title
                                        ImageData:imageData
                                         Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}                                 
                            
-(void)postModifyBizInfoWithBid:(NSString *)bid
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
                        SiteUrl:(NSString *)siteurl{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api postModifyBizInfoWithBid:bid
                                                   Uname:uname
                                                   Bname:bname
                                                  Status:status
                                                     Tel:tel
                                                    City:city
                                                  County:county
                                                    Addr:addr
                                                    Desc:desc
                                                     Lng:lng
                                                     Lat:lat
                                                    Cate:cate
                                                Worktime:worktime
                                                    Cost:cost
                                                 SiteUrl:siteurl
                                                Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}   

- (void)postAddBizInfoWithBname:(NSString *)bname
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
                        SiteUrl:(NSString *)siteurl{
    ABasyncApi* api = [[ABasyncApi alloc] init];
    if (http) {
        [http cancel];
        [http release];
    }
    http = [[ABConnection alloc] init];
    NSURLConnection* url = [api postAddBizInfoWithBname:bname
                                                   Uname:uname
                                                  Status:status
                                                     Tel:tel
                                                    City:city
                                                  County:county
                                                    Addr:addr
                                                    Desc:desc
                                                     Lng:lng
                                                     Lat:lat
                                                    Cate:cate
                                                Worktime:worktime
                                                    Cost:cost
                                                 SiteUrl:siteurl
                                                Delegate:http];
    http.connection = url;
    http.callback = self;
    [http execute];
    [api release];
}


@end
