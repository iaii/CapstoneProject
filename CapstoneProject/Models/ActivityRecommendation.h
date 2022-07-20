//
//  ActivityRec.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityRecommendation: PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *Activity;
@property (strong, nonatomic) NSString *EmotionTag;

+ (void) postNewActivity: (NSString * _Nullable )activity withMood: (NSString * _Nullable )mood withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
