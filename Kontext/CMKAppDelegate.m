/*
 * File: CMKAppDelegate.m
 * Description: Main entry point for the application. Displays the main menu and
 * notifies the user when region state transitions occur.
 */

#import "CMKAppDelegate.h"
@import CoreLocation;


@interface CMKAppDelegate () <UIApplicationDelegate, CLLocationManagerDelegate>

@property CLLocationManager *locationManager;

@end



@implementation CMKAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // This location manager will be used to notify the user of region state transitions.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    return YES;
}


- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    /*
     A user can transition in or out of a region while the application is not running. When this happens CoreLocation will launch the application momentarily, call this delegate method and we will let the user know via a local notification.
     */
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if(state == CLRegionStateInside)
    {
        notification.alertBody = NSLocalizedString(@"You're inside the region", @"");
    }
    else if(state == CLRegionStateOutside)
    {
        notification.alertBody = NSLocalizedString(@"You're outside the region", @"");
    }
    else
    {
        return;
    }
    
    /*
     If the application is in the foreground, it will get a callback to application:didReceiveLocalNotification:.
     If it's not, iOS will display the notification to the user.
     */
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // If the application is in the foreground, we will notify the user of the region's state via an alert.
    NSString *cancelButtonTitle = NSLocalizedString(@"OK", @"Title for cancel button in local notification");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertBody message:nil delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alert show];
}


@end
