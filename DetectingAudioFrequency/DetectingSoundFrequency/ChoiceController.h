//
//  ChoiceController.h
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ChoiceCell.h"
@interface ChoiceController : NSObject<UITableViewDelegate, UITableViewDataSource>
-(void)setDataSource:(NSArray*)newSource tableView:(UITableView*)tableView;
@end
