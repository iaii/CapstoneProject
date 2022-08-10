//
//  ActivityRec.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXActivityRecommendation: PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *activity;
@property (strong, nonatomic) NSString *mood;

+ (void)postNewActivity:(NSString * _Nullable )activity
                   mood:(NSString * _Nullable)mood
             completion:(PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
