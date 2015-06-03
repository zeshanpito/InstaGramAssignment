//
//  PIOFlickrViewController.m
//  InstagramIntegration
//
//  Created by Zeshan Hayder on 02/06/2015.
//  Copyright (c) 2015 PITO. All rights reserved.
//

#import "PIOFlickrViewController.h"
#import "FlickrKit.h"
#import "PIOFlickrAuthenticationViewController.h"

@interface PIOFlickrViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) FKDUNetworkOperation *authenticationOperation;
- (IBAction)loginButtonPressed:(id)sender;

@end

@implementation PIOFlickrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"a0c0704df53eccedb50c6c218a482144" sharedSecret:@"89fcc7f8e0cf0416"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"UserAuthCallbackNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Auth

- (void) userAuthenticateCallback:(NSNotification *)notification {
    NSURL *callbackURL = notification.object;
    self.authenticationOperation = [[FlickrKit sharedFlickrKit] completeAuthWithURL:callbackURL completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSLog(@"%@----%@",userName, userId);
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
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
    if (![FlickrKit sharedFlickrKit].isAuthorized) {
        PIOFlickrAuthenticationViewController *authentication = [PIOFlickrAuthenticationViewController new];
        [self.navigationController pushViewController:authentication animated:YES];
    }
}
@end
