//
//  ChangeEmotionViewController.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/29/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeEmotionViewController : UIViewController
@property (strong, nonatomic) NSArray *activites;
@property (strong, nonatomic) NSString *activityName;
@property (strong, nonatomic) NSString *activityObjectId;
@property (strong, nonatomic) PFObject *userObject;

@end

NS_ASSUME_NONNULL_END
