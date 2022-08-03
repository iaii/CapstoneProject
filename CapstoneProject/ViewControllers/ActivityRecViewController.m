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
#import "ChangeEmotionViewController.h"
#import "RaindropsUIImageView.h"

#import <Parse/Parse.h>

@interface ActivityRecViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *mood;
@property (weak, nonatomic) IBOutlet UILabel *headingText;
@property (strong, nonatomic) NSMutableArray *rainDropsArray;
- (IBAction)didTapChangeEmotion:(id)sender;
- (IBAction)didTapAddAcitivity:(id)sender;
- (IBAction)didTapSelectActivity:(id)sender;

@end

@implementation ActivityRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    
    self.recActivities = [[NSMutableArray alloc] init];
    
    _mood = [self.moodDectetor mood];
    NSString *heading = [@"Since you're feeling " stringByAppendingString: _mood.lowercaseString];
    _headingText.text = [heading stringByAppendingString: @" you should"];
    
    [self loadAnimations];
    [self queryActivities];
}

-(void) loadAnimations {
    if([self.mood isEqualToString:@"Happy"]) {
        for(int i = 0; i < 100; i++){
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
            
            NSArray *pathArray = @[[NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)], [NSValue valueWithCGPoint:CGPointMake((int)arc4random_uniform(500), (int)arc4random_uniform(950))]];
            CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnimation.values = pathArray;
            pathAnimation.duration = 2.5;
            [careImage.layer addAnimation:pathAnimation forKey:@"position"];
            
            CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
            flash.fromValue = [NSNumber numberWithFloat: (float)arc4random_uniform(100)];
            flash.toValue = [NSNumber numberWithFloat: 0.0];
            flash.duration = (float)arc4random_uniform(5);
            flash.autoreverses = YES;
            [careImage.layer addAnimation:flash forKey:@"flashAnimation"];
        }
    } else if([self.mood isEqualToString:@"Sad"]) {
        [self sadAnimation];
    }
}

-(void)sadAnimation {
    
//    UITapGestureRecognizer *singleFingerTap =
//      [[UITapGestureRecognizer alloc] initWithTarget:self
//                                              action:@selector(handleSingleTap:)];
//    [self.view addGestureRecognizer:singleFingerTap];
    
    self.rainDropsArray = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
   // [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setDelegate:self];

    for(int i = 0; i < 15; i++){
        RaindropsUIImageView *sadImage = [[RaindropsUIImageView alloc] init];
        CGRect imageframe = sadImage.frame;
        
        sadImage.userInteractionEnabled = YES;
        
        [sadImage addGestureRecognizer:tapRecognizer];

        int size = ((int)arc4random_uniform(100) + 25);
        imageframe.size.height = size;
        imageframe.size.width = size;
        //imageframe.origin = CGPointMake(200, 200);
        imageframe.origin = CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        sadImage.frame = imageframe;
        [sadImage setImage:[UIImage imageNamed:@"rain"]];
        [self.view addSubview:sadImage];
        sadImage.layer.zPosition = MAXFLOAT;

        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"position.y";
        animation.fromValue = @0;
        animation.toValue = @700;
        animation.duration = 5; //(int)arc4random_uniform(3) + 1;

        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:0.35:0.55:0.3];

        animation.beginTime = CACurrentMediaTime() + (int)arc4random_uniform(5);

        sadImage.animationRepeatCount = 1; // loops only once

        [sadImage.layer addAnimation:animation forKey:@"basic"];

        sadImage.layer.position = CGPointMake((int)arc4random_uniform(500), 0);

        CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
        flash.fromValue = [NSNumber numberWithFloat:1.0];
        flash.toValue = [NSNumber numberWithFloat:0.0];
        flash.duration = 7;        // 1 second
        flash.autoreverses = YES;    // Back
       // flash.repeatCount = 3;       // Or whatever

        [sadImage.layer addAnimation:flash forKey:@"flashAnimation"];

        
        NSMutableArray *rainDropImageAndStatus = [[NSMutableArray alloc] init];
        [rainDropImageAndStatus addObject:sadImage];
        [rainDropImageAndStatus addObject:@0];
        
        [self.rainDropsArray addObject:rainDropImageAndStatus];
    }
}

-(void)tapped:(UITapGestureRecognizer *) gesture {
    for (int i = 0; i < self.rainDropsArray.count; i++) {
        NSArray *currentItem = self.rainDropsArray[i];
        UIImageView *currentImage = currentItem[0];
        
       // [(RootViewController*)currentImage.superview touches began method];

//        CGPoint currentFrame = [image.layer.position];
       // CGPoint locationInView = [image.window convertPoint:point fromView:image.window];

        if ([currentItem[1] isEqual: @0]) {
            currentImage.alpha = 0;
            
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            [temp addObject:currentImage];
            [temp addObject:@1];
            
            [currentImage stopAnimating];
            [currentImage.layer removeAllAnimations];
            currentImage.image = currentImage.animationImages.lastObject;
            
            

            [self.rainDropsArray replaceObjectAtIndex:i withObject:temp];
        }
    }
}

//The event handling method
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event handleTap:(UITapGestureRecognizer *) gesture {
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint location = [touch locationInView:touch.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
                
        for (int i = 0; i < self.rainDropsArray.count; i++) {
            NSArray *currentItem = self.rainDropsArray[i];
            UIImageView *currentImage = currentItem[0];
            CGRect currentImageFrame = [currentImage.layer.presentationLayer frame];
            
           // [(RootViewController*)currentImage.superview touches began method];

    //        CGPoint currentFrame = [image.layer.position];
           // CGPoint locationInView = [image.window convertPoint:point fromView:image.window];

            if (CGRectContainsPoint(currentImageFrame, location) && [currentItem[1] isEqual: @0]) {
                currentImage.alpha = 0;
                
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                [temp addObject:currentImage];
                [temp addObject:@1];
                
                [currentImage stopAnimating];
                [currentImage.layer removeAllAnimations];
                currentImage.image = currentImage.animationImages.lastObject;
                
                

                [self.rainDropsArray replaceObjectAtIndex:i withObject:temp];
            }
        }
    }
}

//- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
//{
//  CGPoint location = [recognizer locationInView:[recognizer.view superview]];
//
//  //
//
//}


-(void)queryActivities {
    
    PFQuery *query = [ActivityRecommendation query];
    
    [query whereKey:@"firstEmotionTag" equalTo:_mood];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                              NSError * _Nullable error) {
        if (objects) {
            for(PFObject *object in objects) {
                NSLog(@"%@", object);
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                [temp addObject:object.objectId];
                [temp addObject:object[@"activity"]];
                [temp addObject:@4];
                [temp addObject:object];
                [self.recActivities addObject:temp];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    PFQuery *query2 = [ActivityRecommendation query];
    [query2 whereKey:@"secondEmotionTag" equalTo:_mood];
    
    [query2 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                               NSError * _Nullable error) {
        if (objects) {
            for(PFObject *object in objects) {
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                [temp addObject:object.objectId];
                [temp addObject:object[@"activity"]];
                [temp addObject:@3];
                [temp addObject:object];
                [self.recActivities addObject:temp];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    PFQuery *query3 = [ActivityRecommendation query];
    [query3 whereKey:@"thirdEmotionTag" equalTo:_mood];
    
    [query3 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
                                               NSError * _Nullable error) {
        if (objects) {
            
            for(PFObject *object in objects){
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                [temp addObject:object.objectId];
                [temp addObject:object[@"activity"]];
                [temp addObject:@2];
                [temp addObject:object];
                [self.recActivities addObject:temp];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ActivityRecommendationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"activityCell" forIndexPath:indexPath];

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

- (IBAction)didTapSelectActivity:(id)sender {
}

- (IBAction)didTapAddAcitivity:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomeActivityViewController"];
}

- (IBAction)didTapChangeEmotion:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChangeEmotionViewController *changeEmotionViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChangeEmotionViewController"];
    
    UITableViewCell *cell = sender;
    NSIndexPath *myIndexPath = [self.tableView indexPathForCell:cell];
    NSArray *activity = _recActivities[myIndexPath.row];
    changeEmotionViewController.activityName = activity[1];
    changeEmotionViewController.activityObjectId = activity[0];
    changeEmotionViewController.userObject = activity[3];
    
    [self.navigationController pushViewController:changeEmotionViewController animated:YES];
}

@end
