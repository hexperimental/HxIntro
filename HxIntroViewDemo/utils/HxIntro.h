//
//  HxIntro.h
//  
//
//  Created by Antonio Perez on 2013-09-02.
//  Copyright (c) 2013 Hexperimental. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HxIntroDelegate;

@interface HxIntro : UIViewController

@property (nonatomic,assign) id <HxIntroDelegate> delegate;
@property BOOL hideVersion;
@property BOOL touchToSkip;

@property UIModalTransitionStyle dismissModalTransitionStyle;
@property UIViewAnimationOptions defaultFade;
-(id)initWithImageNamed:(NSString *)imageName andDelay:(int)delay;
-(void)show;

@end


@protocol HxIntroDelegate <NSObject>

-(void)introDidTouch;

@end

