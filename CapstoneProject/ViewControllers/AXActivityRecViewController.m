//
//  ActivityRecViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/13/22.
//

#import "AXActivityRecViewController.h"
#import "AXActivityRecommendationTableViewCell.h"
#import "AXActivityRecommendation.h"
#import "AXMoodDetection.h"
#import "AXChangeEmotionViewController.h"
#import "AXDisplayActivityViewController.h"
#import <Parse/Parse.h>
#import "AXRecommendationEngine.h"
#import "AXAnimationHelper.h"

@interface AXActivityRecViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *firstMood;
@property (strong, nonatomic) NSString *secondMood;
@property (strong, nonatomic) NSString *thirdMood;
@property (weak, nonatomic) IBOutlet UILabel *headingText;
@property (strong, nonatomic) NSMutableArray *rainDropsArray;
@property (strong, nonatomic) IBOutlet AXActivityRecView *mainView;
@property (strong, nonatomic) UILabel *rainDropScoreLabel;
@property (strong, nonatomic) NSNumber *rainDropCounter;
@property (strong, nonatomic) NSNumber *rainDropArrayCount;

- (IBAction)didTapChangeEmotion:(id)sender;
- (IBAction)didTapAddAcitivity:(id)sender;
- (IBAction)didTapSelectActivity:(id)sender;

@end

@implementation AXActivityRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 175;
    self.mainView.delegate = self;
    self.recActivities = [[NSMutableArray alloc] init];
    
    self.firstMood = [self.moodDectetor firstMood];
    self.secondMood = [self.moodDectetor secondMood];
    self.thirdMood = [self.moodDectetor thirdMood];

    self.headingText.text = @"Recommended activities";
    
    AXRecommendationEngine *rec = [[AXRecommendationEngine alloc] init];
    rec.moods = @[self.firstMood, self.secondMood, self.thirdMood];
    
    [self loadAnimations];
    [self queryActivities: @"firstEmotionTag" : self.firstMood : @4];
    [self queryActivities: @"secondEmotionTag" : self.secondMood : @3];
    [self queryActivities: @"thridEmotionTag" : self.thirdMood : @2];
}

#pragma animations
- (void) loadAnimations {
    if([self.firstMood isEqualToString:@"Happy"]) {
        [self happyAnimations];
    } else if([self.firstMood isEqualToString:@"Sad"]) {
        [self sadAnimation];
    }
}

- (void)happyAnimations {
    for(int i = 0; i < 50; i++){
        [CATransaction begin];
        UIImageView *careImage = [[UIImageView alloc] init];
        
        CGRect imageframe = careImage.frame;
        
        int size = ((int)arc4random_uniform(100) + 25);
        imageframe.size.height = size;
        imageframe.size.width = size;
        imageframe.origin = CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        careImage.frame = imageframe;
        [careImage setImage:[UIImage imageNamed:@"care"]];
        [self.view addSubview:careImage];
        careImage.layer.zPosition = MAXFLOAT;
        
        CAMediaTimingFunctionName timeFunction = kCAMediaTimingFunctionLinear;
        if (arc4random_uniform(2) == 0) {
            timeFunction = kCAMediaTimingFunctionEaseIn;
        } else {
            timeFunction = kCAMediaTimingFunctionEaseInEaseOut;
        }
        
        HappyAnimationDestination *destination = [AXAnimationHelper generateHappyDestination];
        
        NSArray *pathArray = @[[NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)], [NSValue valueWithCGPoint:CGPointMake(destination.x, destination.y)]];
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.values = pathArray;
        pathAnimation.duration = arc4random_uniform(3) + 2;
        [pathAnimation setRemovedOnCompletion:YES];
        [pathAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:timeFunction]];

        CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
        flash.fromValue = [NSNumber numberWithFloat: (float)arc4random_uniform(100)];
        flash.toValue = [NSNumber numberWithFloat: 0.0];
        flash.duration = (float)arc4random_uniform(5);
        flash.autoreverses = YES;
        [flash setRemovedOnCompletion:YES];
        
        [CATransaction setCompletionBlock:^{
            [careImage removeFromSuperview];
        }];
        
        [careImage.layer addAnimation:flash forKey:@"flashAnimation"];
        [careImage.layer addAnimation:pathAnimation forKey:@"position"];
        
        [CATransaction commit];
    }
}

- (void)sadAnimation {
    self.rainDropCounter = @0;
    self.rainDropArrayCount = @0;
    self.rainDropsArray = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setDelegate:self];
    
    
    self.rainDropScoreLabel = [[UILabel alloc] init];
    self.rainDropScoreLabel.backgroundColor = [UIColor clearColor];
    self.rainDropScoreLabel.numberOfLines = 0;
    self.rainDropScoreLabel.textColor = [UIColor whiteColor];
    
    //position label
    CGRect frame = self.rainDropScoreLabel.frame;
    frame.origin = CGPointMake((int)([UIScreen mainScreen].bounds.size.width - 75), (int)([UIScreen mainScreen].bounds.size.height - 200));
    self.rainDropScoreLabel.frame = frame;
    
    self.rainDropScoreLabel.text = [@"Score: " stringByAppendingString: [NSString stringWithFormat:@"%@", self.rainDropCounter]];
    [self.rainDropScoreLabel sizeToFit]; //set width and height of label based on text size
    [self.view addSubview:self.rainDropScoreLabel];     //add label to view
    
    self.rainDropArrayCount = [NSNumber numberWithInt:[self.rainDropArrayCount intValue] + (int)arc4random_uniform(5) + 5];
    
    for(int i = 0; i < [self.rainDropArrayCount intValue]; i++){
        [CATransaction begin];
        
        UIImageView *sadImage = [[UIImageView alloc] init];
        CGRect imageframe = sadImage.frame;
        
        sadImage.userInteractionEnabled = YES;
        
        [sadImage addGestureRecognizer:tapRecognizer];
        
        int size = ((int)arc4random_uniform(100) + 25);
        imageframe.size.height = size;
        imageframe.size.width = size;
        imageframe.origin = CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        sadImage.frame = imageframe;
        [sadImage setImage:[UIImage imageNamed:@"rain"]];
        [self.view addSubview:sadImage];
        sadImage.layer.zPosition = MAXFLOAT;
        
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"position.y";
        animation.fromValue = @-50;
        animation.toValue = @800;
        animation.duration = (int)arc4random_uniform(3) + 2;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:0.35:0.55:0.3];
        animation.beginTime = CACurrentMediaTime() + (int)arc4random_uniform(5);
        
        sadImage.animationRepeatCount = 1;
                
        sadImage.layer.position = CGPointMake((int)arc4random_uniform([UIScreen mainScreen].bounds.size.width - size) + size, [UIScreen mainScreen].bounds.size.height + size);
        
        CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
        flash.fromValue = [NSNumber numberWithFloat:1.0];
        flash.toValue = [NSNumber numberWithFloat:0.0];
        flash.duration = 7;
        flash.autoreverses = NO;
        
        [CATransaction setCompletionBlock:^{
            [sadImage removeFromSuperview];
        }];
        
        [sadImage.layer addAnimation:animation forKey:@"basic"];
        [sadImage.layer addAnimation:flash forKey:@"flashAnimation"];
        
        NSMutableArray *rainDropImageAndStatus = [[NSMutableArray alloc] init];
        [rainDropImageAndStatus addObject:sadImage];
        [rainDropImageAndStatus addObject:@0];
        [self.rainDropsArray addObject:rainDropImageAndStatus];
        
        [CATransaction commit];
    }
}

- (BOOL)activityRecViewDidhitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (NSInteger i = self.rainDropsArray.count - 1; i >= 0; i--) {
        UIImageView *imageView = self.rainDropsArray[i][0];
        if ([imageView.layer.presentationLayer hitTest:point] && [self.rainDropsArray[i][1]  isEqual: @0]) {
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            [temp addObject:imageView];
            [temp addObject:@1];
            
            imageView.alpha = 0;
            [imageView stopAnimating];
            [imageView.layer removeAllAnimations];
            imageView.image = imageView.animationImages.lastObject;
            
            [self.rainDropsArray replaceObjectAtIndex:i withObject:temp];
            
            self.rainDropCounter = [NSNumber numberWithInt:[self.rainDropCounter intValue] + 1];
            
            self.rainDropScoreLabel.text = [@"Score: " stringByAppendingString: [NSString stringWithFormat:@"%@", self.rainDropCounter]];
            
            if ([self.rainDropCounter intValue] == [self.rainDropArrayCount intValue]) {
                [self changeSadToHappyAnimation];
            }
            return true;
        }
    }
    return false;
}

- (void)changeSadToHappyAnimation {
    
    UIImageView *rainbowImage = [[UIImageView alloc] init];
    
    CGRect imageframe = rainbowImage.frame;
    
    rainbowImage.userInteractionEnabled = YES;
    
    int size = ((int)arc4random_uniform(100) + 25);
    imageframe.size.height = size;
    imageframe.size.width = size;
    imageframe.origin = CGPointMake([UIScreen mainScreen].bounds.size.width, 50);
    rainbowImage.frame = imageframe;
    [rainbowImage setImage:[UIImage imageNamed:@"rainbow"]];
    [self.view addSubview:rainbowImage];
    rainbowImage.layer.zPosition = MAXFLOAT;
    
    imageframe.origin = CGPointMake(-50.0, 25);
    imageframe.size.width = [UIScreen mainScreen].bounds.size.width + size;
    imageframe.size.height = size + 150;
    [UIView animateWithDuration:3.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
        rainbowImage.frame = imageframe;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.5
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
            CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
            flash.fromValue = [NSNumber numberWithFloat: 1.0];
            flash.toValue = [NSNumber numberWithFloat: 0.0];
            flash.autoreverses = YES;
            [rainbowImage.layer addAnimation:flash forKey:@"flashAnimation"];
            
        } completion:^(BOOL finished) {
            [rainbowImage.layer removeAllAnimations];
            [rainbowImage removeFromSuperview];
        }];
    }];
}

#pragma private methods
- (void)queryActivities:(NSString *)columnName : (NSString *)moodName : (NSNumber *)score {
    
    PFQuery *query = [AXActivityRecommendation query];
    [query whereKey:columnName equalTo: moodName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            for(PFObject *object in objects) {
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                [temp addObject:object.objectId];
                [temp addObject:object[@"activity"]];
                [temp addObject:score];
                [temp addObject:object];
                [self.recActivities addObject:temp];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error); // will change to an alert later
        }
    }];
}

- (IBAction)didTapAddAcitivity:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AXChangeEmotionViewController *customeActivityViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomeActivityViewController"];
    [self.tableView reloadData];
    [self.navigationController pushViewController:customeActivityViewController animated:YES];
}

- (IBAction)didTapChangeEmotion:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AXChangeEmotionViewController *changeEmotionViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChangeEmotionViewController"];
    
    UITableViewCell *cell = sender;
    NSIndexPath *myIndexPath = [self.tableView indexPathForCell:cell];
    NSArray *activity = self.recActivities[myIndexPath.row];
    changeEmotionViewController.activityName = activity[1];
    changeEmotionViewController.activityObjectId = activity[0];
    changeEmotionViewController.userObject = activity[3];
    
    
    [self.navigationController pushViewController:changeEmotionViewController animated:YES];
    [self.tableView reloadData];

}

#pragma UITableView Methods
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AXActivityRecommendationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"activityCell" forIndexPath:indexPath];
    
    NSArray *activity = _recActivities[indexPath.row];
    [cell setUpActivity: activity[1]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recActivities.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AXDisplayActivityViewController *displayActivityViewController = [storyboard instantiateViewControllerWithIdentifier:@"DisplayActivityViewController"];
    
    NSArray *activity = self.recActivities[indexPath.row];
    displayActivityViewController.activity = activity[1];
    
    [self.navigationController pushViewController:displayActivityViewController animated:YES];
}

@end