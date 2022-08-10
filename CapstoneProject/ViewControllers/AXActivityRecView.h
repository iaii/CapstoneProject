//
//  ActivityRecView.h
//  CapstoneProject
//
//  Created by Sanasar Kolyan on 8/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ActivityRecViewDelegate <NSObject>

- (BOOL)activityRecViewDidhitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end

@interface AXActivityRecView : UIView

@property (weak, nonatomic) id<ActivityRecViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
