//
//  HxIntroViewController.h
//  inviteList
//
//  Created by Antonio Perez on 2013-09-02.
//  Copyright (c) 2013 Hexperimental. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HxIntroDelegate;

@interface HxIntroViewController : UIViewController

@property (nonatomic,assign) id <HxIntroDelegate> delegate;


-(id)initWithImageNamed:(NSString *)imageName andDelay:(int)delay;
-(void)show;

@end


@protocol HxIntroDelegate <NSObject>

-(void)introDidTouch;

@end

