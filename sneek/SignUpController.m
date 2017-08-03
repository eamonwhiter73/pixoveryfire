//
//  SignUpController.m
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import "SignUpController.h"
#import "ViewController.h"
#import <Parse/Parse.h>
@import FirebaseDatabase;
@import FirebaseAuth;

@interface NSString (emailValidation)
- (BOOL)isValidEmail;
@end

@implementation NSString (emailValidation)

-(BOOL)isValidEmail
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
@end


@interface SignUpController () {
    UITextField *textFieldLoc;
    UITextField *passwordTextField;
    UITextField *emailFieldLoc;
    CLLocationManager *locationManager;
    NSUserDefaults *userdefaults;
}

@end

@implementation SignUpController {}

- (void)enableMyLocation
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self requestLocationAuthorization];
    }
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        return;
    }
}

- (void)requestLocationAuthorization
{
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusNotDetermined) {
        [self performSelectorOnMainThread:@selector(enableMyLocation) withObject:nil waitUntilDone:[NSThread isMainThread]];
        
        locationManager.delegate = nil;
        locationManager = nil;
    }
}

- (void)viewDidLoad {
    self.ref = [[FIRDatabase database] reference];
    
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
    CGRect textfielduse = CGRectZero;
    CGRect emailfield = CGRectZero;
    CGRect pwfield = CGRectZero;
    CGRect signupbut = CGRectZero;
    UIButton *signUpButton;
    
    textFieldLoc = [[UITextField alloc] initWithFrame:textfielduse];
    emailFieldLoc = [[UITextField alloc] initWithFrame:emailfield];
    passwordTextField = [[UITextField alloc] initWithFrame:pwfield];
    signUpButton = [[UIButton alloc] initWithFrame:signupbut];
    
    if([screenWidth intValue] == 320) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage568"]]];
        
        textfielduse = CGRectMake(59.5, 310, 201, 40);
        textFieldLoc.font = [UIFont systemFontOfSize:16];
        
        emailfield = CGRectMake(59.5, 410, 201, 40);
        emailFieldLoc.font = [UIFont systemFontOfSize:16];
        
        pwfield = CGRectMake(59.5, 360, 201, 40);
        passwordTextField.font = [UIFont systemFontOfSize:16];
        
        signupbut = CGRectMake(59.5, 460, 201, 40);
        signUpButton.layer.cornerRadius = 5.0;
    }
    if([screenWidth intValue] == 375) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage1334"]]];
        
        textfielduse = CGRectMake(70, 364, 235.5, 40);
        textFieldLoc.font = [UIFont systemFontOfSize:16];
        
        emailfield = CGRectMake(70, 481, 235.5, 40);
        emailFieldLoc.font = [UIFont systemFontOfSize:16];
        
        pwfield = CGRectMake(70, 423, 235.5, 40);
        passwordTextField.font = [UIFont systemFontOfSize:16];
        
        signupbut = CGRectMake(70, 540, 235.5, 40);
        signUpButton.layer.cornerRadius = 5.0;
    }
    if([screenWidth intValue] == 414) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage1242"]]];
        
        textfielduse = CGRectMake(77, 402, 260, 40);
        textFieldLoc.font = [UIFont systemFontOfSize:16];
        
        emailfield = CGRectMake(77, 531, 260, 40);
        emailFieldLoc.font = [UIFont systemFontOfSize:16];

        pwfield = CGRectMake(77, 467, 260, 40);
        passwordTextField.font = [UIFont systemFontOfSize:16];
        
        signupbut = CGRectMake(77, 596, 260, 40);
        signUpButton.layer.cornerRadius = 5.0;
        
    }
    if([screenWidth intValue] == 768) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage768"]]];
        
        textfielduse = CGRectMake(143, 659, 482, 40);
        textFieldLoc.layer.cornerRadius = 10.0;
        textFieldLoc.font = [UIFont systemFontOfSize:16];
        
        emailfield = CGRectMake(143, 778, 482, 40);
        emailFieldLoc.layer.cornerRadius = 10.0;
        emailFieldLoc.font = [UIFont systemFontOfSize:16];
        
        pwfield = CGRectMake(143, 719, 482, 40);
        passwordTextField.font = [UIFont systemFontOfSize:16];
        passwordTextField.layer.cornerRadius = 10.0;
        
        signupbut = CGRectMake(143, 839, 482, 40);
        signUpButton.layer.cornerRadius = 10.0;

    }
    if([screenWidth intValue] == 1024) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage1024"]]];
        
        textfielduse = CGRectMake(191, 865, 641, 60);
        textFieldLoc.layer.cornerRadius = 15.0;
        textFieldLoc.font = [UIFont systemFontOfSize:32];
        
        emailfield = CGRectMake(191, 1047, 641, 60);
        emailFieldLoc.layer.cornerRadius = 15.0;
        emailFieldLoc.font = [UIFont systemFontOfSize:32];
        
        pwfield = CGRectMake(191, 956, 641, 60);
        passwordTextField.font = [UIFont systemFontOfSize:32];
        passwordTextField.layer.cornerRadius = 15.0;
        
        signupbut = CGRectMake(191, 1138, 641, 60);
        signUpButton.layer.cornerRadius = 15.0;
    }
    

    [self enableMyLocation];
    
    [textFieldLoc setFrame:textfielduse];
    textFieldLoc.borderStyle = UITextBorderStyleRoundedRect;
    textFieldLoc.layer.masksToBounds = true;
    textFieldLoc.placeholder = @" enter username";
    textFieldLoc.autocorrectionType = UITextAutocorrectionTypeNo;
    textFieldLoc.keyboardType = UIKeyboardTypeDefault;
    textFieldLoc.returnKeyType = UIReturnKeyDone;
    textFieldLoc.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldLoc.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFieldLoc.delegate = self;
    textFieldLoc.tag = 1;
    
    [self.view addSubview:textFieldLoc];
    
    [emailFieldLoc setFrame:emailfield];
    emailFieldLoc.borderStyle = UITextBorderStyleRoundedRect;
    emailFieldLoc.placeholder = @" enter email";
    emailFieldLoc.autocorrectionType = UITextAutocorrectionTypeNo;
    emailFieldLoc.keyboardType = UIKeyboardTypeDefault;
    emailFieldLoc.returnKeyType = UIReturnKeyDone;
    emailFieldLoc.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailFieldLoc.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailFieldLoc.delegate = self;
    emailFieldLoc.tag = 3;
    emailFieldLoc.layer.masksToBounds = true;
    
    [self.view addSubview:emailFieldLoc];

    [passwordTextField setFrame:pwfield];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.placeholder = @" enter password";
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.tag = 2;
    passwordTextField.layer.masksToBounds = true;
    passwordTextField.delegate = self;
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    [self.view addSubview:passwordTextField];
    
    [signUpButton setFrame:signupbut];
    signUpButton.layer.masksToBounds = true;
    signUpButton.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [signUpButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
    signUpButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
    [signUpButton setTitleColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(createUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:0 forKey:@"matches"];
    
}

- (void)createUser {
    //PFUser *user = [PFUser user];
    //user.username = textFieldLoc.text;
    //user.password = passwordTextField.text;
    if([emailFieldLoc.text isValidEmail]) {
        [[FIRAuth auth] createUserWithEmail:emailFieldLoc.text
                                   password:passwordTextField.text
                                 completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                     
                                     
                                     
                                     //[userdefaults setObject:@"old" forKey:@"new"];
                                     [userdefaults setObject:textFieldLoc.text forKey:@"pfuser"];
                                     [userdefaults setObject:@"new" forKey:@"new"];
                                     [userdefaults setObject:passwordTextField.text forKey:@"pfpass"];
                                     [userdefaults setObject:emailFieldLoc.text forKey:@"pfemail"];
                                     [userdefaults setObject:user.uid forKey:@"uid"];
                                     [userdefaults setInteger:0 forKey:@"count"];
                                     [userdefaults synchronize];
                                     
                                     [[[_ref child:@"userData"] child:[userdefaults valueForKey:@"uid"]]
                                      setValue:@{@"matches": @0}];
                                     
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                     
                                     ViewController* map = [[ViewController alloc] init];
                                     [[[[UIApplication sharedApplication] delegate] window] setRootViewController:map];

                                 }];
        //user.email = emailFieldLoc.text;
        
        
        
            }
    else {
        UIAlertController *match = [UIAlertController alertControllerWithTitle:@"SORRY" message:@"You didn't enter a valid email." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* matchAlert = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [match addAction:matchAlert];
        
        [self presentViewController:match animated:NO completion:NULL];
        
        return;
    }
    
    
    
    //[user setObject:@"0" forKey:@"matches"];
    
    
    
    /*[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [userdefaults setObject:user.username forKey:@"pfuser"];
            [userdefaults setObject:@"new" forKey:@"new"];
            [userdefaults setObject:user.password forKey:@"pfpass"];
            [userdefaults setObject:user.email forKey:@"pfemail"];
            [userdefaults setInteger:0 forKey:@"count"];
            [userdefaults synchronize];

            [self dismissViewControllerAnimated:YES completion:nil];
            
            ViewController* map = [[ViewController alloc] init];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:map];
        } else {
            NSLog(@"%@", [error userInfo][@"error"]);
        }
    }];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}

- (void) animateTextView:(BOOL)up
{
    const int movementDistance = 216;
    const float movementDuration = 0.3f;
    int movement= movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextView: YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self animateTextView:NO];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        passwordTextField = (UITextField *)[self.view viewWithTag:2];
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
