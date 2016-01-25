//
//  MainViewController.h
//  MedApp
//
//  Created by Necrosoft on 22/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/* Main View Controller */

@interface MainViewController : UITableViewController

/* Array, storing NewsParseer objects, that hold news data */

@property (nonatomic, strong) NSMutableArray *dataArray;

/* Parameters  */

@property (nonatomic, strong) NSDictionary *parameters;

@end
