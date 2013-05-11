//
//  ParseData.h
//  AD
//
//  Created by Edward on 13-5-11.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseData : NSObject {
    TBXML *_tb;
}
@property (nonatomic, retain) TBXML *tb;
- (id)init;
- (NSMutableArray *)ParseSearchStoreData:(NSData *)data;
- (NSMutableArray *)ParseStoreDetailData:(NSData *)data;
- (NSMutableArray *)ParseStoreCommentData:(NSData *)data;
- (NSMutableArray *)ParseStoreImageData:(NSData *)data;
@end
