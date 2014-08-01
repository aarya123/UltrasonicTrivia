//
//  ChoiceController.m
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "ChoiceController.h"

@interface ChoiceController ()
@property (nonatomic,strong)NSDictionary* question;
@property(nonatomic,strong)UILabel* questionLabel;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic)BOOL answered;
@end

@implementation ChoiceController
- (id)init:(UILabel*)questionLabel tableView:(UITableView *)tableView{
    self = [super init];
    if (self)
    {
        self.questionLabel=questionLabel;
        self.tableView=tableView;
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getChoices] count];
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
    cell.btn.tag=[indexPath row];
    [cell.btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn setEnabled:!self.answered];
    return cell;
}
-(void) btnPressed:(id) sender{
    int tag=((UIButton*)sender).tag;
    if(tag==[self getAnswerIndex]){
        [self.questionLabel setBackgroundColor:[UIColor greenColor]];
    }
    else{
        [self.questionLabel setBackgroundColor:[UIColor redColor]];
    }
    self.answered=YES;
    [self.tableView reloadData];
}
-(NSString*)getItemAtIndex:(NSIndexPath*)indexPath{
    return [self getChoices][[indexPath row]];
}
-(void)setDataSource:(NSDictionary*)newSource{
    self.question=newSource;
    self.answered=NO;
    [self.tableView reloadData];
}
-(NSArray*)getChoices{
    return [self.question objectForKey:@"choices"];
}
-(int)getAnswerIndex{
    return [[self.question objectForKey:@"answer"] intValue];
}
@end
