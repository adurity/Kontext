/*
 * File: CMKDefaults.h
 * Description: Contains default values for the application.
 */

@import Foundation;


extern NSString *BeaconIdentifier;


@interface CMKDefaults : NSObject

+ (CMKDefaults *)sharedDefaults;

@property (nonatomic, readonly) NSArray *locations;

@end
