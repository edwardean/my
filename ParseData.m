//
//  ParseData.m
//  AD
//
//  Created by Edward on 13-5-11.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "ParseData.h"
@interface ParseData ()
@property (nonatomic, retain) NSMutableArray *array;
- (TBXML *)TBXMLWithData:(NSData *)data;
@end
@implementation ParseData

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (TBXML *)TBXMLWithData:(NSData *)data {
    return [TBXML tbxmlWithXMLData:data];
}
- (NSMutableArray *)ParseSearchStoreData:(NSData *)data {
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    TBXML *tbxml = [[TBXML alloc] initWithXMLData:data];
    TBXMLElement *root = tbxml.rootXMLElement;
    ////
    ////
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    //使用本地XML数据测试
    //TBXML *tbxml = [[TBXML alloc] initWithXMLFile:@"Search_Store.xml"];
    //TBXMLElement *root = tbxml.rootXMLElement;
    
    if (root) {
        TBXMLElement *total = [TBXML childElementNamed:@"total" parentElement:root];
        TBXMLElement *result_num = [TBXML childElementNamed:@"result_num" parentElement:root];
        TBXMLElement *bizs = [TBXML childElementNamed:@"bizs" parentElement:root];
       if (bizs != nil) {
            TBXMLElement *biz = [TBXML childElementNamed:@"biz" parentElement:bizs];
            while (biz != nil) {
                TBXMLElement *store_id = [TBXML childElementNamed:@"id" parentElement:biz];
                TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:biz];
                TBXMLElement *addr = [TBXML childElementNamed:@"addr" parentElement:biz];
                TBXMLElement *tel = [TBXML childElementNamed:@"tel" parentElement:biz];
                TBXMLElement *cate = [TBXML childElementNamed:@"cate" parentElement:biz];
                TBXMLElement *rate = [TBXML childElementNamed:@"rate" parentElement:biz];
                TBXMLElement *cost = [TBXML childElementNamed:@"cost" parentElement:biz];
                TBXMLElement *desc = [TBXML childElementNamed:@"desc" parentElement:biz];
                TBXMLElement *dist = [TBXML childElementNamed:@"dist" parentElement:biz];
                TBXMLElement *lng = [TBXML childElementNamed:@"lng" parentElement:biz];
                TBXMLElement *lat = [TBXML childElementNamed:@"lat" parentElement:biz];
                TBXMLElement *img_url = [TBXML childElementNamed:@"img_url" parentElement:biz];
                NSDictionary *dictionary = @{@"total": [TBXML textForElement:total],
                                             @"result_num" : [TBXML textForElement:result_num],
                                             @"id"   : [TBXML textForElement:store_id],
                                             @"name" : [TBXML textForElement:name],
                                             @"addr" : [TBXML textForElement:addr],
                                             @"tel"  : [TBXML textForElement:tel],
                                             @"cate" : [TBXML textForElement:cate],
                                             @"rate" : [TBXML textForElement:rate],
                                             @"cost" : [TBXML textForElement:cost],
                                             @"desc" : [TBXML textForElement:desc],
                                             @"dist" : [TBXML textForElement:dist],
                                             @"lng"  : [TBXML textForElement:lng],
                                             @"lat"  : [TBXML textForElement:lat],
                                             @"img_url" : [TBXML textForElement:img_url]};
                biz = [TBXML nextSiblingNamed:@"biz" searchFromElement:biz];
                [array addObject:dictionary];
            }
        }
    }
    [tbxml release];
    return array;
}
- (NSDictionary *)ParseStoreDetailData:(NSData *)data {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    TBXML *tbxml = [[TBXML alloc] initWithXMLData:data];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    NSDictionary *dictionary = [NSDictionary dictionary];
    
    //使用本地XML数据测试
    //TBXML *tbxml = [[TBXML alloc] initWithXMLFile:@"Store_Detail.xml"];
    TBXMLElement *root = tbxml.rootXMLElement;
    if (root) {
        TBXMLElement *biz = [TBXML childElementNamed:@"biz" parentElement:root];
        if (biz) {
            TBXMLElement *store_id = [TBXML childElementNamed:@"id" parentElement:biz];
            TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:biz];
            TBXMLElement *county = [TBXML childElementNamed:@"county" parentElement:biz];
            TBXMLElement *addr = [TBXML childElementNamed:@"addr" parentElement:biz];
            TBXMLElement *tel = [TBXML childElementNamed:@"tel" parentElement:biz];
            TBXMLElement *cate = [TBXML childElementNamed:@"cate" parentElement:biz];
            TBXMLElement *rate = [TBXML childElementNamed:@"rate" parentElement:biz];
            TBXMLElement *rateScore = [TBXML childElementNamed:@"rateScore" parentElement:biz];
            TBXMLElement *cost = [TBXML childElementNamed:@"cost" parentElement:biz];
            TBXMLElement *desc = [TBXML childElementNamed:@"desc" parentElement:biz];
            TBXMLElement *lng = [TBXML childElementNamed:@"lng" parentElement:biz];
            TBXMLElement *lat = [TBXML childElementNamed:@"lat" parentElement:biz];
            TBXMLElement *work_time = [TBXML childElementNamed:@"work_time" parentElement:biz];
            TBXMLElement *site_url = [TBXML childElementNamed:@"site_url" parentElement:biz];
            TBXMLElement *web_url = [TBXML childElementNamed:@"web_url" parentElement:biz];
            TBXMLElement *wap_url = [TBXML childElementNamed:@"wap_url" parentElement:biz];
            TBXMLElement *img_url = [TBXML childElementNamed:@"img_url" parentElement:biz];
            dictionary = @{@"id"       :   [TBXML textForElement:store_id],
                                        @"name"     :   [TBXML textForElement:name],
                                        @"county"   :   [TBXML textForElement:county],
                                        @"addr"     :   [TBXML textForElement:addr],
                                        @"tel"      :   [TBXML textForElement:tel],
                                        @"cate"     :   [TBXML textForElement:cate],
                                        @"rate"     :   [TBXML textForElement:rate],
                                        @"rateScore":   [TBXML textForElement:rateScore],
                                        @"cost"     :   [TBXML textForElement:cost],
                                        @"desc"     :   [TBXML textForElement:desc],
                                        @"lng"      :   [TBXML textForElement:lng],
                                        @"lat"      :   [TBXML textForElement:lat],
                                        @"work_time":   [TBXML textForElement:work_time],
                                        @"site_url" :   [TBXML textForElement:site_url],
                                        @"web_url"  :   [TBXML textForElement:web_url],
                                        @"wap_url"  :   [TBXML textForElement:wap_url],
                                        @"img_url"  :   [TBXML textForElement:img_url]};
        }
    }
    
    [tbxml release];
    return dictionary;
}
- (NSMutableArray *)ParseStoreCommentData:(NSData *)data {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    TBXML *xmlParse = [[TBXML alloc] initWithXMLData:data];
    TBXMLElement *root = xmlParse.rootXMLElement;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //使用本地XML数据测试
    //TBXML *xmlParse = [[TBXML alloc] initWithXMLFile:@"Store_Comment.xml"];
    //TBXMLElement *root = xmlParse.rootXMLElement;
    if (root) {
        TBXMLElement *total = [TBXML childElementNamed:@"total" parentElement:root];
        TBXMLElement *result_num = [TBXML childElementNamed:@"result_num" parentElement:root];
        TBXMLElement *web_url = [TBXML childElementNamed:@"web_url" parentElement:root];
        TBXMLElement *wap_url = [TBXML childElementNamed:@"wap_url" parentElement:root];
        TBXMLElement *commemts = [TBXML childElementNamed:@"comments" parentElement:root];
        if (commemts) {
            TBXMLElement *comment = [TBXML childElementNamed:@"comment" parentElement:commemts];
            while (comment != nil) {
                TBXMLElement *uid = [TBXML childElementNamed:@"uid" parentElement:comment];
                TBXMLElement *uname = [TBXML childElementNamed:@"uname" parentElement:comment];
                TBXMLElement *avatar_url = [TBXML childElementNamed:@"avatar_url" parentElement:comment];
                TBXMLElement *space_url = [TBXML childElementNamed:@"space_url" parentElement:comment];
                TBXMLElement *pubtime = [TBXML childElementNamed:@"pubtime" parentElement:comment];
                TBXMLElement *score = [TBXML childElementNamed:@"score" parentElement:comment];
                TBXMLElement *cost = [TBXML childElementNamed:@"cost" parentElement:comment];
                TBXMLElement *content = [TBXML childElementNamed:@"content" parentElement:comment];
                NSDictionary *dictionary = @{@"total"       :   [TBXML textForElement:total],
                                             @"result_num"  :   [TBXML textForElement:result_num],
                                             @"web_url"     :   [TBXML textForElement:web_url],
                                             @"wap_url"     :   [TBXML textForElement:wap_url],
                                             @"uid"         :   [TBXML textForElement:uid],
                                             @"uname"       :   [TBXML textForElement:uname],
                                             @"avatar_url"  :   [TBXML textForElement:avatar_url],
                                             @"space_url"   :   [TBXML textForElement:space_url],
                                             @"pubtime"     :   [TBXML textForElement:pubtime],
                                             @"score"       :   [TBXML textForElement:score],
                                             @"cost"        :   [TBXML textForElement:cost],
                                             @"content"     :   [TBXML textForElement:content]};
                [array addObject:dictionary];
                
                comment = [TBXML nextSiblingNamed:@"comment" searchFromElement:comment];
            }
        }
    }
    [xmlParse release];
    return array;
}
- (NSMutableArray *)ParseStoreImageData:(NSData *)data {
    self.tb = [self TBXMLWithData:data];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    //使用本地XML数据测试
    TBXML *xmlParse = [[TBXML alloc] initWithXMLFile:@"Store_Image.xml"];
    TBXMLElement *root = xmlParse.rootXMLElement;
    if (root) {
        TBXMLElement *total = [TBXML childElementNamed:@"total" parentElement:root];
        TBXMLElement *result_num = [TBXML childElementNamed:@"result_num" parentElement:root];
        TBXMLElement *web_url = [TBXML childElementNamed:@"web_url" parentElement:root];
        TBXMLElement *wap_url = [TBXML childElementNamed:@"wap_url" parentElement:root];
        TBXMLElement *pics = [TBXML childElementNamed:@"pics" parentElement:root];
        if (pics) {
            TBXMLElement *pic = [TBXML childElementNamed:@"pic" parentElement:pics];
            while (pic != nil) {
                TBXMLElement *uid = [TBXML childElementNamed:@"uid" parentElement:pic];
                TBXMLElement *uname = [TBXML childElementNamed:@"uname" parentElement:pic];
                TBXMLElement *avatar_url = [TBXML childElementNamed:@"avatar_url" parentElement:pic];
                TBXMLElement *space_url = [TBXML childElementNamed:@"space_url" parentElement:pic];
                TBXMLElement *pubtime = [TBXML childElementNamed:@"pubtime" parentElement:pic];
                TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:pic];
                TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:pic];
                TBXMLElement *thumbnail_url  =[TBXML childElementNamed:@"thumbnail_url" parentElement:pic];
                
                NSDictionary *dictionary = @{@"total"       :   [TBXML textForElement:total],
                                             @"result_num"  :   [TBXML textForElement:result_num],
                                             @"web_url"     :   [TBXML textForElement:web_url],
                                             @"wap_url"     :   [TBXML textForElement:wap_url],
                                             @"uid"         :   [TBXML textForElement:uid],
                                             @"uname"       :   [TBXML textForElement:uname],
                                             @"avatar_url"  :   [TBXML textForElement:avatar_url],
                                             @"space_url"   :   [TBXML textForElement:space_url],
                                             @"pubtime"     :   [TBXML textForElement:pubtime],
                                             @"title"       :   [TBXML textForElement:title],
                                             @"url"         :   [TBXML textForElement:url],
                                             @"thumbnail_url":  [TBXML textForElement:thumbnail_url]};
                [array addObject:dictionary];
                pic = [TBXML nextSiblingNamed:@"pic" searchFromElement:pic];
            }
        }
    }
    
    [xmlParse release];
    return array;
}
@end
