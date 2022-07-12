//
//  AppDelegate.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <Parse/PFFacebookUtils.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[PFFacebookUtils initializeFacebook]; //fb login for parse

    // Override point for customization after application launch.
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

            configuration.applicationId = @"vYvX2773RsFsjdTrphr53DHW2l8oFoCO7X1o5pbN"; // <- UPDATE
            configuration.clientKey = @"nwIuDEd9dckFjXMEWni8aDyY7D4m4UWVU205z0aG"; // <- UPDATE
            configuration.server = @"https://parseapi.back4app.com";
        }];

        [Parse initializeWithConfiguration:config];

    return YES;
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//  [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]]; //fb login for parse
//}
//
//
//- (BOOL)application:(UIApplication *)application
//        openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//     annotation:(id)annotation {
//  return [FBAppCall handleOpenURL:url
//              sourceApplication:sourceApplication
//                    withSession:[PFFacebookUtils session]];
//}
//
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//  [[PFFacebookUtils session] close];
//}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
