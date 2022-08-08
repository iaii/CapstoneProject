//
//  ActivityRec.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import "ActivityRecommendation.h"

@implementation ActivityRecommendation

@dynamic activity;
@dynamic mood;

+ (nonnull NSString *)parseClassName {
    return @"Activities";
}

// adds activity to database
+ (void) postNewActivity: (NSString * _Nullable )activity withMood: (NSString * _Nullable )mood withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    ActivityRecommendation *newActivity = [ActivityRecommendation new];
    
    newActivity.activity = activity;
    newActivity.mood = mood;
    
    [newActivity saveInBackgroundWithBlock: completion];
}

+ (void) updateActivity: (NSString * _Nullable )activity withMood: (NSString * _Nullable )mood withCompletion: (PFBooleanResultBlock  _Nullable)completion {
//    [Activities.firstEmotionTag
//    [saveInBackgroundWIthBlock: completion];
}

@end
