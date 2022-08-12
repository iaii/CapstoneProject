//
//  AXAnimationHelper.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/12/22.
//

#import "AXAnimationHelper.h"

@implementation HappyAnimationDestination

@end

@implementation SadAnimationDestination

@end

@implementation AXAnimationHelper

+ (HappyAnimationDestination *)generateHappyDestination {
    HappyAnimationDestination *destination = [HappyAnimationDestination new];

    if (arc4random_uniform(2) == 0) {
        destination.x = -arc4random_uniform(100);
        destination.y = arc4random_uniform(500);
    } else {
        destination.x = arc4random_uniform(500);
        destination.y = -arc4random_uniform(100);
    }

    return destination;
}

+ (SadAnimationDestination *)generateSadDestination {
    SadAnimationDestination *destination = [SadAnimationDestination new];

    if (arc4random_uniform(2) == 0) {
        destination.x = -arc4random_uniform(100);
        destination.y = arc4random_uniform(500);
    } else {
        destination.x = arc4random_uniform(500);
        destination.y = -arc4random_uniform(100);
    }

    return destination;
}

@end
