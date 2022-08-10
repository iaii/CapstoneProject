//
//  MoodDetection.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/15/22.
//

#import "AXMoodDetection.h"

@interface AXMoodDetection ()

@property (strong, nonatomic) NSMutableArray *userTextWords;
@property (strong, nonatomic) NSDictionary *moodAPIResponse;

- (NSString *)findMood:(NSString *)firstExceptionMood secondExceptionMood:(NSString *)secondExceptionMood;

@end

@implementation AXMoodDetection

- (void)detectMood:(NSString *)userText {
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.apilayer.com/text_to_emotion"]];

    // Specify that it will be a POST request
    [request setHTTPMethod:@"POST"];

    // sets the header fields  Dh9vQhEuwQ8QSnCu1KBkLRQZhi7Qkbyu
    [request setValue:@"4kMhxpBAYWMc6OEWXWJ2eB8iQyyHGcQ3" forHTTPHeaderField:@"apikey"];

    NSData *requestBodyData = [userText dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBodyData];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
            if(success == 1) {
                NSLog(@"Login SUCCESS");
                self.moodAPIResponse = responseDictionary;
                
                self.firstMood = @"Sad";
                self.secondMood = @"Happy";
                self.thirdMood = @"Angry";
                
                // figures out the users mood based on what the api returns
                self.firstMood = [self findMood:@"" secondExceptionMood: @""];
                self.secondMood = [self findMood:self.firstMood secondExceptionMood: @""];
                self.thirdMood = [self findMood:self.firstMood secondExceptionMood: self.secondMood];

            } else {
                NSLog(@"Login FAILURE");
            }
        } else {
            NSLog(@"Error");
        }
    }];

    [dataTask resume];
}

- (NSString *)findMood:(NSString *)firstExceptionMood secondExceptionMood:(NSString *)secondExceptionMood {
    NSString *mood;
    NSInteger highestMoodCount = NSIntegerMin;
    
    for (id key in self.moodAPIResponse) {
        NSInteger count = [self.moodAPIResponse[key] integerValue];
        if (count >= highestMoodCount
            && ![key isEqualToString:firstExceptionMood]
            && ![key isEqualToString:secondExceptionMood]) {
            mood = key;
            highestMoodCount = count;
            
        }
    }
    
    return mood;
}

@end
