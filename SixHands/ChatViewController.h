//
//  ChatViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/8/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"
#import "LeanMessageManager.h"
#import "NSUserDefaults+DemoSettings.h"
#import "JSQMessagesViewController.h" 
#import "JSQMessages.h"
@interface ChatViewController : JSQMessagesViewController <JSQMessagesCollectionViewDataSource, JSQMessagesCollectionViewDelegateFlowLayout, UIActionSheetDelegate>
@property (nonatomic,strong) AVIMConversation *conversation;
@end
