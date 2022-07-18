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

- (void) initializer{
    
    NSArray *sadKeyWords = @[@"sad", @"down", @"terrible", @"depressed"];
    NSArray *boredKeyWords = @[@"bored", @"ok", @"tired", @"sleepy"];
    NSArray *happyKeyWords = @[@"happy", @"great", @"esstatic", @"excited"];
    NSArray *angryKeyWords = @[@"angry", @"mad", @"upset"];
    
    
    self.stopWordsForMoods = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  sadKeyWords,    @"sad",
                              boredKeyWords,  @"bored",
                              happyKeyWords, @"happy",
                              angryKeyWords, @"angry",
                              nil
    ];
    
    self.moodCount = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      [NSNumber numberWithInt:0], @"sad",
                      [NSNumber numberWithInt:0], @"bored",
                      [NSNumber numberWithInt:0], @"happy",
                      [NSNumber numberWithInt:0], @"angry",
                      nil];
}

- (NSString *) detectMood:(NSString *) userText{
    
    [self initializer];
    
    NSArray * userTextWords = [userText componentsSeparatedByString:@" "];
    
    // counts how many times a key word/ associated word comes up
    
    for(int i = 0; i < userTextWords.count; i++){
        if([[userTextWords objectAtIndex:i] isEqual:[_stopWordsForMoods objectForKey:@"sad"]]) {
            NSNumber *sadCountIncremented = [NSNumber numberWithInt:[[_moodCount objectForKey:@"sad"] intValue] + 1];
            [_moodCount setObject:sadCountIncremented forKey: @"sad"];
        }else if([[userTextWords objectAtIndex:i] isEqual:[_stopWordsForMoods objectForKey:@"bored"]]) {
            NSNumber *sadCountIncremented = [NSNumber numberWithInt:[[_moodCount objectForKey:@"bored"] intValue] + 1];
            [_moodCount setObject:sadCountIncremented forKey: @"bored"];
        }else   if([[userTextWords objectAtIndex:i] isEqual:[_stopWordsForMoods objectForKey:@"happy"]]) {
            NSNumber *sadCountIncremented = [NSNumber numberWithInt:[[_moodCount objectForKey:@"happy"] intValue] + 1];
            [_moodCount setObject:sadCountIncremented forKey: @"happy"];
        }else if([[userTextWords objectAtIndex:i] isEqual:[_stopWordsForMoods objectForKey:@"angry"]]) {
            NSNumber *sadCountIncremented = [NSNumber numberWithInt:[[_moodCount objectForKey:@"angry"] intValue] + 1];
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
