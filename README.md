# HxIntro
** HxIntro is a graceful way to dismiss the Default.png image with an option to display a custom 'Intro image' before loading the app  **

## How to use

Include HxIntro.h and .m files into your project. 



``` objective-c

#import "HxIntro.h"
/* .... */

/* .... */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.introView = [[HxIntro alloc] initWithImageNamed:@"introScreen" andDelay:5000];
    self.introView.delegate = self;
    self.introView.hideVersion = NO;  //Default: NO;
    self.introView.touchToSkip = NO;  //Default: YES;    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.introView show];
}
```


### Available settings

``` objective-c
    // Hides the "Version (build)" Label  
    self.introView.hideVersion = NO;  //Default: NO;
    // If Yes will dismiss the custom intro image when touched.
    self.introView.touchToSkip = NO;  //Default: YES; 
    self.introView.dismissModalTransitionStyle = UIModalTransitionStyleCrossDissolve; //Default : None
    self.introView.defaultFade = UIViewAnimationOptionTransitionCrossDissolve; //Default : None    
```



## Contact

HxIntro is available under the MIT license. See the LICENSE file for more info.
- http://github.com/hexperimental
- http://hexperimental.com
