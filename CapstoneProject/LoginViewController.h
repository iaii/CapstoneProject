//
//  LoginViewController.h
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Parse/PFFacebookUtils.h>


NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *usernameField;
@property (weak, nonatomic) IBOutlet UILabel *passwordField;
- (IBAction)didTapLogin:(id)sender;
- (IBAction)didTapSignUp:(id)sender;
//- (IBAction)fblogin:(FBSDKLoginButton *)sender;

@end

NS_ASSUME_NONNULL_END
