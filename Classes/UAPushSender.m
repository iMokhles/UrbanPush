//
//  Config.h
//  UrbanPush
//
//  Created by iMokhles on 26/01/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import "UAPushSender.h"
#import "Config.h"
// #import <AirshipKit/AirshipKit.h>

@implementation UAPushSender

@synthesize soundID;
@synthesize alertString;
@synthesize deviceID;

+ (instancetype)sharedInstance {
    
    __strong static UAPushSender *instance;
    
    if (!instance)
        instance = [UAPushSender new];
    
    return instance;
}

- (void)dealloc {
    
    self.soundID = nil;
    self.alertString = nil;
    self.deviceID = nil;
    
    [super dealloc];
}

// change it for your own propose
- (void)setupNotifications {
    // [UAirship push].userNotificationTypes = (UIUserNotificationTypeAlert |
    //                                          UIUserNotificationTypeSound |
    //                                          UIUserNotificationTypeBadge );
    
    // UAMutableUserNotificationAction *likeAction = [[UAMutableUserNotificationAction alloc] init];
    // likeAction.destructive = NO;
    // likeAction.activationMode = UIUserNotificationActivationModeBackground;
    // likeAction.authenticationRequired = NO;
    // likeAction.title = @"like!";
    // likeAction.identifier = @"like_action";
    
    // UAMutableUserNotificationCategory *category = [[UAMutableUserNotificationCategory alloc] init];
    // [category setActions:@[likeAction] forContext:UIUserNotificationActionContextMinimal];
    // [category setActions:@[likeAction] forContext:UIUserNotificationActionContextDefault];
    // category.identifier = @"ca_app_like_category";
    // [UAirship push].userNotificationCategories = [NSSet setWithArray:@[category]];
    
    // [[UAirship push] updateRegistration];
    // [[UAirship push] resetBadge];
    // [[UAirship push] deviceToken];
    // [UAirship push].userPushNotificationsEnabled = YES;
}

- (void)sendPush {
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://go.urbanairship.com/api/push/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/vnd.urbanairship+json; version=3;" forHTTPHeaderField:@"Accept"];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", UA_APP_KEY, UA_APP_MASTER];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *push = @{
                           
                           @"audience" : @{
                                   @"device_token" : deviceID
                                   },
                           @"device_types" : @[ @"ios" ],
                           @"notification" : @{
                                   @"ios" : @{
                                           @"alert":alertString,
                                           @"sound":@"default",
                                           @"badge":@"+1",
                                           @"category":@"ca_app_like_category",
                                           }
                                   }
                           };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:push
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:NULL];
    [request setHTTPBody:jsonData];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnection Delegates
- (void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}
@end
