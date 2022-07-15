//
//  LoginViewController.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
//#import <Parse/PFFacebookUtils.h>


NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *usernameField;
@property (weak, nonatomic) IBOutlet UITextView *passwordField;

@end

NS_ASSUME_NONNULL_END
