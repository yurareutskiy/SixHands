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
    
    UIFont *navBarFont = [UIFont fontWithName:@"Lato-Regular" size:15];
    self.navigationController.navigationBar.titleTextAttributes =  @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                     NSFontAttributeName:navBarFont};
    UIImageView *talkFriendPhoto = [[UIImageView alloc] initWithImage:[self imageWithImage:[UIImage imageNamed:@"avatar3"] scaledToSize:CGSizeMake(30, 30)]];
    talkFriendPhoto.layer.cornerRadius = 15;
    talkFriendPhoto.layer.masksToBounds = YES;
    talkFriendPhoto.layer.borderWidth = 0.5;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:talkFriendPhoto];
    item.width = 40;
    self.navigationItem.rightBarButtonItems = @[item];
    if ([self.navigationItem.title length] == 0) {
        self.navigationItem.title = @"Нежинская улица, дом 9";
    }
    
    
    
    // Do any additional setup after loading the view.
    self.senderDisplayName = @"user1";
    self.senderId = @"1";
    
    UIView *status = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    status.backgroundColor = [UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0];
    [self.view addSubview:status];

    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light_grey_messages"]];
//    self.collectionView.
    
    incomingBubbleImage = [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:[UIImage imageNamed:@"message_white"] highlightedImage:[UIImage imageNamed:@"message_white"]];
    outcomingBubbleImage = [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:[UIImage imageNamed:@"message_green"] highlightedImage:[UIImage imageNamed:@"message_green"]];

    messages = [[NSMutableArray alloc] init];
    
    self.collectionView.collectionViewLayout.messageBubbleFont = [UIFont fontWithName:@"Lato-Regular" size:14.f];
//    self.collectionView.collectionViewLayout.bubbleSizeCalculator = self;

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
        NSString *messageContent = @"Я захожу в Facebook, чтобы делиться с близкими всем подряд — и опытом занятий йогой, и горем от смерти одного из родителей. Тем, с кем я этим делюсь, тоже есть, что сказать о себе. Иногда нам нужен простой способ сообщить, что нам нравятся записи друг друга или выразить сопереживание.";
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:sender senderDisplayName:sender date:[NSDate date] text:messageContent];
        [messages addObject:message];
    }
    [self.collectionView reloadData];
}

#pragma mark - Data Source

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    cell.avatarContainerView.layer.cornerRadius = cell.avatarContainerView.frame.size.height / 2;
//    cell.avatarContainerView.layer.masksToBounds = YES;
    cell.textView.textColor = [UIColor blackColor];
    cell.textView.font = [UIFont fontWithName:@"Lato-Regular" size:14];
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
    return nil;        
}

- (CGSize)messageBubbleSizeForMessageData:(id<JSQMessageData>)messageData
                              atIndexPath:(NSIndexPath *)indexPath
                               withLayout:(JSQMessagesCollectionViewFlowLayout *)layout {
    NSString *text = @"Ребят,ксожалениюиз-затого,чтонагрянулапраздникиисубботавосновномрабочая,";
    float height = [self labelHehghtForText:text];
    return CGSizeMake(280, height);

}

#pragma mark - Supporting methods


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (float)labelHehghtForText:(NSString*)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 0)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    label.attributedText = attributedString;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    //    label.text = text;
    label.font = [UIFont fontWithName:@"Lato-Regular" size:14.f];
    [label sizeToFit];
    float textHeight = label.frame.size.height;
    return textHeight + 5;
}

@end
