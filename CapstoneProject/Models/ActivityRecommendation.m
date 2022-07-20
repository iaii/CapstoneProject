//
//  ActivityRec.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import "ActivityRecommendation.h"

@implementation ActivityRecommendation

@dynamic Activity;
@dynamic EmotionTag;

+ (nonnull NSString *)parseClassName {
    return @"Activities";
}

+ (void) postNewActivity: (NSString * _Nullable )activity withMood: (NSString * _Nullable )mood withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    ActivityRecommendation *newActivity = [ActivityRecommendation new];
    
    newActivity.Activity = activity;
    newActivity.EmotionTag = mood;
    
    [newActivity saveInBackgroundWithBlock: completion];
}

@end
