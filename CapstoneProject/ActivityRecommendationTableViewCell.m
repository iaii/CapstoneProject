//
//  ActivityRecommendationTableViewCell.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/19/22.
//

#import "ActivityRecommendationTableViewCell.h"
#import "ActivityRecommendation.h"
#import "ChangeEmotionViewController.h"

@implementation ActivityRecommendationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.like = NO;
    self.dislike = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpActivity:(NSString *) activity {
    self.activity = activity;
    _activityRecommendationText.text = activity;
}

- (IBAction)didTapSelectActivity:(id)sender {
}

- (IBAction)didTapLikeButton:(id)sender {
    if(self.like) {
        self.like = NO;
        [self.likeButton setImage:[UIImage systemImageNamed:@"hand.thumbsup.circle"] forState:UIControlStateNormal];
    } else {
        if(_dislike) {
            [self didTapDislikeButton:sender];
        }
        self.like = YES;
        [self.likeButton setImage:[UIImage systemImageNamed:@"hand.thumbsup.circle.fill"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapDislikeButton:(id)sender {
    if(self.dislike) {
        self.dislike = NO;
        [self.dislikeButton setImage:[UIImage systemImageNamed:@"hand.thumbsdown.circle"] forState:UIControlStateNormal];
    } else {
        if(_like) {
            [self didTapLikeButton:sender];
        }
        self.dislike = YES;
        [self.dislikeButton setImage:[UIImage systemImageNamed:@"hand.thumbsdown.circle.fill"] forState:UIControlStateNormal];
    }
}

@end
