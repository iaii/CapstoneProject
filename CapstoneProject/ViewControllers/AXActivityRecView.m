//
//  ActivityRecView.m
//  CapstoneProject
//
//  Created by Sanasar Kolyan on 8/3/22.
//

#import "AXActivityRecView.h"

@implementation AXActivityRecView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self.delegate activityRecViewDidhitTest:point withEvent:event]) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

@end
