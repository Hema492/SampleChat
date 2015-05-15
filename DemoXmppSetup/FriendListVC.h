//
//  FriendListVC.h
//  DemoXmppSetup
//
//  Created by shiv vaishnav on 19/08/14.
//  Copyright (c) 2014 Ranosys Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FriendListVC : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
}
@end
