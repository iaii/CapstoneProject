//
//  HomeViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import "AXHomeViewController.h"
#import <Parse/Parse.h>
#include <stdlib.h>
#import "MoodDetection.h"
#import "ActivityRecViewController.h"

@interface AXHomeViewController ()
- (IBAction)didTapLogout:(id)sender;

@end

@implementation AXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapGetActivity:(id)sender {
    MoodDetection *moodDectertor = [[MoodDetection alloc]init];
    
    [moodDectertor detectMood:_userInput.text];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ActivityRecViewController *activityRecViewController = [storyboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
    activityRecViewController.moodDectetor = moodDectertor;
    self.view.window.rootViewController = activityRecViewController;
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }];
}

@end
