//
//  HxIntroViewController.m
//  inviteList
//
//  Created by Antonio Perez on 2013-09-02.
//  Copyright (c) 2013 Hexperimental. All rights reserved.
//

#import "HxIntroViewController.h"

@interface HxIntroViewController ()
@property (nonatomic,retain) UIImage *introImage;
@property (nonatomic,retain) UIImageView *defaultImageView;
@property (nonatomic,retain) UIImageView *introImageView;
@property (nonatomic,retain) NSTimer *introTimer;
@property int delay;
@end

@implementation HxIntroViewController

static bool DISPLAYED=NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithImageNamed:(NSString *)imageName andDelay:(int)timerDelay{
    self = [super init];
    if (self) {
        // Custom initialization
        self.delay = timerDelay;
        
        self.introImage = [UIImage imageNamed:imageName];
        UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(didTapImage:)];
        self.introImageView = [[UIImageView alloc] initWithImage:self.introImage];
        self.introImageView.userInteractionEnabled = YES;
        [self.introImageView addGestureRecognizer:myTapGesture];
        
        self.defaultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
        [self.view addSubview:self.defaultImageView];
    }
    return self;
}


-(void)didTapImage:(UITapGestureRecognizer *)gesture {
    @try{
        if (self.delegate && [self.delegate respondsToSelector:@selector(introDidTouch)]){
            [self.delegate introDidTouch];
        }
    }
    @catch (NSException *e){
        // invalid delegate
    }
    [self hide];    
}

-(void)show {
    if(DISPLAYED){return;}
    DISPLAYED = YES;
    [(UIViewController *)self.delegate presentViewController:self animated:NO completion:NULL];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(hideDefault:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)hideDefault:(NSTimer *)timer {
    [self.view addSubview:self.introImageView];
    self.introTimer = [NSTimer scheduledTimerWithTimeInterval:(self.delay/1000)
                                     target:self
                                   selector:@selector(hideIntroView:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)hideIntroView:(NSTimer *)timer {
    [self hide];
}


-(void)hide {
    [self.introTimer invalidate];
    [self dismissViewControllerAnimated:NO completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
