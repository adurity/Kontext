/*
 * File: CMKDefaults.h
 * Description: Contains default values for the application.
 */

@import Foundation;


extern NSString *BeaconIdentifier;


@interface CMKDefaults : NSObject

+ (CMKDefaults *)sharedDefaults;

@property (nonatomic, copy, readonly) NSArray *supportedProximityUUIDs;

@property (nonatomic, copy, readonly) NSUUID *defaultProximityUUID;
@property (nonatomic, copy, readonly) NSNumber *defaultPower;

@end
