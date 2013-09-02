//
//  ViewController.m
//  HxIntroViewDemo
//
//  Created by Antonio Perez on 2013-09-02.
//  Copyright (c) 2013 Hexperimental. All rights reserved.
//

#import "ViewController.h"
#import "HxIntro.h"

@interface ViewController ()
@property (nonatomic,retain) HxIntro *introView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.introView = [[HxIntro alloc] initWithImageNamed:@"introScreen" andDelay:5000];
    self.introView.delegate = self;
    self.introView.hideVersion = NO;  //Default: NO;
    self.introView.touchToSkip = YES;  //Default: YES;
    self.introView.dismissModalTransitionStyle = UIModalTransitionStyleCrossDissolve; //Default : None
    self.introView.defaultFade = UIViewAnimationOptionTransitionCrossDissolve; //Default : None
    
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.introView show];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
