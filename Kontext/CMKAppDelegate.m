/*
 * File: CMKAppDelegate.m
 * Description: Main entry point for the application. Displays the main menu and
 * notifies the user when region state transitions occur.
 */

#import "CMKAppDelegate.h"

#import "CMKDefaults.h"
#import "CMKLocation.h"
@import CoreLocation;


@interface CMKAppDelegate () <UIApplicationDelegate, CLLocationManagerDelegate>

- (void)registerBeaconsForMonitoring;

@property CLLocationManager *locationManager;
@property BOOL insideGHC;
@property int count;

@end



@implementation CMKAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = @{CMKUserDefaultUseBeaconsForContext: @YES};

    [defaults registerDefaults:appDefaults];
    [defaults synchronize];

    // This location manager will be used to notify the user of region state transitions.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    [self registerBeaconsForMonitoring];

    return YES;
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    if([region.identifier  isEqual: @"com.example.apple-samplecode.AirLocate"])
    {
        
    }
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    if([region.identifier  isEqual: @"com.example.apple-samplecode.AirLocate"])
    {
        
    }
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    
    // identify closest beacon in range
    if ([beacons count] > 0) {
        CLBeacon *closestBeacon = beacons[0];
        if (closestBeacon.proximity == CLProximityImmediate && closestBeacon.major.intValue == 18542) {

            if(self.insideGHC){
                
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                NSString *test = [NSString stringWithFormat:@"Welcome to GHC!(%d)", self.count];
                notification.alertBody = NSLocalizedString(test,@"");
            
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                self.insideGHC = false;
            }
        }
        
        else if(closestBeacon.proximity == CLProximityFar && closestBeacon.major.intValue == 18542) {

            if(self.insideGHC==false){
                self.insideGHC = true;
                self.count++;
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    /*
     A user can transition in or out of a region while the application is not running. When this happens CoreLocation will launch the application momentarily, call this delegate method and we will let the user know via a local notification.
     */
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if(state == CLRegionStateInside && [region.identifier isEqual: @"EstimoteSampleRegion"])
    {
        //notification.alertBody = NSLocalizedString(@"Welcome you are in GHC!", @"");
    }
    else if(state == CLRegionStateOutside)
    {
        //notification.alertBody = NSLocalizedString(@"You're outside the region", @"");
    }
    else
    {
        return;
    }

    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // If the application is in the foreground, we will notify the user of the region's state via an alert.
    NSString *cancelButtonTitle = NSLocalizedString(@"OK", @"Title for cancel button in local notification");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertBody message:nil delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alert show];
}

- (void)registerBeaconsForMonitoring
{
    for (CMKLocation *location in [[CMKDefaults sharedDefaults] locations]) {
        CLBeaconRegion *region = location.region;

        if ([self.locationManager.monitoredRegions member:region]) {
            NSLog(@"Region already registered: %@", region.identifier);
        }
        else
        {
            region.notifyOnEntry = YES;
            region.notifyOnExit = YES;
            [self.locationManager startMonitoringForRegion:region];
            NSLog(@"Monitoring region %@", region);
        }
    }
}


@end
