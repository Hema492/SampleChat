//
//  ViewController.h
//  DemoXmppSetup
//
//  Created by shiv vaishnav on 14/08/14.
//  Copyright (c) 2014 Ranosys Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "XMPPFramework.h"

@interface ViewController : UIViewController
@property (nonatomic,retain) XMPPUserCoreDataStorageObject *userDetail;
@end
