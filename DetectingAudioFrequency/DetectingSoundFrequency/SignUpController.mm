//
//  SignUpController.m
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 7/31/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "SignUpController.h"

@interface SignUpController ()
@property (strong,nonatomic) UITextField *userName;
@property (strong,nonatomic) UIButton *submitBtn;
@end

@implementation SignUpController

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
   
    self.userName=[[UITextField alloc]initWithFrame:CGRectMake(0, screenRect.size.height/4, screenRect.size.width, 30)];
    [self.userName setTextAlignment:NSTextAlignmentCenter];
    [self.userName setText:@"anubhaw.arya@hulu.com"];
    [self.userName addTarget:self action:@selector(textFieldShouldBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:self.userName];
    
    self.submitBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitBtn.frame=CGRectMake(screenRect.size.width/4, self.userName.frame.origin.y+self.userName.frame.size.height, screenRect.size.width/2, screenRect.size.height/8);
    [self.submitBtn setTitle:@"Register" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
}

-(void) btnPressed:(id) sender{
    [[NSUserDefaults standardUserDefaults] setValue:self.userName.text forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    ViewController *second = [ViewController alloc];
    [self presentViewController:second animated:YES completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor redColor]CGColor];
    textField.layer.borderWidth= 1.0f;
    return YES;
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
