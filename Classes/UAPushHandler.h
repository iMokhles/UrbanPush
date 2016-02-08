//
//  Config.h
//  UrbanPush
//
//  Created by iMokhles on 26/01/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
// #import <AirshipKit/AirshipKit.h>

@interface UAPushHandler : NSObject //<UAPushNotificationDelegate>
@property(nonatomic, retain) NSDictionary *lastPayload;
@end
