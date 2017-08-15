//
//  LeaderboardController.m
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import "LeaderboardController.h"
#import <Parse/Parse.h>
@import Firebase;

@interface LeaderboardController () {
    NSMutableArray *tableData;
    NSMutableArray *matchesForUser;
    NSMutableArray *entries;
    NSArray *transfer;
    int countUsers;
    NSArray *sortedFirstArray;
    NSArray *sortedSecondArray;
    UIButton *backToMap;
    NSDictionary *dictionary;
    UILabel *leaderboardtit;
    UILabel *username;
    UILabel *matches;
    UIView *tableHolder;
}
@end


@implementation LeaderboardController {}

- (void)viewWillAppear:(BOOL)animated {
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       // ...
                   }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}

- (void)viewDidLoad {
    self.ref = [[FIRDatabase database] reference];

    [self.view setBackgroundColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f]];
    
    tableData = [[NSMutableArray alloc] init];
    matchesForUser = [[NSMutableArray alloc] init];
    sortedFirstArray = [[NSArray alloc] init];
    sortedSecondArray = [[NSArray alloc] init];
    
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
    CGRect tablehold = CGRectZero;
    CGRect tableviewhold = CGRectZero;
    CGRect tableviewscore = CGRectZero;
    CGRect leaderboardtitrect = CGRectZero;
    CGRect userrect = CGRectZero;
    CGRect matchesrect = CGRectZero;
    CGRect backtomaprect = CGRectZero;
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"LEADERBOARD" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]}];
    
    username = [[UILabel alloc] init];
    matches = [[UILabel alloc] init];
    backToMap = [[UIButton alloc] init];
    
    if([screenWidth intValue] == 320) {
        tablehold = CGRectMake(10, 120, 300, 368);
        tableviewhold = CGRectMake(0, 0, 230, 368);
        tableviewscore = CGRectMake(240, 0, 60, 368);
        leaderboardtitrect = CGRectMake(0, 20, 320, 60);
        userrect = CGRectMake(10, 90, 140, 20);
        matchesrect = CGRectMake(170, 90, 140, 20);
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]};
        username.attributedText = [[NSAttributedString alloc] initWithString:@"USERNAME"
                                                                  attributes:underlineAttribute];
        matches.attributedText = [[NSAttributedString alloc] initWithString:@"POINTS"
                                                                 attributes:underlineAttribute];

        backtomaprect = CGRectMake(10, 498, 300, 60);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    }
    if([screenWidth intValue] == 375) {
        tablehold = CGRectMake(10, 140, 355, 432);
        tableviewhold = CGRectMake(0, 0, 270, 432);
        tableviewscore = CGRectMake(285, 0, 70, 432);
        leaderboardtitrect = CGRectMake(0, 20, 375, 60);
        userrect = CGRectMake(10, 105, 140, 20);
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]};
        username.attributedText = [[NSAttributedString alloc] initWithString:@"USERNAME"
                                                                  attributes:underlineAttribute];
        matchesrect = CGRectMake(220, 105, 140, 20);
        matches.attributedText = [[NSAttributedString alloc] initWithString:@"POINTS"
                                                                 attributes:underlineAttribute];
        backtomaprect = CGRectMake(10, 585, 355, 72);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    }
    if([screenWidth intValue] == 414) {
        tablehold = CGRectMake(10, 154, 394, 477);
        tableviewhold = CGRectMake(0, 0, 298, 477);
        tableviewscore = CGRectMake(317, 0, 77, 477);
        leaderboardtitrect = CGRectMake(0, 22, 414, 80);
        userrect = CGRectMake(10, 116, 154, 22);
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0]};
        username.attributedText = [[NSAttributedString alloc] initWithString:@"USERNAME"
                                                                  attributes:underlineAttribute];
        matchesrect = CGRectMake(245, 116, 154, 22);
        matches.attributedText = [[NSAttributedString alloc] initWithString:@"POINTS"
                                                                 attributes:underlineAttribute];
        backtomaprect = CGRectMake(10, 645.5, 394, 80);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    }
    if([screenWidth intValue] == 768){
        tablehold = CGRectMake(20, 215, 727, 663);
        tableviewhold = CGRectMake(0, 0, 607, 663);
        tableviewscore = CGRectMake(627, 0, 100, 663);
        
        leaderboardtitrect = CGRectMake(0, 30, 768, 110.5);
        attrString = [[NSAttributedString alloc] initWithString:@"LEADERBOARD" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:48.0]}];
        
        userrect = CGRectMake(20, 161, 287, 30);
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]};
        username.attributedText = [[NSAttributedString alloc] initWithString:@"USERNAME"
                                                                  attributes:underlineAttribute];
        matchesrect = CGRectMake(446, 161, 287, 30);
        matches.attributedText = [[NSAttributedString alloc] initWithString:@"POINTS"
                                                                 attributes:underlineAttribute];
        backtomaprect = CGRectMake(20, 898, 727, 110.5);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42.0];
    }
    if([screenWidth intValue] == 1024){
        
        tablehold = CGRectMake(27, 287, 969, 885);
        tableviewhold = CGRectMake(0, 0, 737, 885);
        tableviewscore = CGRectMake(778, 0, 191, 885);
        
        leaderboardtitrect = CGRectMake(0, 20, 1024, 200);
        attrString = [[NSAttributedString alloc] initWithString:@"LEADERBOARD" attributes:@{ NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:72.0]}];
        
        userrect = CGRectMake(27, 215, 382, 73);
        
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0]};
        username.attributedText = [[NSAttributedString alloc] initWithString:@"USERNAME"
                                                                  attributes:underlineAttribute];
        matchesrect = CGRectMake(574, 215, 382, 73);
        matches.attributedText = [[NSAttributedString alloc] initWithString:@"POINTS"
                                                                  attributes:underlineAttribute];
        
        backtomaprect = CGRectMake(27, 1198, 969, 147);
        backToMap.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:54.0];
    }
    
    tableHolder = [[UIView alloc] initWithFrame:tablehold];
    tableHolder.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableHolder];

    _tableView = [[UITableView alloc] initWithFrame:tableviewhold];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 1;
    _tableView.separatorColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.layoutMargins = UIEdgeInsetsZero;
    if([_tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)])
    {
        _tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    [tableHolder addSubview:_tableView];
    
    _tableViewScore = [[UITableView alloc] initWithFrame:tableviewscore];
    _tableViewScore.delegate = self;
    _tableViewScore.dataSource = self;
    _tableViewScore.tag = 2;
    _tableViewScore.separatorColor = [UIColor clearColor];
    _tableViewScore.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    _tableViewScore.layer.masksToBounds = true;
    _tableViewScore.layer.cornerRadius = 5.0;
    CGSize scrollableSize = CGSizeMake(60, 368);
    [_tableViewScore setContentSize:scrollableSize];
    [tableHolder addSubview:_tableViewScore];
    
    leaderboardtit = [[UILabel alloc] initWithFrame:leaderboardtitrect];
    leaderboardtit.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    leaderboardtit.numberOfLines = 0;
    leaderboardtit.attributedText = attrString;
    [self.view addSubview:leaderboardtit];
    
    [username setFrame:userrect];
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    /*NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    username.attributedText = [[NSAttributedString alloc] initWithString:@"USERNAME"
                                                               attributes:underlineAttribute];*/
    username.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:username];
    
    [matches setFrame:matchesrect];
    matches.backgroundColor = [UIColor clearColor];
    /*NSDictionary *underlineAttribute2 = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    matches.attributedText = [[NSAttributedString alloc] initWithString:@"POINTS"
                                                             attributes:underlineAttribute2];*/
    matches.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    matches.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:matches];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SimpleTableItem"];
    [_tableViewScore registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SimpleTableItem"];
    
    
    [[_ref child:@"userData/"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        if([snapshot exists]) {
            NSDictionary *dict = snapshot.value;

            entries = [NSMutableArray new];
            [dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber* value, BOOL* stop) {
                NSLog(@"%@ username  ", [value valueForKey:@"username"]);
                NSLog(@"%@ matches  ", [value valueForKey:@"matches"]);
                
                    [tableData addObject:[value valueForKey:@"username"]];
                    [matchesForUser addObject:[[NSString alloc] initWithFormat:@"%d", (([[value valueForKey:@"matches"] intValue] * 6) + [[value valueForKey:@"drops"] intValue])]];
                    
                    NSMutableDictionary* entry = [NSMutableDictionary new];
                    
                    entry[@"username"] = [value valueForKey:@"username"];
                    entry[@"matches"] = [[NSString alloc] initWithFormat:@"%d", (([[value valueForKey:@"matches"] intValue] * 6) + [[value valueForKey:@"drops"] intValue])];
                
                    [entries addObject:entry];
            }];
            
            NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"matches" ascending:NO selector:@selector(localizedStandardCompare:)];
            NSArray *entrieshold = [entries sortedArrayUsingDescriptors:@[descriptor]];
            transfer = [entrieshold copy];
            
            [_tableView reloadData];
            [_tableViewScore reloadData];

        }

    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    [backToMap setFrame:backtomaprect];
    backToMap.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [backToMap setTitleColor:[UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [backToMap addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [backToMap setTitle:@"BACK TO MAP" forState:UIControlStateNormal];
    backToMap.layer.masksToBounds = true;
    backToMap.layer.cornerRadius = 5.0;
    [self.view addSubview:backToMap];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);

    if(tableView.tag == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        cell.textLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
       

        UILabel *contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 44)];
        contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        if([screenWidth intValue] == 1024) {
            contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 737, 44)];
            contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0];
        }
        else if([screenWidth intValue] == 768) {
            contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 607, 44)];
            contentV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        }
        
        contentV.textColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        contentV.backgroundColor = [UIColor colorWithRed:156.0f/255.0f green:214.0f/255.0f blue:215.0f/255.0f alpha:1.0f];

        cell.contentView.layoutMargins = UIEdgeInsetsZero;

        NSString *username2 = [[transfer objectAtIndex:indexPath.row] valueForKey:@"username"];
        
        contentV.text = username2;
        [cell.contentView addSubview:contentV];

        return cell;
    }
    else {
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        if([screenWidth intValue] == 1024) {
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0];
        }
        else if([screenWidth intValue] == 768) {
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        }
        cell.textLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:211.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:247.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        NSString *matchAmount = [[NSString alloc] initWithFormat:@"%@", [[transfer objectAtIndex:indexPath.row] valueForKey:@"matches"]];
        
        cell.textLabel.text = matchAmount;
        
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    UITableView *slaveTable = nil;
    
    if (_tableView == scrollView) {
        slaveTable = _tableViewScore;
    } else if (_tableViewScore == scrollView) {
        slaveTable = _tableView;
    }
    
    [slaveTable setContentOffset:scrollView.contentOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"*** memory warning ***");
    // Dispose of any resources that can be recreated.
}

@end
