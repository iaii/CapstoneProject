//
//  ActivityRecViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/13/22.
//

#import "ActivityRecViewController.h"
#import "ActivityRecommendationTableViewCell.h"
#import "ActivityRecommendation.h"
#import "MoodDetection.h"
#import <Parse/Parse.h>

@interface ActivityRecViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *mood;
- (IBAction)didTapChooseCustomeAct:(id)sender;

@end

@implementation ActivityRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self queryActivities];
}

-(void)queryActivities {
    PFQuery *query = [ActivityRecommendation query];
    _mood = [self.moodDectetor mood];
    
    [query whereKey:@"EmotionTag" equalTo:_mood];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            self.recActivities = objects;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ActivityRecommendationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"activityCell" forIndexPath:indexPath];
    
    [cell setUpActivity:_recActivities[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recActivities.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (IBAction)didTapChooseCustomeAct:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomeActivityViewController"];
}

@end
