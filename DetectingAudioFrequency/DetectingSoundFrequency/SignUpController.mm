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
@property (strong,nonatomic) UIImageView *huluImage;
@property (strong,nonatomic) UIImageView *triviaImage;
@property (nonatomic, assign) id currentResponder;
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
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
   
    self.userName=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width/2-125, 175, 250, 50)];
    [self.userName setTextAlignment:NSTextAlignmentCenter];
    [self.userName setText:@"anubhaw.arya@hulu.com"];
    [self.userName setBackground:[AppConstants imageWithColor:[UIColor whiteColor]]];
    [self.userName.layer setCornerRadius:6.0];
    [self.userName.layer setBorderWidth:1.0];
    [self.userName setClipsToBounds:YES];
    [self.userName.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.userName addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:self.userName];
    
    self.submitBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitBtn.frame=CGRectMake(screenRect.size.width/4, 237.5, 175, 35);
    [self.submitBtn setTitle:@"Register" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundColor:[UIColor clearColor]];
    [self.submitBtn.layer setCornerRadius:6.0];
    [self.submitBtn.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.submitBtn.layer setBorderWidth:2.5];
    [self.view addSubview:self.submitBtn];
    
    self.huluImage=[[UIImageView alloc]initWithFrame:CGRectMake(80, 75, 160, 50)];
    [self.huluImage setImage:[UIImage imageNamed:@"huluImage"]];
    [self.view addSubview:self.huluImage];
    
    self.triviaImage=[[UIImageView alloc]initWithFrame:CGRectMake(177.5, 110, 85, 25)];
    [self.triviaImage setImage:[UIImage imageNamed:@"triviaImage"]];
    [self.view addSubview:self.triviaImage];
}

-(void) btnPressed:(id) sender{
    [[NSUserDefaults standardUserDefaults] setValue:self.userName.text forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    ViewController *second = [ViewController alloc];
    [self presentViewController:second animated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}
- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
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
