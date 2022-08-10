//
//  ActivityRec.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import "AXActivityRecommendation.h"

@implementation AXActivityRecommendation

@dynamic activity;
@dynamic mood;

+ (nonnull NSString *)parseClassName {
    return @"Activities";
}

// adds activity to database
+ (void)postNewActivity:(NSString * _Nullable )activity
                   mood:(NSString * _Nullable)mood
             completion:(PFBooleanResultBlock  _Nullable)completion {
    AXActivityRecommendation *newActivity = [AXActivityRecommendation new];
    
    newActivity.activity = activity;
    newActivity.mood = mood;
    
    [newActivity saveInBackgroundWithBlock:completion];
}

@end
