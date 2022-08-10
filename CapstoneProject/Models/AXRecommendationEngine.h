//
//  RecommendationEngine.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXRecommendationEngine : NSObject

//@property (strong, nonatomic) NSString *firstMood;
//@property (strong, nonatomic) NSString *secondtMood;
//@property (strong, nonatomic) NSString *thirdMood;

@property (strong, nonatomic) NSArray<NSString *> *moods;

- (void)getUserInfo;

@end

NS_ASSUME_NONNULL_END
