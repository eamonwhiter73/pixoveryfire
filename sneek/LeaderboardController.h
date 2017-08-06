//
//  LeaderboardController.h
//  sneek
//
//  Created by Eamon White on 11/25/15.
//  Copyright © 2015 Eamon White. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface LeaderboardController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITableView *tableViewScore;
@property NSObject *handle;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

