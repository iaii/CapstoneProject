//
//  ActivityRecommendationTableViewCell.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/19/22.
//

#import <UIKit/UIKit.h>
#import "ActivityRecommendation.h"
#import "ActivityRecommendation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityRecommendationTableViewCell : UITableViewCell

@property (strong, nonatomic) ActivityRecommendation *acitivityRecommendation;
@property (weak, nonatomic) IBOutlet UILabel *activityRecommendationText;

- (void)setUpActivity:(ActivityRecommendation *) activityRecommendation;
    
@end

NS_ASSUME_NONNULL_END
