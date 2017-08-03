#import "Tutorial.h"

@interface Tutorial() {
    UIButton *camerabut;
    UIView* gray;
    UIImagePickerController* picker;
    UILabel *labe;
}

@end

@implementation Tutorial

@synthesize myViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        gray = [[UIView alloc] initWithFrame:frame];

        [self addSubview:gray];
        
        camerabut = [[UIButton alloc] init];
        labe = [[UILabel alloc] init];
        labe.text = @"PRESS THE CAMERA BUTTON TO TAKE A PICTURE";
        labe.numberOfLines = 0;
        labe.textAlignment = NSTextAlignmentCenter;
        labe.textColor = [UIColor colorWithRed:211.0f/255.0f green:243.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
        
        if(frame.size.width == 320) {
            camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabut"]];
            camerabut.frame = CGRectMake(137.125, 499.5, 43, 43);
            labe.frame = CGRectMake(20, 240, 280, 120);
            [labe setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]];
        }
        else if(frame.size.width == 375) {
            camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabut"]];
            camerabut.frame = CGRectMake(164.625, 598.5, 43, 43);
            labe.frame = CGRectMake(23, 282, 328, 141);
            [labe setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]];

            
        }
        else if(frame.size.width == 414) {
            camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabut"]];
            camerabut.frame = CGRectMake(176, 659.5, 62, 62);
            labe.frame = CGRectMake(26, 311, 362, 155);
            [labe setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]];
            
        }
        else if(frame.size.width == 768) {
            camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabutipadp"]];
            camerabut.frame = CGRectMake(340.5, 884.5, 88, 88);
            labe.frame = CGRectMake(48, 433, 672, 216);
            [labe setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]];
            
        }
        else if(frame.size.width == 1024) {
            camerabut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camerabutipadp"]];
            camerabut.frame = CGRectMake(468, 1225, 88, 88);
            labe.frame = CGRectMake(64, 578, 896, 288);
            [labe setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:48.0]];
        }
        
        [camerabut addTarget:myViewController action:@selector(dropSneek) forControlEvents:UIControlEventTouchUpInside];
        [gray addSubview:camerabut];
        [gray addSubview:labe];
        
    }
    return self;
}

@end
