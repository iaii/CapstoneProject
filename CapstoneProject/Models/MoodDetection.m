//
//  MoodDetection.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/15/22.
//

#import "MoodDetection.h"

@interface MoodDetection ()

@property (strong, nonatomic) NSMutableArray *userTextWords;

@end

@implementation MoodDetection

- (instancetype)init {
    if (self = [super init]) {
        NSArray *sadKeyWords = @[@"sad", @"down", @"terrible", @"depressed"];
        NSArray *boredKeyWords = @[@"bored", @"ok", @"tired", @"sleepy"];
        NSArray *happyKeyWords = @[@"happy", @"great", @"esstatic", @"excited"];
        NSArray *angryKeyWords = @[@"angry", @"mad", @"upset"];
        
        
        self.stopWordsForMoods =  @{sadKeyWords: @"sad", boredKeyWords: @"bored", happyKeyWords: @"happy", angryKeyWords: @"angry"};
        
        self.moodCount = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                          @0, @"sad",
                          @0, @"bored",
                          @0, @"happy",
                          @0, @"angry",
                          nil];
    }
    
    return self;
}

- (NSString *)detectMood:(NSString *)userText{
    
    NSArray *userTextWords = [userText componentsSeparatedByString:@" "];
    
    // counts how many times a key word/ associated word comes up
    
    for (NSString *userTextWord in userTextWords) {
        if ([userTextWord isEqual:_stopWordsForMoods[@"sad"]]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"sad"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"sad"];
        }else if ([userTextWord isEqual:_stopWordsForMoods[@"bored"]]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"bored"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"bored"];
        }else if ([userTextWord isEqual:_stopWordsForMoods[@"happy"]]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"happy"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"happy"];
        }else if ([userTextWord isEqual:_stopWordsForMoods[@"angry"]]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"angry"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"angry"];
        }
    }
    
    // compares which mood
    
    NSString *returnMood = @"angry";
    
    if([_moodCount objectForKey:@"happy"] >= [_moodCount objectForKey:@"sad"] && [_moodCount objectForKey:@"happy"] >= [_moodCount objectForKey:@"bored"] && [_moodCount objectForKey:@"happy"] >= [_moodCount objectForKey:@"angry"]) {
        returnMood = @"happy";
    }else if([_moodCount objectForKey:@"sad"] >= [_moodCount objectForKey:@"happy"] && [_moodCount objectForKey:@"sad"] >= [_moodCount objectForKey:@"bored"] && [_moodCount objectForKey:@"sad"] >= [_moodCount objectForKey:@"angry"]) {
        returnMood = @"sad";
    }else if([_moodCount objectForKey:@"bored"] >= [_moodCount objectForKey:@"sad"] && [_moodCount objectForKey:@"bored"] >= [_moodCount objectForKey:@"happy"] && [_moodCount objectForKey:@"bored"] >= [_moodCount objectForKey:@"angry"]) {
        returnMood = @"bored";
    }
    
    return returnMood;
}


@end
