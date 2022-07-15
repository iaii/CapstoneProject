//
//  CustomeActivityViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import "CustomeActivityViewController.h"

@interface CustomeActivityViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *costumeAcitvityInput;
@property (weak, nonatomic) IBOutlet UIPickerView *moodPicker;
@property (strong, nonatomic) NSArray *moodsToChooseFrom;
@property (strong, nonatomic) NSString *chosenMood;

@end

@implementation CustomeActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moodPicker.dataSource = self;
    self.moodPicker.delegate = self;
    
    self.moodsToChooseFrom = @[@"Happy", @"Sad", @"Mad"];
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
@end
