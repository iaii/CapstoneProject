//
//  RaindropsUIImageView.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/3/22.
//

#import "RaindropsUIImageView.h"

@implementation RaindropsUIImageView

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([[self.layer presentationLayer] hitTest:point]) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

@end
