//
//  CMKLocation.h
//  Kontext
//
//  Created by Adam Durity on 3/26/14.
//  Copyright (c) 2014 Carnegie Mellon University. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface CMKLocation : NSObject

- (instancetype)initWithIdentifier:(NSString *) identifier
                              name:(NSString *) name
                            region:(CLBeaconRegion *) region;
- (instancetype)initWithDictionary:(NSDictionary *) dict;

@property NSString *identifier;
@property NSString *name;
@property CLBeaconRegion *region;

@end
