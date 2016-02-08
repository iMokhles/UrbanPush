//
//  Config.h
//  UrbanPush
//
//  Created by iMokhles on 26/01/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import "UAPushHandler.h"
#import "Config.h"

@implementation UAPushHandler

- (void)dealloc {
    self.lastPayload = nil;
}

- (void)displayNotificationAlert:(NSString *)alertMessage {
    
    UA_LDEBUG(@"Received an alert in the foreground.");
    if (![self isStringEmpty:alertMessage]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"ContrAlert"
                                                        message: alertMessage
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)displayLocalizedNotificationAlert:(NSDictionary *)alertDict {
    
    // The alert is a a dictionary with more details, let's just get the message without localization
    // This should be customized to fit your message details or usage scenario
    //message = [[alertDict valueForKey:@"alert"] valueForKey:@"body"];
    
    UA_LDEBUG(@"Received an alert in the foreground with a body.");
    
    NSString *body = [alertDict valueForKey:@"body"];
    
    if (![self isStringEmpty:body]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert"
                                                        message: body
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)playNotificationSound:(NSString *)sound {
    
    if (sound) {
        
        // Note: The default sound is not available in the app.
        //
        // From http://developer.apple.com/library/ios/#documentation/AudioToolbox/Reference/SystemSoundServicesReference/Reference/reference.html :
        // System-supplied alert sounds and system-supplied user-interface sound effects are not available to your iOS application.
        // For example, using the kSystemSoundID_UserPreferredAlert constant as a parameter to the AudioServicesPlayAlertSound
        // function will not play anything.
        
        SystemSoundID soundID;
        NSString *path = [[NSBundle mainBundle] pathForResource:[sound stringByDeletingPathExtension]
                                                         ofType:[sound pathExtension]];
        if (path) {
            UALOG(@"Received a foreground alert with a sound: %@", sound);
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
            AudioServicesPlayAlertSound(soundID);
        } else {
            UALOG(@"Received an alert with a sound that cannot be found the application bundle: %@", sound);
        }
        
    } else {
        
        // Vibrates on supported devices, on others, does nothing
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
    }
    
}

- (void)handleBadgeUpdate:(NSInteger)badgeNumber {
    UA_LDEBUG(@"Received an alert in the foreground with a new badge");
    
    // Sets the application badge to the value in the notification
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
}

- (void)receivedForegroundNotification:(NSDictionary *)notification {
    self.lastPayload = notification;
    NSLog(@"====== Received a notification while the app was already in the foreground ======");
//    [[ActionRegistrar shared] handleIncomingPush:notification];
}

- (void)receivedBackgroundNotification:(NSDictionary *)notification {
    NSLog(@"HERE---------------------------");
    self.lastPayload = notification;
}

- (void)receivedBackgroundNotification:(NSDictionary *)notification fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"====== Received a Background Push while the App was in the background ======");
    self.lastPayload = notification;
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)launchedFromNotification:(NSDictionary *)notification {
    self.lastPayload = notification;
    UA_LDEBUG(@"The application was launched or resumed from a notification");
//    [[ActionRegistrar shared] handleIncomingPush:notification];
}

- (void)launchedFromNotification:(NSDictionary *)notification actionIdentifier:(NSString *)identifier completionHandler:(void (^)())completionHandler {
    NSLog(@"%@", identifier);
}

- (void)receivedBackgroundNotification:(NSDictionary *)notification actionIdentifier:(NSString *)identifier completionHandler:(void (^)())completionHandler {
    NSLog(@"%@", identifier);
}

- (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0) {
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return YES;
    }
    
    return NO;
}

@end
