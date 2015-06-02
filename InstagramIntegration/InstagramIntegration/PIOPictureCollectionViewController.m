//
//  PictureCollectionViewController.m
//  InstagramIntegration
//
//  Created by Zeshan Hayder on 29/05/2015.
//  Copyright (c) 2015 PITO. All rights reserved.
//

#import "PIOPictureCollectionViewController.h"
#import "PIOLoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "PIOMediaCollectionViewCell.h"
#import "InstagramEngine.h"
#import "InstagramMedia.h"
#import "InstagramUser.h"
#import "InstagramKit.h"

@interface PIOPictureCollectionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) InstagramPaginationInfo *currentPaginationInfo;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)loginButtonPressed:(id)sender;
@end

@implementation PIOPictureCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*[self.collectionView registerClass:[MediaCollectionViewCell class] forCellWithReuseIdentifier:@"instaGramCell"];*/

    UINib *cellNib = [UINib nibWithNibName:@"MediaCollectionViewCell" bundle:nil];
    //[self.collectionView registerNib:cellNib forCellReuseIdentifier:@"instaGramCell"];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"instaGramCell"];
    self.images = [[NSMutableArray alloc] init];
    
}
- (IBAction)reloadMediaFromScratch
{
    self.currentPaginationInfo = nil;
    if (self.images) {
        [self.images removeAllObjects];
    }
    
    [self loadMedia];
}

- (void)loadMedia
{
    
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
- (void)reloadMedia
{
    NSLog(@"buhahaha");
    //lets get the images from online instagram
    InstagramEngine *sharedEngine = [InstagramEngine sharedEngine];
    
    if (sharedEngine.accessToken)
    {
        NSLog(@"%@",sharedEngine.accessToken);
        
        [[InstagramEngine sharedEngine] getSelfFeedWithCount:9 maxId:self.currentPaginationInfo.nextMaxId success:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
            self.currentPaginationInfo = paginationInfo;
            if (self.images.count>0) {
                [self.images removeAllObjects];
            }
            [self.images addObjectsFromArray:media];

            [self.collectionView reloadData];
        } failure:^(NSError *error, NSInteger statusCode) {
            NSLog(@"Request Self Feed Failed");
        }];
    }
    
}

- (IBAction)loginButtonPressed:(id)sender {
    PIOLoginViewController *loginViewController = [PIOLoginViewController new];
    loginViewController.pictureViewController = self;
    [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
}


#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PIOMediaCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"instaGramCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    InstagramMedia *media = self.images[indexPath.row];
    //NSLog(@"%@",media);
    
    [cell.instagramImageView setImageWithURL:media.thumbnailURL];
    /*NSURLRequest *request = [NSURLRequest requestWithURL:media.thumbnailURL];
    [cell.instagramImageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       cell.instagramImageView.image = image;
                                       [cell setNeedsLayout];
                                       
                                   } failure:nil];*/
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
@end
