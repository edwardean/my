//
//  ABConnection.h
//  AibangApi
//
//  Created by Liujun Deng on 12-4-10.
//  Copyright (c) 2012年 aibang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AibangApi.h"

@interface ABConnection : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData* _bufData;
    NSURLConnection* _connection;
    AibangApi* _callback;
}

@property(nonatomic, retain) NSURLConnection* connection;
@property(nonatomic, assign) AibangApi* callback;
-(void) cancel;
-(void) execute;
@end
