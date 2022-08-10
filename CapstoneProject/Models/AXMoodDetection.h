//
//  MoodDetection.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/15/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMoodDetection : NSObject

@property (strong, nonatomic) NSDictionary *stopWordsForMoods;
@property (strong, nonatomic) NSMutableDictionary *moodCount;
@property (strong, nonatomic, readonly) NSString *mood;
@property (strong, nonatomic) NSString *firstMood;
@property (strong, nonatomic) NSString *secondMood;
@property (strong, nonatomic) NSString *thirdMood;

- (void)detectMood:(NSString *)userText;

@end

NS_ASSUME_NONNULL_END
