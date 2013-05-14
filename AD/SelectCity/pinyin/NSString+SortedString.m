//
//  NSString+SortedString.m
//  AD
//
//  Created by Edward on 13-5-13.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "NSString+SortedString.h"
#import "pinyin.h"
@implementation NSString (SortedString)
- (NSString *)getCharOfChineseCharacter {
    if ([self canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        return self;
    } else {
        return [NSString stringWithFormat:@"%c",pinyinFirstLetter([self characterAtIndex:0])];
    }
}
@end
