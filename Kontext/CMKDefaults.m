/*
 * File: CMKDefaults.m
 * Description: Contains default values for the application.
 */


#import "CMKDefaults.h"


NSString *BeaconIdentifier = @"com.example.apple-samplecode.AirLocate";


@implementation CMKDefaults

- (id)init
{
    self = [super init];
    if(self)
    {
        // uuidgen should be used to generate UUIDs.
        _supportedProximityUUIDs = @[[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"],
                                      [[NSUUID alloc] initWithUUIDString:@"5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"],
                                      [[NSUUID alloc] initWithUUIDString:@"74278BDA-B644-4520-8F0C-720EAF059935"]];
        _defaultPower = @-59;
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


- (NSUUID *)defaultProximityUUID
{
    return _supportedProximityUUIDs[0];
}


@end
