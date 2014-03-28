//
//  CMKLocation.m
//  Kontext
//
//  Created by Adam Durity on 3/26/14.
//  Copyright (c) 2014 Carnegie Mellon University. All rights reserved.
//

#import "CMKLocation.h"

@implementation CMKLocation

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name
                            region:(CLBeaconRegion *)region
                            events:(NSDictionary *)events {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = name;
        _region = region;
        _events = events;
    }

    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    NSString *name = [dict objectForKey:@"name"];
    NSString *identifier = [dict objectForKey:@"identifier"];
    NSDictionary *events = [dict objectForKey:@"events"];

    NSDictionary *beacon = [dict objectForKey:@"beacon"];
    NSUUID *proximityUUID = [[NSUUID alloc]
        initWithUUIDString:[beacon objectForKey:@"proximityUUID"]];
    CLBeaconMajorValue major =
        [[beacon objectForKey:@"major"] unsignedShortValue];
    CLBeaconMinorValue minor =
        [[beacon objectForKey:@"minor"] unsignedShortValue];
    CLBeaconRegion *region;

    if (proximityUUID && major && minor && identifier)
    {
        region = [[CLBeaconRegion alloc]
                        initWithProximityUUID:proximityUUID
                        major:major
                        minor:minor
                        identifier:identifier];
    }
    else if (proximityUUID && major && identifier)
    {
        region = [[CLBeaconRegion alloc]
                        initWithProximityUUID:proximityUUID
                        major:major
                        identifier:identifier];
    }
    else if (proximityUUID && identifier)
    {
        region = [[CLBeaconRegion alloc]
                        initWithProximityUUID:proximityUUID
                        identifier:identifier];
    }
    else
    {
        NSLog(@"WARNING: Unable to create beacon region %@", identifier);
    }

    return [self initWithIdentifier:identifier
                               name:name
                             region:region
                             events:events];
}

@end
