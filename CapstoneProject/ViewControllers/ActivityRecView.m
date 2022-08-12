//
//  ActivityRecView.m
//  CapstoneProject
//

#import "ActivityRecView.h"

@implementation ActivityRecView

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([self.delegate activityRecViewDidhitTest:point withEvent:event]) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

@end
