//tutorial.h
#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface Tutorial : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak) ViewController *myViewController;

@end
