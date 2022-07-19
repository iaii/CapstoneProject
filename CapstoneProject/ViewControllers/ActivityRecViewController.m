//
//  ActivityRecViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/13/22.
//

#import "ActivityRecViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityRecommendation.h"
#import "MoodDetection.h"
#import <Parse/Parse.h>

@interface ActivityRecViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)didTapChooseCustomeAct:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *activityRecommendationText;

@end

@implementation ActivityRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)queryActivities {
    PFQuery *query = [PFQuery queryWithClassName:@"Activities"];
    
    MoodDetection *moodDectertor = [[MoodDetection alloc]init];
    
    NSString *mood = [moodDectertor getMood];
    
    [query includeKey:mood];
    
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
    ActivityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"activityCell" forIndexPath:indexPath];
    
    //    ActivityRec *rec = self.posts[indexPath.section]; --> will be implemented for next push
    //
    //    cell.post = post;
    //
    //    cell.author.text = post[@"author"][@"username"];
    //    cell.caption.text = post[@"caption"];
    //    cell.likeCount.text = [NSString stringWithFormat:@"%@", post[@"likeCount"]];
    //    cell.commentCount.text = [NSString stringWithFormat:@"%@", post[@"commentCount"]];
    //
    //    cell.image.file = post[@"image"];
    //    [cell.image loadInBackground];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (IBAction)didTapChooseCustomeAct:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomeActivityViewController"];
}
@end
