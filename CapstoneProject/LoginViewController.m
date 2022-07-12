//
//  LoginViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 7/11/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <Parse/PFFacebookUtils.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fblogin:(id *)sender {
//    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
//    if (!user) {
//       NSString *errorMessage = nil;
//       if (!error) {
//          NSLog(@"Uh oh. The user cancelled the Facebook login.");
//          errorMessage = NSLocalizedString(@"Uh oh. The user cancelled the Facebook login.", nil);
//       } else {
//          NSLog(@"Uh oh. An error occurred: %@", error);
//          errorMessage = [error localizedDescription];
//       }
//       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Log In Error", nil) message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Dismiss", nil), nil];
//       [MBProgressHUD hideHUDForView:self.view animated:YES];
//       [alert show];
//    } else {
//       if (user.isNew) {
//          NSLog(@"User with facebook signed up and logged in!");
//          [self _loadData];
//       } else {
//          NSLog(@"User with facebook logged in!");
//       }
//       [MBProgressHUD hideHUDForView:self.view animated:YES];
//       [self _presentNextViewControllerAnimated:YES];
//    }
//    }];
//  }
//
//  - (void)_presentNextViewControllerAnimated:(BOOL)animated {
//    PAWWallViewController *wallViewController = [[PAWWallViewController alloc] initWithNibName:nil bundle:nil];
//    [(UINavigationController *)self.presentingViewController pushViewController:wallViewController animated:NO];
//    [self.presentingViewController dismissModalViewControllerAnimated:YES];
//  }
//
//  - (void)_loadData {
//    FBRequest *request = [FBRequest requestForMe];
//    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//    if (!error) {
//       PFUser *user = [PFUser currentUser];
//       NSDictionary *userData = (NSDictionary *)result;
//       NSString *facebookID = userData[@"id"];
//       NSString *name = userData[@"name"];
//       NSString *email = userData[@"email"];
//       NSString *location = userData[@"location"][@"name"];
//       NSString *gender = userData[@"gender"];
//       NSString *birthday = userData[@"birthday"];
//       NSString *relationship = userData[@"relationship_status"];
//       NSString *facebookLink = [NSString stringWithFormat:@"Facebook.com/%@", facebookID];
//       NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
//       NSLog(@"facebookID --> %@", facebookID);
//       NSLog(@"name --> %@", name);
//       NSLog(@"email --> %@", email);
//       //for profile image
//       NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
//       // Run network request asynchronously
//       [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,     NSData *data, NSError *connectionError) {
//       if (connectionError == nil && data != nil) {
//          PFFile *userImageFile = [PFFile fileWithName:@"userImage.jpg" data:data];
//          if (userImageFile) [user setObject:userImageFile forKey:kPAWParseUserImageKey];
//       }
//
//       [user setObject:facebookID forKey:kPAWParseUsernameKey]; //initially use fb id as username to avoid duplication
//       [user setObject:name forKey:kPAWParseRealnameKey];
//       [user setObject:facebookLink forKey:kPAWParseFacebookKey];
//
//       [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//       if (!error) {
//          if (succeeded) {
//             NSLog(@"fb user saved successfully");
//          }
//       } else {
//          NSLog(@"fb user saved unsuccessfully");
//       }
//       }];
//     }];
//
//     } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
//                  isEqualToString: @"OAuthException"]) {
//          NSLog(@"The facebook session was invalidated");
//
//          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Log out of Spotpost?", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Log out", nil) otherButtonTitles:NSLocalizedString(@"Cancel", nil), nil];
//          [alertView show];
//
//     } else {
//       NSLog(@"Some other error: %@", error);
//     }
//     }];
//}
//
//
//- (IBAction)didTapSignUp:(id)sender {
//    if([self.usernameField.text isEqual:@""]){
//        [self loginAlert];
//    }else{
//        // initialize a user object
//        PFUser *newUser = [PFUser user];
//        
//        // set user properties
//        newUser.username = self.usernameField.text;
//        //newUser.email = self.emailField.text;
//        newUser.password = self.passwordField.text;
//        
//        // call sign up function on the object
//        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
//            if (error != nil) {
//                NSLog(@"Error: %@", error.localizedDescription);
//            } else {
//                NSLog(@"User registered successfully");
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
//            }
//        }];
//    }
}

- (IBAction)didTapLogin:(id)sender {
    if([self.usernameField.text isEqual:@""]){
        [self loginAlert];
    }else{
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
    }
}

-(void)loginAlert{
    [super viewDidLoad];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                               message:@"Message"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    
}

@end
