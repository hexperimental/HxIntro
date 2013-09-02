//
//  HxIntro.m
//  
//
//  Created by Antonio Perez on 2013-09-02.
//  Copyright (c) 2013 Hexperimental. All rights reserved.
//

#import "HxIntro.h"

@interface HxIntro ()
@property (nonatomic,retain) UIImage *introImage;
@property (nonatomic,retain) UIImageView *defaultImageView;
@property (nonatomic,retain) UIImageView *introImageView;
@property (nonatomic,retain) UILabel *versionLable;
@property (nonatomic,retain) NSTimer *introTimer;
@property int delay;
@end

@implementation HxIntro

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
        self.hideVersion = NO;
        self.touchToSkip = YES;
        self.dismissModalTransitionStyle = -1;
        self.defaultFade = UIViewAnimationTransitionNone;
        self.introImage = [UIImage imageNamed:imageName];

        self.introImageView = [[UIImageView alloc] initWithImage:self.introImage];
        self.introImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(didTapImage:)];
        [self.introImageView addGestureRecognizer:myTapGesture];
        self.defaultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
        
        if(![[UIApplication sharedApplication] isStatusBarHidden]){
            self.defaultImageView.frame = CGRectMake(0, -20, self.defaultImageView.frame.size.width,self.defaultImageView.frame.size.height);
        }
        //self.defaultImageView.frame.size.height
        
        
        
        
        float margin =10;
        float lbl_w = [[UIScreen mainScreen] bounds].size.width-(margin*2);
        float lbl_h = 50;
        float lbl_y = [[UIScreen mainScreen] bounds].size.height - ( lbl_h+margin );
        self.versionLable = [[UILabel alloc] initWithFrame:CGRectMake(margin,lbl_y,lbl_w,lbl_h)];
        [self.versionLable setBackgroundColor:[UIColor clearColor]];
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *appVersion = [bundle objectForInfoDictionaryKey:(NSString *)@"CFBundleShortVersionString"];
        NSString *appBuildNumber = [bundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        
        [self.versionLable setFont:[UIFont fontWithName:@"Arial" size:12]];
        [self.versionLable setTextColor:[UIColor grayColor]];
        [self.versionLable setText:[NSString stringWithFormat:@"%@ (%@)", appVersion,appBuildNumber]];
        self.versionLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.defaultImageView];
        [self.view addSubview:self.versionLable];
        [self.versionLable setHidden:YES];
    }
    return self;
}


-(void)didTapImage:(UITapGestureRecognizer *)gesture {
    if(self.touchToSkip) {
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
}

-(void)show {
    if(DISPLAYED){return;}
    DISPLAYED = YES;
    [self.view bringSubviewToFront:self.versionLable];


    
    [(UIViewController *)self.delegate presentViewController:self animated:NO completion:NULL];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(hideDefault:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)hideDefault:(NSTimer *)timer {
    [self.view addSubview:self.introImageView];
    [self.view bringSubviewToFront:self.versionLable];
    
    [UIView transitionWithView:self.view
                      duration:0.5f
                       options:self.defaultFade
                    animations:^{
                        self.defaultImageView.image = self.introImage;
                    } completion:nil];
    
    [self.versionLable setHidden:self.hideVersion];
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
    if(self.dismissModalTransitionStyle==-1){
        [self dismissViewControllerAnimated:NO completion:NULL];
    }else{
        [self setModalTransitionStyle:self.dismissModalTransitionStyle];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
