//
//  Config.h
//  UrbanPush
//
//  Created by iMokhles on 26/01/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UAPushSender : NSObject

@property (nonatomic, strong) NSString *alertString;
@property (nonatomic, strong) NSString *deviceID;
@property (nonatomic, strong) NSString *soundID;

+ (instancetype)sharedInstance;
- (void)setupNotifications;
- (void)sendPush;

@end
