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
@property (weak, nonatomic) IBOutlet UILabel *moodText;
@property (strong, nonatomic) NSString *moodDetected;

@end

@implementation DisplayActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MoodDetection *moodDectertor = [[MoodDetection alloc]init];
    
    _moodDetected = [moodDectertor getMood];
    _moodText.text = _moodDetected;

}

-(void)queryPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Activity"];
                       
    [query includeKey:_moodDetected];

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
        NSError * _Nullable error) {
        if (objects) {
//            self.posts = objects;
//            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error);
        }
    }];
}

@end
