//
//  AibangAsyncApi.m
//  aiguang
//
//  Created by mac on 11-10-25.
//  Copyright 2011年 aibang.com. All rights reserved.
//

#import "ABasyncApi.h"
#import "ABAsyncHttp.h"
#import "AibangApi.h"

@interface ABasyncApi (private) 

- (NSString*) serverUrl;

@end

@implementation ABasyncApi

- (NSString*) serverUrl {
    return @"http://openapi.aibang.com";
}

- (NSString *)normalizedRequestParameters:(NSDictionary *)aParameters {
	NSMutableArray *parametersArray = [NSMutableArray array];
	for (NSString *key in aParameters) {
        NSString *value = [aParameters valueForKey:key];
		[parametersArray addObject:[NSString stringWithFormat:@"%@=%@", 
                                    key, 
                                    [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	}
	return [parametersArray componentsJoinedByString:@"&"];
}

- (NSString*) nameValString: (NSDictionary*) dict {
	NSArray* keys = [dict allKeys];
	NSString* result = [NSString string];
	int i;
	for (i = 0; i < [keys count]; i++) {
        result = [result stringByAppendingString:
                  [@"--" stringByAppendingString:
                   [@"0194784892923" stringByAppendingString:
                    [@"\r\nContent-Disposition: form-data; name=\"" stringByAppendingString:
                     [[keys objectAtIndex: i] stringByAppendingString:
                      [@"\"\r\n\r\n" stringByAppendingString:
                       [[dict valueForKey: [keys objectAtIndex: i]] stringByAppendingString: @"\r\n"]]]]]]];
	}
	
	return result;
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
                              Delegate:(id)aDelegate{
    NSString* url = [NSString stringWithFormat:@"%@/search", self.serverUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (address) {
        [parameters setObject:address forKey:@"a"];
    }
    if (lat) {
        [parameters setObject:lat forKey:@"lat"];
    }
    if (lng) {
        [parameters setObject:lng forKey:@"lng"];
    }
    if (city) {
        [parameters setObject:city forKey:@"city"];
    }
    if (query) {
        [parameters setObject:query forKey:@"q"];
    }
    if (category) {
        [parameters setObject:category forKey:@"cate"];
    }
    if (radius) {
        [parameters setObject:radius forKey:@"as"];
    }
    if (rc) {
        [parameters setObject:rc forKey:@"rc"];
    }
    if (from) {
        [parameters setObject:from forKey:@"from"];
    }
    if (to) {
        [parameters setObject:to forKey:@"to"];
    }
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
}


- (NSURLConnection *) locateWithCity:(NSString *)city
                                Addr:(NSString *)addr
                            Delegate:(id)aDelegate{
    NSString *url = [NSString stringWithFormat:@"%@/locate",self.serverUrl];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (city) {
        [parameters setObject:city forKey:@"city"];
    }
    if (addr) {
        [parameters setObject:addr forKey:@"addr"];
    }
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
}


- (NSURLConnection *) bizWithBid:(NSString *)bid
                        Delegate:(id)aDelegate{
    NSString *url = @"";
    if (bid) {
        url = [NSString stringWithFormat:@"%@/biz/%@",self.serverUrl,bid];
    }else{
        url = [NSString stringWithFormat:@"%@/biz/",self.serverUrl];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
}


- (NSURLConnection *)bizCommentsWithBid:(NSString *)bid
                               Delegate:(id)aDelegate{
    NSString *url = @"";
    if (bid) {
        url = [NSString stringWithFormat:@"%@/biz/%@/comments",self.serverUrl,bid];
    }else{
        url = [NSString stringWithFormat:@"%@/biz/comments",self.serverUrl];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
    
}

- (NSURLConnection *)bizPicsWithBid:(NSString *)bid
                               From:(NSString *)from 
                                 To:(NSString *)to 
                           Delegate:(id)aDelegate{
    NSString *url = @"";
    if (bid) {
        url = [NSString stringWithFormat:@"%@/biz/%@/pics",self.serverUrl,bid];
    }else{
        url = [NSString stringWithFormat:@"%@/biz/pics",self.serverUrl];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if(from){
        [parameters setObject:from forKey:@"from"];
    }
    if (to) {
        [parameters setObject:to forKey:@"to"]; 
    }
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
    
}

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
                                Delegate:(id)aDelegate{
    NSString *url = [NSString stringWithFormat:@"%@/bus/transfer",self.serverUrl];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (city) {
        [parameters setObject:city forKey:@"city"];
    }
    if (startAddr) {
        [parameters setObject:startAddr forKey:@"start_addr"];
    }
    if (endAddr) {
        [parameters setObject:endAddr forKey:@"end_addr"];
    }
    if (startLng) {
        [parameters setObject:startLng forKey:@"start_lng"];
    }
    if (startLat) {
        [parameters setObject:startLat forKey:@"start_lat"];
    }
    if (endLng) {
        [parameters setObject:endLng forKey:@"end_lng"];
    }
    if (endLat) {
        [parameters setObject:endLat forKey:@"end_lat"];
    }
    if(rc){
        [parameters setObject:rc forKey:@"rc"];
    }
    if (count) {
        [parameters setObject:count forKey:@"count"]; 
    }
    if (withxys) {
        [parameters setObject:withxys forKey:@"with_xys"]; 
    }
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
    
}

- (NSURLConnection *)buslinesWithCity:(NSString *)city
                              KeyWord:(NSString *)keyword
                              Withxys:(NSString *)withxys
                             Delegate:(id)aDelegate{
    NSString *url = [NSString stringWithFormat:@"%@/bus/lines",self.serverUrl];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (city) {
        [parameters setObject:city forKey:@"city"];
    }
    if (keyword) {
        [parameters setObject:keyword forKey:@"q"];
    }
    if(withxys){
        [parameters setObject:[NSString stringWithFormat:@"%d", withxys] forKey:@"with_xys"];
    }    
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
    
}

- (NSURLConnection *)busStatsWithCity:(NSString *)city
                              Keyword:(NSString *) keyword
                             Delegate:(id)aDelegate{
    NSString *url = [NSString stringWithFormat:@"%@/bus/stats",self.serverUrl];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (city) {
        [parameters setObject:city forKey:@"city"];
    }
    if (keyword) {
        [parameters setObject:keyword forKey:@"q"];
    }
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
    
}

- (NSURLConnection *)busStatsAroundWithCity:(NSString *)city
                                       Dist:(NSString *)dist
                                        Lng:(NSString *)lng
                                        Lat:(NSString *)lat
                                   Delegate:(id)aDelegate{
    NSString *url = [NSString stringWithFormat:@"%@/bus/stats_xy",self.serverUrl];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (city) {
        [parameters setObject:city forKey:@"city"];
    }
    if (dist) {
        [parameters setObject:dist forKey:@"dist"];
    }
    if (lng) {
        [parameters setObject:lng forKey:@"lng"];
        
    }
    if (lat) {
        [parameters setObject:lat forKey:@"lat"];
        
    }    
    if (APPKEY) {
        [parameters setObject:APPKEY forKey:@"app_key"];
    }
    [parameters setObject:@"json" forKey:@"alt"];
    
    NSString* parameterStr = [self normalizedRequestParameters:parameters];
    return [ABAsyncHttp httpGet:url 
                    queryString:parameterStr 
                       delegate:aDelegate];
    
}


- (NSURLConnection *)postCommentToBizWithBid:(NSString *)bid
                                       Uname:(NSString *)uname
                                       Score:(NSString *)score
                                        Cost:(NSString *)cost
                                     Content:(NSString *)content
                                    Delegate:(id)aDelegate{
    if (!APPKEY) {
        APPKEY = @"";
    }
    NSString *url = [NSString stringWithFormat:@"%@/biz/%@/comment?app_key=%@&uname=%@&alt=%@", self.serverUrl, bid, APPKEY, uname, @"json"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (score) {
        [dic setValue:score forKey:@"score"];
    }
    if (cost) {
        [dic setValue:cost forKey:@"cost"];
    }
    NSString *param = [self nameValString:dic];
    NSString *footer = [NSString stringWithFormat:@"\r\n--0194784892923--\r\n"];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"--0194784892923\r\n"]];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"content\"\r\n\r\n"]];
    NSMutableData *data = [NSMutableData data];
    [data appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[footer dataUsingEncoding:NSUTF8StringEncoding]];
    [dic release];
    return [ABAsyncHttp httpPost:url queryString:data delegate:aDelegate];
}

- (NSURLConnection *)postBizPicWithBid:(NSString *)bid
                                 Uname:(NSString *)uname
                                 Title:(NSString *)title
                             ImageData:(NSData *)imageData
                              Delegate:(id)aDelegate{
    if (!APPKEY) {
        APPKEY = @"";
    }
    NSString *url = [NSString stringWithFormat:@"%@/biz/%@/pic?app_key=%@&uname=%@&alt=%@", self.serverUrl, bid, APPKEY, uname, @"json"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title", nil];
    NSString *param = [self nameValString:dic];
    NSString *footer = [NSString stringWithFormat:@"\r\n--0194784892923--\r\n"];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"--0194784892923\r\n"]];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\";Content-Type: image/jpeg\r\n\r\n"]];
    NSMutableData *data = [NSMutableData data];
    [data appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:imageData];
    [data appendData:[footer dataUsingEncoding:NSUTF8StringEncoding]];
    return [ABAsyncHttp httpPost:url queryString:data delegate:aDelegate];
}


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
                                     Delegate:(id)aDelegate{
    if (!APPKEY) {
        APPKEY = @"";
    }
    NSString *url = [NSString stringWithFormat:@"%@/biz/%@?app_key=%@&uname=%@&alt=%@", self.serverUrl, bid, APPKEY, uname, @"json"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (bname) {
        [dic setValue:bname forKey:@"bname"];
    }
    if (status) {
        [dic setValue:status forKey:@"status"];
    }
    if (tel) {
        [dic setValue:tel forKey:@"tel"];
    }
    if (city) {
        [dic setValue:city forKey:@"city"];
    }
    if (county) {
        [dic setValue:county forKey:@"county"];
    }
    if (addr) {
        [dic setValue:addr forKey:@"addr"];
    }
    if (desc) {
        [dic setValue:desc forKey:@"desc"];
    }
    if (lat) {
        [dic setValue:lat forKey:@"lat"];
    }
    if (lng) {
        [dic setValue:lng forKey:@"lng"];
    }
    if (cate) {
        [dic setValue:cate forKey:@"cate"];
    }
    if (worktime) {
        [dic setValue:worktime forKey:@"worktime"];
    }
    if (cost) {
        [dic setValue:cost forKey:@"cost"];
    }
    if (siteurl) {
        [dic setValue:siteurl forKey:@"siteurl"];
    }
    NSString *param = [self nameValString:dic];
    NSString *footer = [NSString stringWithFormat:@"\r\n--0194784892923--\r\n"];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"--0194784892923\r\n"]];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"Content-Disposition: form-data\r\n\r\n"]];
    NSMutableData *data = [NSMutableData data];
    [data appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[footer dataUsingEncoding:NSUTF8StringEncoding]];
    [dic release];
    return [ABAsyncHttp httpPost:url queryString:data delegate:aDelegate];
}


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
                                    Delegate:(id)aDelegate{
    if (!APPKEY) {
        APPKEY = @"";
    }
    NSString *url = [NSString stringWithFormat:@"%@/biz?app_key=%@&uname=%@&alt=%@", self.serverUrl, APPKEY, uname, @"json"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (bname) {
        [dic setValue:bname forKey:@"bname"];
    }
    if (status) {
        [dic setValue:status forKey:@"status"];
    }
    if (tel) {
        [dic setValue:tel forKey:@"tel"];
    }
    if (city) {
        [dic setValue:city forKey:@"city"];
    }
    if (county) {
        [dic setValue:county forKey:@"county"];
    }
    if (addr) {
        [dic setValue:addr forKey:@"addr"];
    }
    if (desc) {
        [dic setValue:desc forKey:@"desc"];
    }
    if (lat) {
        [dic setValue:lat forKey:@"lat"];
    }
    if (lng) {
        [dic setValue:lng forKey:@"lng"];
    }
    if (cate) {
        [dic setValue:cate forKey:@"cate"];
    }
    if (worktime) {
        [dic setValue:worktime forKey:@"worktime"];
    }
    if (cost) {
        [dic setValue:cost forKey:@"cost"];
    }
    if (siteurl) {
        [dic setValue:siteurl forKey:@"siteurl"];
    }
    NSString *param = [self nameValString:dic];
    NSString *footer = [NSString stringWithFormat:@"\r\n--0194784892923--\r\n"];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"--0194784892923\r\n"]];
    param = [param stringByAppendingString:[NSString stringWithFormat:@"Content-Disposition: form-data\r\n\r\n"]];
    NSMutableData *data = [NSMutableData data];
    [data appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[footer dataUsingEncoding:NSUTF8StringEncoding]];
    [dic release];
    return [ABAsyncHttp httpPost:url queryString:data delegate:aDelegate];
}



@end

















