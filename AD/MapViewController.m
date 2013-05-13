//
//  MapViewController.m
//  AD
//
//  Created by Edward on 13-5-13.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "MapViewController.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"
@interface MapViewController ()
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@property (nonatomic, retain) MKMapView *map;
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *locateString;
@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithLat:(NSString *)_lat andLng:(NSString *)_lng andName:(NSString *)_name andCounty:(NSString *)_county{
    if (self  =[super init]) {
        CLLocationCoordinate2D coor;
        coor.latitude = [_lat floatValue];
        coor.longitude = [_lng floatValue];
        self.theCoordinate = coor;
        self.store_name = _name;
        self.locateString = _county;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _store_name;
    MKMapView *theMap = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map = theMap;
    DDAnnotation *annotation  =[[DDAnnotation alloc] initWithCoordinate:_theCoordinate addressDictionary:nil];
    annotation.title = _store_name;
    annotation.subtitle = _locateString;
    MKCoordinateRegion myRegion;
    MKCoordinateSpan mySpan;
    
    mySpan.latitudeDelta = .01;
    mySpan.longitudeDelta = .01;
    myRegion.span = mySpan;
	myRegion.center = _theCoordinate;
    [_map addAnnotation:annotation];
    //[_map setMapType:MKMapTypeHybrid];
    myRegion = [_map regionThatFits:myRegion];
    [_map setRegion:myRegion animated:YES];
    [self.view addSubview:_map];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
