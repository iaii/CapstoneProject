//
//  HomeViewController.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *userInput;
- (IBAction)didTapGetActivity:(id)sender;

@end

NS_ASSUME_NONNULL_END
