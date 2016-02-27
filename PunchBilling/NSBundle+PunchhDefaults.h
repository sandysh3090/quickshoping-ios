//
//  NSBundle+PunchhDefaults.h
//  Punchh Framework
//
//  Created by Aditya Sanghi on 03/08/13.
//  Copyright (c) 2013 Punchh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (PunchhDefaults)

+(BOOL)showInviteFbFriend;
+(BOOL)showOfferReward;
+(NSString *)punchhAppKey;
+(NSString *)iTunesAppleID;
+(BOOL)punchhSounds;
+(NSString *)googleAnalyticsKey;
+(NSString *)shortVersionString;
+(NSString *)currentBuildVersion;
+(NSString *)bundleDisplayName;
+(BOOL)enablePunchhUsingBeacon;
+(BOOL)enableBeaconEntry;
+(BOOL)showSlideMenuPanel;
+(NSString*)mainstoryboardFileBaseName;
+(NSString *)googleApiKey;
+(BOOL)isStatusBarHidden;
+(BOOL)showLocationsWhenCheckin;
+(BOOL)showLocationsWhenRedeem;
+(NSNumber *)appleTokenReadability;
+(BOOL)showAdditionalScannerButton;
+(BOOL)showImageBasedLocations;
+(NSString *)facebookAppId;
+(NSString *)environment;
+(NSString *)LocationWhenInUseKey;
+(NSString *)LocationAlwaysUseKey;
+(NSString *)hockeyAppKey;

@end
