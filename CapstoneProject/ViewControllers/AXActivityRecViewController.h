//
//  ActivityRecViewController.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "AXMoodDetection.h"
#import "AXActivityRecView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXActivityRecViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate, ActivityRecViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *recActivityAndScoreDict;
@property (strong, nonatomic) NSMutableDictionary *indexedActivitiesDict;
@property (strong, nonatomic) NSMutableArray *recActivities;
@property (strong, nonatomic) AXMoodDetection *moodDectetor;

@end

NS_ASSUME_NONNULL_END
