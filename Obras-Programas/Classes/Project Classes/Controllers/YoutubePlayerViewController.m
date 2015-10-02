//
//  YoutubePlayerViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras on 25/07/15.
//  Copyright (c) 2015 Edicomex. All rights reserved.
//

#import "YoutubePlayerViewController.h"
#import "YTPlayerView.h"


@interface YoutubePlayerViewController ()

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

@end

@implementation YoutubePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.playerView loadWithVideoId:@"WJ77SzW_XQM"];

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

@end
