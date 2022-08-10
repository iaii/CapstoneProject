//
//  RecommendationEngine.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/5/22.
//

#import "AXRecommendationEngine.h"
#import <Parse/Parse.h>

@interface AXMoodRecommendationModel: NSObject

@property (nonatomic, strong) NSArray *recommendationObjects;
@property (nonatomic, strong) NSString *activityID;

@end

@implementation AXMoodRecommendationModel

@end

@interface AXActivityModel: NSObject

@property (nonatomic, strong) NSMutableArray *coreMatches; // double array ex: [["tod", 5], ...]
@property (nonatomic, strong) NSMutableArray *features;

@end

@implementation AXActivityModel

@end


@interface AXRecommendationEngine ()

@property (strong, nonatomic) NSArray *userObjects;
@property (strong, nonatomic) NSDictionary *moodAPIResponse;

@property (strong, nonatomic) NSArray<AXMoodRecommendationModel *> *moodRecommendations;

@property (strong, nonatomic) NSArray *activities;
@property (strong, nonatomic) NSArray *coreMatchesList;
@property (strong, nonatomic) NSArray *featuresList;

@property (strong, nonatomic) NSMutableArray *filteredActivities;

@property (nonatomic, strong) NSMutableArray *coreMatches; // double array ex: [["tod", 5], ...]
@property (nonatomic, strong) NSMutableArray *features;

@property (nonatomic, strong) NSMutableArray<NSString *> *recomendedActivities;

//@property (strong, nonatomic) NSArray *firstModelArray;
//@property (strong, nonatomic) NSArray *secondModelArray;
//@property (strong, nonatomic) NSArray *thirdModelArray;

@end

@implementation AXRecommendationEngine

// gets the user's model activities
- (void)getUserInfo {
    NSMutableArray<AXMoodRecommendationModel *> *moodRecommendations = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    PFUser *user = [PFUser currentUser];
    
    [query whereKey:@"objectId" equalTo:[user objectId]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) { // this should always be true and there should only be 1 object because the user has to be logined to view this data //and there can only be unique users
            for (PFObject *object in objects) {
                self.userObjects = objects;
                
                for (NSString *mood in self.moods) {
                    AXMoodRecommendationModel *model = [AXMoodRecommendationModel new];
                    
                    NSString *name = [self arrayName:mood];
                    model.recommendationObjects = object[name];
                    model.activityID = [self findModelActivity:model.recommendationObjects];
                    
                    [moodRecommendations addObject:model];
                }
            }
            
            self.moodRecommendations = [moodRecommendations copy];
            [self setActivities];
        }
        else {
            NSLog(@"%@", error); // will change to an alert later
        }
    }];
}

- (void)setActivities {
    self.coreMatchesList = [[NSArray alloc] init];
    self.featuresList = [[NSArray alloc] init];
    self.activities = [[NSArray alloc] init];

    AXMoodRecommendationModel *recModel = [AXMoodRecommendationModel new];
    for (int i = 0; i < recModel.recommendationObjects.count; i++) {
//        [self setModelInfo: [self findModelActivity:recModel.activityID]: self.firstMood];
    }

    for (int i = 0; i < self.moods.count; i++) {
        [self queryForFilteredActivities:self.moods[i]];
    }
    
    for (int i = 0; i < self.filteredActivities.count; i++) {
        if ((int)(self.filteredActivities[i][1]) > 4) {
            [self.recomendedActivities addObject:self.filteredActivities[i][0]];
        }
    }
}

- (void)queryForFilteredActivities: (NSString *)mood {
    PFQuery *query = [PFQuery queryWithClassName:@"Activities_Featuers"];
    
    [query whereKey:@"emotionTags" equalTo:self.moods.firstObject];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            self.activities = objects;
            self.coreMatchesList = objects[0][@"coreMatches"];
            self.featuresList = objects[0][@"features"];
            
            for (PFObject *object in objects) {
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                int tempCount = 0;
                for (int i = 0; i < self.coreMatchesList.count; i++) {
                    if ([object[self.coreMatchesList[i]] isEqual:self.coreMatches[i]]) {
                        tempCount += 1;
                    }
                }
                if (tempCount == self.coreMatches.count) {
                    for (int i = 0; i < self.features.count; i++) {
                        NSNumber *similaritiesCount = @0;
                        if ([object[self.features[i]] isEqual:self.features[i]]) {
                            similaritiesCount = [NSNumber numberWithInt:[similaritiesCount intValue] + 1];
                        }
                        [temp addObject:object[@"activity"]];
                        [temp addObject:similaritiesCount];
                        [self.filteredActivities addObject:temp];
                    }
                }
            }
        } else {
            NSLog(@"%@", error); // will change to an alert later
        }
    }];
}

- (void)setModelInfo:(NSString *)modelId mood:(NSString *)mood {

    PFQuery *query = [PFQuery queryWithClassName:@"Activities_Featuers"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            for (PFObject *object in objects) {
                
                self.coreMatchesList = object[@"coreMatches"];
                self.featuresList = object[@"features"];
                
                if ([modelId isEqualToString:@"N/A"]) {
                    for (int i = 0; i < self.coreMatchesList.count; i++) {
                        [self.coreMatches addObject:@1];
                    }
                    for (int i = 0; i < self.featuresList.count; i++) {
                        [self.features addObject:@1];
                    }
                    break;
                } else if ([object.objectId isEqualToString:self.moodRecommendations.firstObject.activityID]) {
                    for (int i = 0; i < self.coreMatchesList.count; i++) {
                        [self.coreMatches addObject:self.coreMatchesList[i]];
                    }
                    for (int i = 0; i < self.featuresList.count; i++) {
                        [self.features addObject:object[self.featuresList[i]]];
                    }
                    break;
                }
            }
        } else {
            NSLog(@"%@", error); // will change to an alert later
        }
    }];
}

- (NSString *)findModelActivity:(NSArray *)activities {
    NSString *modelId = [[NSString alloc] init];
    NSNumber *modelCount = 0;
    
    if (activities.count == 0) { // no recommendations were given before
        modelId = @"N/A";
    } else {
        for (int i = 0; i < activities.count; i++) {
            if (activities[i][3] > [modelCount intValue]) {
                modelId = activities[i][0];
                NSLog(@"%@", modelId);
            }
        }
    }
    return modelId;
}

- (NSString *)arrayName:(NSString *)mood {
    NSString *arrayName = [[NSString alloc] init];
    arrayName = @"activitiesRecommendedHappy";
    
    if ([mood isEqualToString:@"Angry"]) {
        arrayName = @"activitiesRecommendedAngry";
    } else if ([mood isEqualToString:@"Fear"]) {
        arrayName = @"activitiesRecommendedFear";
    } else if ([mood isEqualToString:@"Sad"]) {
        arrayName = @"activitiesRecommendedSad";
    } else if ([mood isEqualToString:@"Surprise"]) {
        arrayName = @"activitiesRecommendedSurprise";
    }
    
    return arrayName;
}

@end
