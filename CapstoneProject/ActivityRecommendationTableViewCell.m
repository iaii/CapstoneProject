//
//  ActivityRecommendationTableViewCell.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/19/22.
//

#import "ActivityRecommendationTableViewCell.h"
#import "ActivityRecommendation.h"

@implementation ActivityRecommendationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpActivity:(ActivityRecommendation *) activityRecommendation {
    _activityRecommendationText.text = activityRecommendation.Activity;
}

@end
