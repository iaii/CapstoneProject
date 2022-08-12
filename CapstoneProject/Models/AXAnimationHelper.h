//
//  AXAnimationHelper.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HappyAnimationDestination : NSObject

@property (nonatomic) int x;
@property (nonatomic) int y;

@end

@interface SadAnimationDestination : NSObject

@property (nonatomic) int x;
@property (nonatomic) int y;

@end

@interface AXAnimationHelper : NSObject

+ (HappyAnimationDestination *)generateHappyDestination;
+ (SadAnimationDestination *)generateSadDestination;

@end

NS_ASSUME_NONNULL_END
