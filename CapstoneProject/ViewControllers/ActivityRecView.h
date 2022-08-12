//
//  ActivityRecView.h
//  CapstoneProject
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ActivityRecViewDelegate <NSObject>

-(BOOL)activityRecViewDidhitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end

@interface ActivityRecView : UIView

@property (weak, nonatomic) id<ActivityRecViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
