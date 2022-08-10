//
//  DisplayActivityViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/14/22.
//

#import "AXDisplayActivityViewController.h"
#import "AXMoodDetection.h"
#import <Parse/Parse.h>

@interface AXDisplayActivityViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayActivityText;

@end

@implementation AXDisplayActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayActivityText.text = self.activity;
}

@end
