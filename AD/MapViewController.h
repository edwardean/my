//
//  MapViewController.h
//  AD
//
//  Created by Edward on 13-5-13.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController

- (id)initWithLat:(NSString *)_lat andLng:(NSString *)_lng andName:(NSString *)_name andCounty:(NSString *)_county;
@end
