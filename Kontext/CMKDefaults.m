/*
 * File: CMKDefaults.m
 * Description: Contains default values for the application.
 */


#import "CMKDefaults.h"

#import "CMKLocation.h"
@import CoreLocation;


NSString *BeaconIdentifier = @"EstimoteSampleRegion";

@interface CMKDefaults ()

- (void)loadLocations;

@end

@implementation CMKDefaults
{
    NSMutableArray *_locations;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        _locations = [NSMutableArray array];

        [self loadLocations];
    }
    
    return self;
}


+ (CMKDefaults *)sharedDefaults
{
    static id sharedDefaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDefaults = [[self alloc] init];
    });
    
    return sharedDefaults;
}


- (void)loadLocations
{
    NSString *locationDictionaryPath;

    if ((locationDictionaryPath =
        [[NSBundle mainBundle] pathForResource:@"Locations"
                                        ofType:@"plist"]))
    {
        NSArray *locations =
            [NSArray arrayWithContentsOfFile:locationDictionaryPath];
        for (NSDictionary *locationDictionary in locations)
        {
            CMKLocation *location;
            location = [[CMKLocation alloc]
                            initWithDictionary:locationDictionary];
            [_locations addObject:location];
        }
    }
}


@end
