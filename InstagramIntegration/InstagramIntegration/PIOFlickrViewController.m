//
//  PIOFlickrViewController.m
//  InstagramIntegration
//
//  Created by Zeshan Hayder on 02/06/2015.
//  Copyright (c) 2015 PITO. All rights reserved.
//

#import "PIOFlickrViewController.h"
#import "FlickrKit.h"

@interface PIOFlickrViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtonPressed:(id)sender;

@end

@implementation PIOFlickrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"a0c0704df53eccedb50c6c218a482144" sharedSecret:@"89fcc7f8e0cf0416"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonPressed:(id)sender {
    
}
@end
