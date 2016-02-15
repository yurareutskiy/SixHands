//
//  ChatViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/8/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ChatViewController.h"


@interface ChatViewController ()

@end

@implementation ChatViewController {
    NSMutableArray *messages;
    JSQMessagesBubbleImage *incomingBubbleImage;
    JSQMessagesBubbleImage *outcomingBubbleImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *navBarFont = [UIFont fontWithName:@"Lato-Light" size:15];
    self.navigationController.navigationBar.titleTextAttributes =  @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                     NSFontAttributeName:navBarFont};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = 100;
    self.navigationItem.rightBarButtonItems = @[item];
    // Do any additional setup after loading the view.
    self.senderDisplayName = @"user1";
    self.senderId = @"1";
    
    UIView *status = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    status.backgroundColor = [UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0];
    [self.view addSubview:status];

    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.
    
    incomingBubbleImage = [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:[UIImage imageNamed:@"light_grey_messages"] highlightedImage:[UIImage imageNamed:@"light_grey_messages"]];
    outcomingBubbleImage = [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:[UIImage imageNamed:@"dark_grey_messages"] highlightedImage:[UIImage imageNamed:@"dark_grey_messages"]];

    messages = [[NSMutableArray alloc] init];

    [self addDemoMessages];
}

-(void)viewWillAppear:(BOOL)animated {
//    incomingBubbleImage = [[JSQMessagesBubbleImageFactory alloc] incomingMessagesBubbleImageWithColor:[UIColor blueColor]];
//    outcomingBubbleImage = [[JSQMessagesBubbleImageFactory alloc] incomingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - Delegate


- (NSString *)senderDisplayName {
    return @"Юра";
}


- (NSString *)senderId {
    return @"1";
}




- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date text:text];
    [messages addObject:message];
    [self finishSendingMessage];
    NSLog(@"%@", message);
}

- (void)addDemoMessages {
    for (int i = 0; i < 10; i++) {
        NSString *sender = (i % 2 == 0) ? @"Server" : self.senderId;
        NSString *messageContent = @"Message nr. \(i)";
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:sender senderDisplayName:sender date:[NSDate date] text:messageContent];
        [messages addObject:message];
    }
    [self.collectionView reloadData];
}

#pragma mark - Data Source

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.avatarContainerView.layer.cornerRadius = cell.avatarContainerView.frame.size.height / 2;
    cell.avatarContainerView.layer.masksToBounds = YES;
    cell.textView.textColor = [UIColor blackColor];
    cell.textView.font = [UIFont fontWithName:@"Lato-Regular" size:16];
    cell.messageBubbleContainerView.layer.cornerRadius = 5;
    cell.messageBubbleContainerView.layer.masksToBounds = YES;
//    cell.
//    cell.backgroundColor = [UIColor redColor];
    // Customize the shit out of this cell
    // See the docs for JSQMessagesCollectionViewCell
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [messages count];
}

-(id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = messages[indexPath.row];
    return message;
}


- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath {
    [messages removeObjectAtIndex:indexPath.row];
}


- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = messages[indexPath.row];
    if ([message.senderId isEqualToString:@"Server"]) {
        return outcomingBubbleImage;
    } else {
        return incomingBubbleImage;
    }
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesAvatarImage *avatar = [JSQMessagesAvatarImage avatarWithImage:[UIImage imageNamed:@"avatar3"]];
    return avatar;
}

@end
