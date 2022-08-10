//
//  ActivityRecommendationTableViewCell.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/19/22.
//

#import "AXActivityRecommendationTableViewCell.h"
#import "AXActivityRecommendation.h"
#import "AXChangeEmotionViewController.h"

static NSString *const circleImageUnfilledName = @"hand.thumbsup.circle";
static NSString *const circleImageFilledName = @"hand.thumbsup.circle.fill";

@implementation AXActivityRecommendationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.like = NO;
    self.dislike = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
        [self.likeButton setImage:[UIImage systemImageNamed:circleImageUnfilledName] forState:UIControlStateNormal];
    } else {
        if(_dislike) {
            [self didTapDislikeButton:sender];
        }
        self.like = YES;
        [self.likeButton setImage:[UIImage systemImageNamed:circleImageFilledName] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapDislikeButton:(id)sender {
    if(self.dislike) {
        self.dislike = NO;
        [self.dislikeButton setImage:[UIImage systemImageNamed:circleImageUnfilledName] forState:UIControlStateNormal];
    } else {
        if(_like) {
            [self didTapLikeButton:sender];
        }
        self.dislike = YES;
        [self.dislikeButton setImage:[UIImage systemImageNamed:circleImageFilledName] forState:UIControlStateNormal];
    }
}

@end
