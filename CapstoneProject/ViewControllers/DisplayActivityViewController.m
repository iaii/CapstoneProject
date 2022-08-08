//
//  DisplayActivityViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import "DisplayActivityViewController.h"
#import "MoodDetection.h"
#import <Parse/Parse.h>

@interface DisplayActivityViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayActivityText;
@end

@implementation DisplayActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayActivityText.text = self.activity;
    
}

@end
