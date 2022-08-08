//
//  MoodDetection.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/15/22.
//

#import "MoodDetection.h"

@interface MoodDetection ()

@property (strong, nonatomic) NSMutableArray *userTextWords;
@property (strong, nonatomic) NSDictionary *moodAPIResponse;

@end

@implementation MoodDetection

- (void)detectMood:(NSString *)userText {
    
//    // Create the request.
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.apilayer.com/text_to_emotion"]];
//
//    // Specify that it will be a POST request
//    [request setHTTPMethod:@"POST"];
//
//    // sets the header fields
//    [request setValue:@"Dh9vQhEuwQ8QSnCu1KBkLRQZhi7Qkbyu" forHTTPHeaderField:@"apikey"];
//
//    NSData *requestBodyData = [userText dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:requestBodyData];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if(httpResponse.statusCode == 200) {
//            NSError *parseError = nil;
//            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//            NSLog(@"The response is - %@",responseDictionary);
//            NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
//            if(success == 1) {
//                NSLog(@"Login SUCCESS");
//                self.moodAPIResponse = responseDictionary;
//            } else {
//                NSLog(@"Login FAILURE");
//            }
//        } else {
//            NSLog(@"Error");
//        }
//    }];
//
//    [dataTask resume];
//    NSLog(@"hello");
//    NSLog(@"%@", self.moodAPIResponse);
    
    self.firstMood = @"Sad";
    self.secondMood = @"Happy";
    self.thirdMood = @"Angry";
    
    // figures out the users mood based on what the api returns
//    self.firstMood = [self findMood:@"" : @""];
//    self.secondMood = [self findMood:self.firstMood : @""];
//    self.thirdMood = [self findMood:self.firstMood : self.secondMood];

//    NSLog(@"%@", self.firstMood);
//    NSLog(@"%@", self.secondMood);
//    NSLog(@"%@", self.thirdMood);
}

-(NSString *)findMood:(NSString *)firstExceptionMood : (NSString *)secondExceptionMood {
    NSString *mood = [[NSString alloc] init];
    int highestMoodCount = 0;
    
    for(id key in self.moodAPIResponse){
        if([self.moodAPIResponse[key] intValue] >= highestMoodCount && ![key isEqualToString:firstExceptionMood] && ![key isEqualToString:secondExceptionMood]){
            mood = key;
            highestMoodCount = [[self.moodAPIResponse objectForKey:key] intValue];
        }
    }
    return mood;
}

@end
