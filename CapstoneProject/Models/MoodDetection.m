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
        
        
        self.stopWordsForMoods =  @{@"sad": sadKeyWords, @"bored": boredKeyWords, @"happy": happyKeyWords, @"angry": angryKeyWords};
        
        self.moodCount = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                          @"sad", @0,
                          @"bored", @0,
                          @"happy", @0,
                          @"angry", @0,
                          nil];
    }
    
    return self;
}

- (void)detectMood:(NSString *)userText {
    
    NSArray *userTextWords = [userText componentsSeparatedByString:@" "];
    
    // counts how many times a key word/ associated word comes up
    
    for (NSString *userTextWord in userTextWords) {
        if ([_stopWordsForMoods[@"sad"] containsObject: userTextWord.lowercaseString]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"sad"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"sad"];
        }else if ([_stopWordsForMoods[@"bored"] containsObject: userTextWord.lowercaseString]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"bored"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"bored"];
        }else if ([_stopWordsForMoods[@"happy"] containsObject: userTextWord.lowercaseString]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"happy"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"happy"];
        }else if ([_stopWordsForMoods[@"angry"] containsObject: userTextWord.lowercaseString]) {
            NSNumber *sadCountIncremented = @([_moodCount[@"angry"] intValue] + 1);
            [_moodCount setObject:sadCountIncremented forKey: @"angry"];
        }
    }
    
    // compares which mood
    
    _mood = @"angry";
    
    if([_moodCount objectForKey:@"happy"] >= [_moodCount objectForKey:@"sad"] && [_moodCount objectForKey:@"happy"] >= [_moodCount objectForKey:@"bored"] && [_moodCount objectForKey:@"happy"] >= [_moodCount objectForKey:@"angry"]) {
        _mood = @"happy";
    }else if([_moodCount objectForKey:@"sad"] >= [_moodCount objectForKey:@"happy"] && [_moodCount objectForKey:@"sad"] >= [_moodCount objectForKey:@"bored"] && [_moodCount objectForKey:@"sad"] >= [_moodCount objectForKey:@"angry"]) {
        _mood = @"sad";
    }else if([_moodCount objectForKey:@"bored"] >= [_moodCount objectForKey:@"sad"] && [_moodCount objectForKey:@"bored"] >= [_moodCount objectForKey:@"happy"] && [_moodCount objectForKey:@"bored"] >= [_moodCount objectForKey:@"angry"]) {
        _mood = @"bored";
    }
}

@end
