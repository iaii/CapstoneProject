//
//  ChangeEmotionViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/29/22.
//

#import "ChangeEmotionViewController.h"
#import "ActivityRecommendation.h"
#import <Parse/Parse.h>

@interface ChangeEmotionViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *moodPicker;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (strong, nonatomic) NSArray *moodsToChooseFrom;
@property (strong, nonatomic) NSString *chosenMood;

- (IBAction)didTapChangeEmotionButton:(id)sender;

@end

@implementation ChangeEmotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moodPicker.dataSource = self;
    self.moodPicker.delegate = self;
    
    self.activity.text = self.activityName;
    
    self.moodsToChooseFrom = @[@"Happy", @"Sad", @"Angry", @"Fear", @"Surprise"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.moodsToChooseFrom.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.moodsToChooseFrom[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.chosenMood = self.moodsToChooseFrom[row];
}

- (IBAction)didTapChangeEmotionButton:(id)sender {
    [self changeFirstEmotionInDatabase];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
}

- (void)changeFirstEmotionInDatabase {
    PFQuery *query = [PFQuery queryWithClassName:@"Activities"];
    
  //   Retrieve the object by id
    [query getObjectInBackgroundWithId:self.activityObjectId block:^(PFObject *activities, NSError *error) {

//        activities[@"firstEmotionTag"] = self.chosenMood;
//        activities.f
//
        [activities saveInBackground];
    }];

}
@end
