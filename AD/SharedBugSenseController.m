//
//  SharedBugSenseController.m
//  AD
//
//  Created by Edward on 13-6-3.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "SharedBugSenseController.h"

@implementation SharedBugSenseController
+ (BugSenseController *)sharedBugSenseController {
    static dispatch_once_t onceToken;
    static BugSenseController *sharedBugSenseController;
    
    dispatch_once(&onceToken, ^{
        sharedBugSenseController = [BugSenseController sharedControllerWithBugSenseAPIKey:BUGAPIKEY];
    });
    return sharedBugSenseController;
}
@end
