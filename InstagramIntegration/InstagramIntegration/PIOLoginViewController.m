//
//  PIOMediaViewController.m
//  InstagramIntegration
//
//  Created by Zeshan Hayder on 29/05/2015.
//  Copyright (c) 2015 PITO. All rights reserved.
//

#import "PIOLoginViewController.h"
#import "InstagramKit.h"

@interface PIOLoginViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PIOLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupWebView
{
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.scrollView.bounces = NO;
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
    self.webView.delegate = self;
    
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizarionURLForScope:IKLoginScopeBasic];
    [self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLString = [request.URL absoluteString];
    if ([URLString rangeOfString:@"putitout.co.uk"].location == NSNotFound) {
        return NO;
    } else {
        NSString *delimiter = @"access_token=";
        NSArray *components = [URLString componentsSeparatedByString:delimiter];
        if (components.count > 1) {
            NSString *accessToken = [components lastObject];
            NSLog(@"ACCESS TOKEN = %@",accessToken);
            [[InstagramEngine sharedEngine] setAccessToken:accessToken];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self.pictureViewController reloadMedia];
            }];
        }
    }
    
    
    /*if ([URLString hasPrefix:[[InstagramEngine sharedEngine] appRedirectURL]]) {
        NSString *delimiter = @"access_token=";
        NSArray *components = [URLString componentsSeparatedByString:delimiter];
        if (components.count > 1) {
            NSString *accessToken = [components lastObject];
            NSLog(@"ACCESS TOKEN = %@",accessToken);
            [[InstagramEngine sharedEngine] setAccessToken:accessToken];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self.pictureViewController reloadMedia];
            }];
        }
        return NO;
    }*/
    return YES;
}

@end
