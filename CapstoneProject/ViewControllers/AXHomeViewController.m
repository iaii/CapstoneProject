//
//  HomeViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import "AXHomeViewController.h"
#import <Parse/Parse.h>
#include <stdlib.h>
#import "AXMoodDetection.h"
#import "AXActivityRecViewController.h"

@interface AXHomeViewController ()

- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapGetActivity:(id)sender;

@end

@implementation AXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapGetActivity:(id)sender {
    AXMoodDetection *moodDectertor = [[AXMoodDetection alloc]init];
    
    [moodDectertor detectMood:_userInput.text];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AXActivityRecViewController *activityRecViewController = [storyboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
    activityRecViewController.moodDectetor = moodDectertor;
    
    [self.navigationController pushViewController:activityRecViewController animated:YES];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }];
}

@end
