//
//  ActivityRecommendationTableViewCell.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/19/22.
//

#import <UIKit/UIKit.h>
#import "AXActivityRecommendation.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXActivityRecommendationTableViewCell : UITableViewCell

@property (strong, nonatomic) AXActivityRecommendation *acitivityRecommendation;
@property (weak, nonatomic) IBOutlet UILabel *activityRecommendationText;
@property (nonatomic) BOOL like;
@property (nonatomic) BOOL dislike;
@property (strong, nonatomic) NSString *activity;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;

- (IBAction)didTapLikeButton:(id)sender;
- (IBAction)didTapDislikeButton:(id)sender;
- (IBAction)didTapSelectActivity:(id)sender;

- (void)setUpActivity:(NSString *)activity;

@end

NS_ASSUME_NONNULL_END
