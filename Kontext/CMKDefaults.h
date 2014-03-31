/*
 * File: CMKDefaults.h
 * Description: Contains default values for the application.
 */

@import Foundation;


extern NSString *BeaconIdentifier;
extern NSString * const CMKUserDefaultUseBeaconsForContext;


@interface CMKDefaults : NSObject

@property (nonatomic, readonly) NSArray *locations;
@property (nonatomic, readonly) BOOL useBeaconsForContext;

+ (CMKDefaults *)sharedDefaults;

- (void)registerUserDefaults;

@end
