//
//  CustomeActivityViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import "AXAddActivityViewController.h"
#import "AXActivityRecommendation.h"

@interface AXAddActivityViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *costumeAcitvityInput;
@property (weak, nonatomic) IBOutlet UIPickerView *moodPicker;
@property (strong, nonatomic) NSArray *moodsToChooseFrom;
@property (strong, nonatomic) NSString *chosenMood;

- (IBAction)didTapAddActivity:(id)sender;

@end

@implementation AXAddActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moodPicker.dataSource = self;
    self.moodPicker.delegate = self;
    
    self.moodsToChooseFrom = @[@"Happy", @"Sad", @"Angry", @"Fear", @"Surprise"];
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
- (IBAction)didTapAddActivity:(id)sender {
    if (![self.chosenMood isEqualToString:@""] && ![self.costumeAcitvityInput.text isEqualToString:@""]) {
        [AXActivityRecommendation postNewActivity:self.costumeAcitvityInput.text
                                             mood:self.chosenMood
                                       completion:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"DisplayActivityViewController"];
            }
        }];
    }
}

@end
