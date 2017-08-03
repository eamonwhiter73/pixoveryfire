#import "RespTutorial.h"

@interface RespTutorial() {
    UIButton *respbut;
    UIView* gray;
    UIImagePickerController* picker;
    UILabel *labe;
}

@end

@implementation RespTutorial

@synthesize myViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        gray = [[UIView alloc] initWithFrame:frame];
        
        [self addSubview:gray];
        
        respbut = [[UIButton alloc] init];
        respbut.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        [respbut setTitle:@"MATCH IT" forState:UIControlStateNormal];
        [respbut setTitleColor:[UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [respbut addTarget:myViewController action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
        respbut.layer.masksToBounds = true;

        
        labe = [[UILabel alloc] init];
        labe.text = @"1. PRESS 'MATCH IT' TO MATCH THE PICTURE\r\r2. FOR HELP MATCHING, USE THE CANCEL BUTTON IN CAMERA MODE TO SWITCH BACK AND FORTH";
        labe.numberOfLines = 0;
        labe.textAlignment = NSTextAlignmentCenter;
        [labe setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]];
        labe.textColor = [UIColor colorWithRed:211.0f/255.0f green:243.0f/255.0f blue:219.0f/255.0f alpha:1.0f];

        
        if(frame.size.width == 320) {
            respbut.frame = CGRectMake(10, 466, 300, 92);
            respbut.layer.cornerRadius = 10.0;
            respbut.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
            labe.frame = CGRectMake(20, 60, 280, 400);
        }
        else if(frame.size.width == 375) {
            respbut.frame = CGRectMake(10, 547, 355, 92);
            respbut.layer.cornerRadius = 10.0;
            respbut.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
            labe.frame = CGRectMake(23, 125, 328, 470);
        }
        else if(frame.size.width == 414) {
            respbut.frame = CGRectMake(10, 900, 392, 170);
            respbut.layer.cornerRadius = 10.0;
            respbut.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
            labe.frame = CGRectMake(26, 78, 362, 518);
        }
        else if(frame.size.width == 768) {
            respbut.frame = CGRectMake(20, 840, 727, 141);
            respbut.layer.cornerRadius = 7.5;
            respbut.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
            labe.frame = CGRectMake(48, 192, 672, 721);
        }
        else if(frame.size.width == 1024) {
            respbut.frame = CGRectMake(27, 1096, 969, 230);
            respbut.layer.cornerRadius = 5.0;
            respbut.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:60.0];
            labe.frame = CGRectMake(64, 144, 280, 1195);
        }
        
        
        [gray addSubview:respbut];
        [gray addSubview:labe];
        
    }
    return self;
}

@end
