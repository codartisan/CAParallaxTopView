//
//  CAMainViewController.m
//  CAParallaxTopView
//
//  Created by Xiao Ma on 2/17/2014.
//  Copyright (c) 2014 Xiao Ma. All rights reserved.
//

#import "CAMainViewController.h"

@interface CAMainViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *foregroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *transparentView;
@end

@implementation CAMainViewController

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
    // Do any additional setup after loading the view from its nib.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Test";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:155/255. alpha:.5];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0];
    self.navigationController.navigationBar.translucent = YES;
    
    self.foregroundView.delegate = self;
    
    self.backgroundView.contentSize = CGSizeMake(960, 200);
    self.foregroundView.contentSize = CGSizeMake(320, 568);
    
    self.foregroundView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.foregroundView.contentOffset = CGPointMake(0, -100);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.foregroundView.frame = CGRectMake(0, 64, 320, CGRectGetHeight(self.foregroundView.frame) - 64);
    
    self.transparentView.contentSize = self.backgroundView.contentSize;
    
    [self.transparentView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.backgroundView.contentOffset = self.transparentView.contentOffset;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y < -200) {
        self.backgroundView.frame = CGRectMake((scrollView.contentOffset.y + 200), 0, 320 - (scrollView.contentOffset.y + 200)*2, 300 * (320 - (scrollView.contentOffset.y + 200)*2)/320);
        NSLog(@"x:%f, y:%f, width:%f, height:%f", self.backgroundView.frame.origin.x, self.backgroundView.frame.origin.y, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height);
    } else {
        self.backgroundView.frame = CGRectMake(0, -(scrollView.contentOffset.y + 200) * 0.2, 320, CGRectGetHeight(self.backgroundView.frame));
    }
}

@end
