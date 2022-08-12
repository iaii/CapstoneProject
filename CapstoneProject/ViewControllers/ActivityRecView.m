//
//  ActivityRecView.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/3/22.
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
