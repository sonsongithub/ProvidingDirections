//
//  PinAnnotation.h
//  ProvidingDirections
//
//  Created by sonson on 2012/10/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PinAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
