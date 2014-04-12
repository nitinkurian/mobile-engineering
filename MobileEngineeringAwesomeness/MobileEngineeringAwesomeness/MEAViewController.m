//
//  MEAViewController.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEAViewController.h"
#import "MEAModel.h"
#import "MEACollectionViewCell.h"
#import "MEADeal.h"
#import "MEAUser.h"
#import "MEAAvatar.h"
#import "MEAWebViewController.h"

@interface MEAViewController ()

@property (nonatomic, strong) NSArray *deals;
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) MEAWebViewController *webviewController;

@end

@implementation MEAViewController

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    ;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    ;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        return YES;
    }
    return NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.deals = [[NSArray alloc] init];
    self.cache = [[NSCache alloc] init];
    // Override point for customization after application launch.
    
    MEAModel *dealModel = [[MEAModel alloc] init];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    self.pageControl.hidden = YES;
    [dealModel getAllDealsWithCompletionBlock:^(id JSON, NSError *error) {
        [spinner stopAnimating];
        if (!error) {
            self.pageControl.hidden = NO;

            self.deals = (NSArray *)JSON;
            self.pageControl.numberOfPages = self.deals.count;
            self.pageControl.currentPage = 0;
            // Add a target that will be invoked when the page control is
            // changed by tapping on it
            [self.pageControl addTarget:self
                                 action:@selector(pageControlChanged:)
                       forControlEvents:UIControlEventValueChanged];
            [self.collectionView reloadData];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.collectionView.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
    [self.collectionView setContentOffset:scrollTo animated:YES];
}

#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEADeal *deal = [self.deals objectAtIndex:indexPath.row];

    MEACollectionViewCell* newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell"
                                                                                forIndexPath:indexPath];
    [newCell initializeWithAttrib:deal.attrib desc:deal.desc href:deal.href];
    
    //add deal image to cache if not present else load asynchrnously
    newCell.imageView.image = nil;
    if ([self.cache objectForKey:deal.src]) {
        newCell.imageView.image = [self.cache objectForKey:deal.src];
    }
    else {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = [newCell.superview convertPoint:newCell.center toView:newCell];
        spinner.hidesWhenStopped = YES;
        [newCell addSubview:spinner];
        [spinner startAnimating];
        [deal getImage:^(UIImage *image, NSError *error) {
            [self.cache setObject:image forKey:deal.src];
            newCell.imageView.image = image;
            [spinner stopAnimating];
            [spinner removeFromSuperview];
        }];
    }
    
    //Add avatar to imagecache if not there
    self.nameLabel.text = deal.user.name;
    self.avatar.image = nil;
    if ([self.cache objectForKey:deal.user.avatar.src]) {
        self.avatar.image = [self.cache objectForKey:deal.user.avatar.src];
    }
    else {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = [[self.avatar superview] convertPoint:self.avatar.center toView:self.avatar];
        spinner.hidesWhenStopped = YES;
        [self.avatar addSubview:spinner];
        [spinner startAnimating];
        [deal.user.avatar getImage:^(UIImage *image, NSError *error) {
            [self.cache setObject:image forKey:deal.user.avatar.src];
            self.avatar.image = image;
            [spinner stopAnimating];
            [spinner removeFromSuperview];
        }];
    }
    
    return newCell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    if (!self.webviewController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.webviewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    }
    
    MEADeal *deal = [self.deals objectAtIndex:indexPath.row];
    self.webviewController.loadUrl = deal.href;

    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:self.webviewController];
    [self presentViewController:controller animated:YES completion:^{
        cell.backgroundColor = [UIColor whiteColor];
    }];
    

    
}



@end
