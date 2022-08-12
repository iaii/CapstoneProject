//
//  RecommendationEngine.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/5/22.
//

#import "RecommendationEngine.h"
#import <Parse/Parse.h>

@interface RecommendationEngine ()

@property (strong, nonatomic) NSArray *userObjects;
@property (strong, nonatomic) NSDictionary *moodAPIResponse;
@property (strong, nonatomic) NSArray *firstMoodArray;
@property (strong, nonatomic) NSArray *secondMoodArray;
@property (strong, nonatomic) NSArray *thirdMoodArray;

@property (strong, nonatomic) NSArray *activities;
@property (strong, nonatomic) NSArray *coreMatches;
@property (strong, nonatomic) NSArray *features;

@property (strong, nonatomic) NSString *firstModelActivityId;
@property (strong, nonatomic) NSString *secondModelActivityId;
@property (strong, nonatomic) NSString *thirdModelActivityId;

@property (strong, nonatomic) NSMutableArray *filteredActivities;

@property (strong, nonatomic) NSArray *firstModelArray;
@property (strong, nonatomic) NSArray *secondModelArray;
@property (strong, nonatomic) NSArray *thirdModelArray;


@end

@implementation RecommendationEngine

-(void)queryActivities:(NSString *)columnName : (NSString *)moodName : (NSNumber *)score {
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query whereKey:columnName equalTo: moodName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            for(PFObject *object in objects) {
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                [temp addObject:object.objectId];
                [temp addObject:object[@"activity"]];
                [temp addObject:score];
                [temp addObject:object];
                //  [self.recActivities addObject:temp];
            }
            // [self.tableView reloadData];
        } else {
            NSLog(@"%@", error); // will change to an alert later
        }
    }];
}

// gets the user's model activities
-(void)getUserInfo {
    //    //PFQuery *query = [PFQuery queryWithClassName:@"User_Preferences"];
    //    PFQuery *query = [PFUser query];
    //    //[query whereKey:@"gender" equalTo:@"female"]; // find all the women
    //    NSArray *girls = [query findObjects];
    //
    //
    //    //NSString *str = currentUser.objectId;
    //  //  [query whereKey:@"userObjectId" equalTo:currentUser.objectId];
    //
    //    //[query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
    //                                            //  NSError * _Nullable error) {
    //        if (currentUser) { // this should always be true and there should only be 1 object because the user has to be logined to view this data //and there can only be unique users
    //           // for(PFObject *object in objects) {
    //                self.userObjects = currentUser;
    //
    //                NSString *firstName = [self returnArrayName:self.firstMood];
    //                self.firstMoodArray = currentUser[@firstName];
    //
    //                NSString *secondName = [self returnArrayName:self.secondtMood];
    //                self.secondMoodArray = currentUser[secondName];
    //
    //                NSString *thirdName = [self returnArrayName:self.thirdMood];
    //                self.thirdMoodArray = currentUser[thirdName];
    //           // }
    //        } else {
    //           // NSLog(@"%@", error); // will change to an alert later
    //        }
    //  //  }];
    
    
//    PFUser *user = [PFUser currentUser];
//    PFQuery *query = [PFQuery queryWithClassName:@"User_Preferences"];
//    [query whereKey:@"userObjectID" equalTo:user];
//    self.userObjects = [query findObjects];
//    NSLog(@"%@", self.userObjects);
//    NSLog(@"%lu", (unsigned long)self.userObjects.count);
    
    self.firstMoodArray = [[NSArray alloc] init];
    self.secondMoodArray = [[NSArray alloc] init];
    self.thirdMoodArray = [[NSArray alloc] init];

        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        PFUser *user = [PFUser currentUser];
    ///[query whereKey:@"gender" equalTo:@"female"]; // find all the women
       // NSArray *girls = [query findObjects];
    
    
        //NSString *str = currentUser.objectId;
        [query whereKey:@"objectId" equalTo:[user objectId]];
    
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                                  NSError * _Nullable error) {
            if (objects) { // this should always be true and there should only be 1 object because the user has to be logined to view this data //and there can only be unique users
                for(PFObject *object in objects) {
                    self.userObjects = objects;
    
                    NSString *firstName = [self returnArrayName:self.firstMood];
                    self.firstMoodArray = object[firstName];
    
                    NSString *secondName = [self returnArrayName:self.secondtMood];
                    self.secondMoodArray = object[secondName];
    
                    NSString *thirdName = [self returnArrayName:self.thirdMood];
                    self.thirdMoodArray = object[thirdName];
                }
                [self useArray];
            }
            else {
               // NSLog(@"%@", error); // will change to an alert later
            }
        }];
    

//    PFUser *user = [PFUser currentUser];
//
//
//    NSString *firstName = [self returnArrayName:self.firstMood];
//    self.firstMoodArray = [firstName];
//
//    NSString *secondName = [self returnArrayName:self.secondtMood];
//    self.secondMoodArray = user[secondName];
//
//    NSString *thirdName = [self returnArrayName:self.thirdMood];
//    self.thirdMoodArray = user[thirdName];
    
    
    // find the model activities for each mood
    
}

-(void)useArray{
 
    
    //counts the number of similarities
    [self setActivities];
    
    
}

-(void)setActivities {
    NSString *firstModelActivityId = [self findModelActivity:self.firstMoodArray];
    NSString *secondModelActivityId = [self findModelActivity:self.secondMoodArray];
    NSString *thirdModelActivityId = [self findModelActivity:self.thirdMoodArray];
    
    
    self.coreMatches = [[NSArray alloc] init];
    self.features = [[NSArray alloc] init];
    self.activities = [[NSArray alloc] init];
    
    self.firstModelArray = [[NSArray alloc] init];
    self.secondModelArray = [[NSArray alloc] init];
    self.thirdModelArray = [[NSArray alloc] init];


    
    [self setModelInfo: firstModelActivityId: self.firstMood];
    [self setModelInfo: secondModelActivityId: self.secondtMood];
    [self setModelInfo: thirdModelActivityId : self.thirdMood];

    // first emotion
    PFQuery *query = [PFQuery queryWithClassName:@"Activities_Featuers"];
    
    [query whereKey:@"emotionTags" equalTo:self.firstMood];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            self.activities = objects;
//            self.coreMatches = objects[0][@"coreMatches"];
//            self.features = objects[0][@"features"];
            
//            for (PFObject *object in objects) {
//                if (![firstModelActivityId isEqualToString:@"N/A"] && ![object.objectId isEqualToString: firstModelActivityId]) { // first activity
//                    if ([object[@"tod"] isEqual: self.firstModelArray[0]] && [object[@"age"] isEqual: self.firstModelArray[1]]) {
//                        for (int i = 0; i < self.features.count; i++) {
//                            if (object[self.features[i]] isEqual:<#(id)#>) {
//
//                            }
//                        }
//                    }
//                }
//            }
//        } else {
//            NSLog(@"%@", error); // will change to an alert later
        }
    }];
}

-(NSMutableArray *)setModelInfo: (NSString *)modelId : (NSString *)mood{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    if (![modelId isEqualToString:@"N/A"]) {
        PFQuery *query = [PFQuery queryWithClassName:@"Activities_Featuers"];
                
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                                  NSError * _Nullable error) {
            if (objects) {
                for (PFObject *object in objects) {
                    self.features = object[@"features"];
                    if ([modelId isEqualToString:@"N/A"]) {
                        [temp addObject: @0];
                        [temp addObject: @0];
                        break;
                    } else if ([object.objectId isEqualToString: self.firstModelActivityId]) {
                        [temp addObject: object[@"tod"]];
                        [temp addObject: object[@"age"]];
                        break;
                    }
                }
            } else {
                NSLog(@"%@", error); // will change to an alert later
            }
        }];
    }
    return temp;
}

-(NSString *)findModelActivity: (NSArray *)activites{
    NSString *modelId = [[NSString alloc] init];
    NSNumber *modelCount = 0;
    
    if (activites.count == 0) { // no recommendations were given before
        modelId = @"N/A";
    } else {
        for (int i = 0; i < activites.count; i++) {
            if (activites[i][3] > [modelCount intValue]) {
                modelId = activites[i][0];
                NSLog(@"%@", modelId);
            }
        }
    }
    return modelId;
}

-(NSString *)returnArrayName: (NSString *)mood{
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
