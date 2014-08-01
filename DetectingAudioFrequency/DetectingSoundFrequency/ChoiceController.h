//
//  ChoiceController.h
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
#import "ChoiceCell.h"
@interface ChoiceController : NSObject<UITableViewDelegate, UITableViewDataSource>
- (id)init:(ViewController*)viewController;
-(void)setDataSource:(NSDictionary*)newSource;
@end
