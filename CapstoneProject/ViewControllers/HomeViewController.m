//
//  HomeViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "MoodDetection.h"

@interface HomeViewController ()
- (IBAction)didTapLogout:(id)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)didTapGetActivity:(id)sender {
    MoodDetection *moodDectertor = [[MoodDetection alloc]init];
    
    [moodDectertor detectMood:_userInput.text];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }];
}
@end
