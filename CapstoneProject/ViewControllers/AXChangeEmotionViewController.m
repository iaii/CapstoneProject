//
//  ChangeEmotionViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/29/22.
//

#import "AXChangeEmotionViewController.h"
#import "AXActivityRecommendation.h"
#import <Parse/Parse.h>

@interface AXChangeEmotionViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *moodPicker;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (strong, nonatomic) NSArray *moodsToChooseFrom;
@property (strong, nonatomic) NSString *chosenMood;

- (IBAction)didTapChangeEmotionButton:(id)sender;

@end

@implementation AXChangeEmotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moodPicker.dataSource = self;
    self.moodPicker.delegate = self;
    
    self.activity.text = self.activityName;
    
    self.moodsToChooseFrom = @[@"Happy", @"Sad", @"Angry", @"Fear", @"Surprise"];
    self.chosenMood = self.moodsToChooseFrom[0];
}

#pragma picker methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.moodsToChooseFrom.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.moodsToChooseFrom[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.chosenMood = self.moodsToChooseFrom[row];
}

#pragma private methods
- (IBAction)didTapChangeEmotionButton:(id)sender {
    [self changeFirstEmotionInDatabase];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeFirstEmotionInDatabase {
    PFQuery *query = [PFQuery queryWithClassName:@"Activities"];
    [query getObjectInBackgroundWithId:self.activityObjectId block:^(PFObject *activities, NSError *error) {
        activities[@"firstEmotionTag"] = self.chosenMood;
        [activities saveInBackground];
    }];
}

@end
