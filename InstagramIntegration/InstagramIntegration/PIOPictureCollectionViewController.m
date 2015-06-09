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
@property (nonatomic, strong) InstagramEngine *instagramEngine;
@property (weak, nonatomic) IBOutlet UIButton *uploadImageButton;
@property (nonatomic, strong) UIDocumentInteractionController *documentController;

- (IBAction)uploadImageButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;

@end

@implementation PIOPictureCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*[self.collectionView registerClass:[MediaCollectionViewCell class] forCellWithReuseIdentifier:@"instaGramCell"];*/

    UINib *cellNib = [UINib nibWithNibName:@"PIOMediaCollectionViewCell" bundle:nil];
    //[self.collectionView registerNib:cellNib forCellReuseIdentifier:@"instaGramCell"];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"instaGramCell"];
    self.images = [[NSMutableArray alloc] init];
    self.instagramEngine = [InstagramEngine sharedEngine];
    
    [self fetchMediaImagesFromInstaGram];
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
    [self fetchMediaImagesFromInstaGram];
}

- (void)fetchMediaImagesFromInstaGram
{
    if (self.instagramEngine.accessToken)
    {
        [self.instagramEngine getSelfFeedWithCount:15 maxId:self.currentPaginationInfo.nextMaxId success:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
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

- (IBAction)uploadImageButtonPressed:(id)sender {
    NSString* imagePath = [NSString stringWithFormat:@"%@/images.igo", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    
    UIImage *instagramImage = [UIImage imageNamed:@"images"];
    [UIImagePNGRepresentation(instagramImage) writeToFile:imagePath atomically:YES];
    NSLog(@"Image Size >>> %@", NSStringFromCGSize(instagramImage.size));
    
    self.documentController=[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
    self.documentController.delegate = self;
    self.documentController.UTI = @"com.instagram.exclusivegram";
    [self.documentController presentOpenInMenuFromRect: self.view.frame inView:self.view animated:YES ];
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
    
    //[cell.instagramImageView setImageWithURL:media.thumbnailURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:media.thumbnailURL];
    [cell.instagramImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
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
