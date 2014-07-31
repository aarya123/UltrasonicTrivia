//
//  MicViewController.m
//  UltrasonicListener
//
//  Created by Anubhaw Arya on 7/31/14.
//  Copyright (c) 2014 Anubhaw Arya. All rights reserved.
//

#import "MicViewController.h"
@interface MicViewController ()
@property (nonatomic, strong) UIButton *micButton;
@end

@implementation MicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.micButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.micButton setCenter:self.view.center];
//    self.micButton.frame=CGRectMake(screenRect.size.width/4, screenRect.size.height/4, screenRect.size.width/2, screenRect.size.height/2);
    [self.micButton setFrame:CGRectMake(screenRect.size.width/4, screenRect.size.height/4, screenRect.size.width/2, screenRect.size.height/2)];
    [self.micButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.micButton setTitle:@"Start Recording" forState:UIControlStateNormal];
    [self.view addSubview:self.micButton];
    // Do any additional setup after loading the view.
}
- (void)buttonPressed {
    if([self.micButton.titleLabel.text isEqual:@"Start Recording"])
    {
        [self.micButton setTitle:@"Recording" forState:UIControlStateNormal];
    }
    else{
        [self.micButton setTitle:@"Start Recording" forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
