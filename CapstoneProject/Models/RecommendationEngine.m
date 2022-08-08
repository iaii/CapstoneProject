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
    PFQuery *query = [PFQuery queryWithClassName:@"User_Preferences"];
    PFUser *currentUser = [PFUser currentUser];
    
    [query whereKey:@"userObjectId" equalTo:currentUser[@"objecId"]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            self.userObjects = objects;
            NSString *name = [self returnArrayName:self.firstMood];
            //self.firstMoodArray = objects.obj;
            
        } else {
            NSLog(@"%@", error); // will change to an alert later
        }
    }];
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
