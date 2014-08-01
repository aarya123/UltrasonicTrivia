//
//  ChoiceController.m
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "ChoiceController.h"

@interface ChoiceController ()
@property (nonatomic,strong)NSArray* questions;
@end

@implementation ChoiceController


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ChoiceCell";
    
    // Similar to UITableViewCell, but
    ChoiceCell *cell = (ChoiceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Just want to test, so I hardcode the data
    [cell.btn setTitle:[self getItemAtIndex:indexPath] forState:UIControlStateNormal];

    return cell;
    
}
-(NSString*)getItemAtIndex:(NSIndexPath*)indexPath{
    return self.questions[[indexPath row]];
}
-(void)setDataSource:(NSArray*)newSource tableView:(UITableView*)tableView{
    self.questions=newSource;
    [tableView reloadData];
}
@end
