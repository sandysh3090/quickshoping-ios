//
//  NSBundle+PunchhDefaults.m
//  Punchh Framework
//
//  Created by Aditya Sanghi on 03/08/13.
//  Copyright (c) 2013 Punchh. All rights reserved.
//

#import "NSBundle+PunchhDefaults.h"

@implementation NSBundle (PunchhDefaults)

+(NSString *)punchhAppKey {
    return [self valueForKeyWithAssert:@"PunchhAppKey"];
}

+(NSString *)iTunesAppleID {
    return [self valueForKeyWithAssert:@"ITunesAppleID"];
}

+(BOOL)punchhSounds {
    return ![[[self mainBundle] objectForInfoDictionaryKey:@"StopPunchhSounds"] boolValue];
}

+(BOOL)enablePunchhUsingBeacon {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"EnablePunchhUsingBeacon"] boolValue];
}

+(BOOL)enableBeaconEntry {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"EnableBeaconEntry"] boolValue];
}

+(BOOL)showOfferReward {
    return ![[[self mainBundle] objectForInfoDictionaryKey:@"ShowRewardOffers"] boolValue];
}

+(BOOL)showInviteFbFriend {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"ShowFbInvite"] boolValue];
}

+(BOOL)showSlideMenuPanel {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"SlideMenuEnabled"] boolValue];
}

+(NSString*)mainstoryboardFileBaseName {
    return [[self mainBundle] objectForInfoDictionaryKey:@"UIMainStoryboardFile"];
}

+(NSString *)googleAnalyticsKey {
#ifdef DEBUG
    return [[self mainBundle] objectForInfoDictionaryKey:@"GoogleAnalyticsKeyStaging"];
#else
    return [self valueForKeyWithAssert:@"GoogleAnalyticsKeyLive"];
#endif
}

+(NSString *)shortVersionString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(NSString *)currentBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+(NSString *)bundleDisplayName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] ? : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+(NSString *)googleApiKey {
    return [self valueForKeyWithAssert:@"googleApiKey"];
}

+(BOOL)isStatusBarHidden {
    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIStatusBarHidden"] boolValue];
}

+(NSString *)hockeyAppKey {
    return [self valueForKeyWithAssert:@"HockeyAppID"];
}

+(NSString *) valueForKeyWithAssert:(NSString *)key {
//    NSString *value = [[self mainBundle] objectForInfoDictionaryKey:key];
//    NSAssert(value.present, @"Please add %@ key in Info.plist",key);
    return nil;
}

+(BOOL)showLocationsWhenCheckin {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"ShowLocationsWhenCheckin"] boolValue];
}

+(BOOL)showLocationsWhenRedeem {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"ShowLocationsWhenRedeem"] boolValue];
}

+(NSNumber *)appleTokenReadability {
    // Send nil to server instead of false
    return [[[self mainBundle] objectForInfoDictionaryKey:@"AppleTokenReadability"] boolValue] ? [NSNumber numberWithBool:YES] : nil;
}

+(BOOL)showAdditionalScannerButton {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"showAdditionalScannerButton"] boolValue];
}

+(BOOL)showImageBasedLocations {
    return [[[self mainBundle] objectForInfoDictionaryKey:@"showImageBasedLocation"] boolValue];
}

+(NSString *)facebookAppId {
    return [[self mainBundle] objectForInfoDictionaryKey:@"FacebookAppID"];
}

+(NSString *)environment {
    return [self valueForKeyEnvironment];
}

+ (NSString *)valueForKeyEnvironment {
    if ([[[self mainBundle] objectForInfoDictionaryKey:@"Environment"] length] > 0) {
        return [[self mainBundle] objectForInfoDictionaryKey:@"Environment"];
    } else {
#ifdef DEBUG
        NSAssert(false, @"Please add a new run script build phase : \"${SRCROOT}/framework-ios/Scripts/iconVersioning.sh\" in target > build phases > new run script phase");
#endif
        return @"";
    }
}

+(NSString *)LocationWhenInUseKey {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"];
}

+(NSString *)LocationAlwaysUseKey {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"];
}


@end
