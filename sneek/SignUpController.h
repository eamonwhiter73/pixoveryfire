//
//  SignUpController.h
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;

@interface SignUpController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) FIRDatabaseReference *ref;


@end



