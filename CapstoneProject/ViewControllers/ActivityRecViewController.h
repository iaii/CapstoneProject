//
//  ActivityRecViewController.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "MoodDetection.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityRecViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *recActivities;
@property (strong, nonatomic) MoodDetection *moodDectetor;

@end

NS_ASSUME_NONNULL_END
