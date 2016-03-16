//
//  ChatViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/8/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageDisplayKit/XHPhotographyHelper.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MessageDisplayKit/XHDisplayMediaViewController.h"

@interface ChatViewController ()
@property (nonatomic,strong) XHPhotographyHelper *photographyHelper;
@property (nonatomic, strong) NSMutableArray *displayMessages;
@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;
@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;
@end

@implementation ChatViewController {
    NSMutableArray *messages;
    JSQMessagesBubbleImage *incomingBubbleImage;
    JSQMessagesBubbleImage *outcomingBubbleImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.senderId = [[LeanMessageManager manager] selfClientID];
    self.senderDisplayName = [self displayNameByClientId:self.senderId];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if( [self.inputToolbar.contentView.textView isFirstResponder] )
    {
        [self.inputToolbar.contentView.textView resignFirstResponder];
    } 
}

- (void)didPressAccessoryButton:(UIButton *)sender;
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Добавление медиа-файлов"
                                                       delegate:self
                                              cancelButtonTitle:@"Закрыть"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Фото", @"Местоположение", @"Видео", nil];
    
    [sheet showFromToolbar:self.inputToolbar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    WEAKSELF
    void (^PickerMediaBlock)(UIImage *image, NSDictionary *editingInfo) = ^(UIImage *image, NSDictionary *editingInfo) {
        if (image) {
            [weakSelf didSendMessageWithPhoto:image];
        } else {
            if (!editingInfo)
                return ;
            NSString *mediaType = [editingInfo objectForKey: UIImagePickerControllerMediaType];
            NSString *videoPath;
            NSURL *videoUrl;
            if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
                videoUrl = (NSURL*)[editingInfo objectForKey:UIImagePickerControllerMediaURL];
                videoPath = [videoUrl path];
                [weakSelf didSendMessageWithVideoPath:videoPath];
            } else {
                [weakSelf didSendMessageWithPhoto:[editingInfo valueForKey:UIImagePickerControllerOriginalImage]];
            }
        }
    };
    
    switch (buttonIndex) {
        case 0:
            [self.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:self compled:PickerMediaBlock];
            break;
        case 1:{
            [self didSendMessageWithLatitude:0 longitude:0];
        }break;
            
        case 2:
            [self.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self compled:PickerMediaBlock];
            break;
    }
    
}

-(NSString*)fetchDataOfMessageFile:(AVFile*)file fileName:(NSString*)fileName error:(NSError**)error{
    NSString* path=[[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:fileName];
    NSData* data=[file getData:error];
    if(*error==nil){
        [data writeToFile:path atomically:YES];
    }
    return path;
}

-(JSQMessage*)displayMessageByAVIMTypedMessage:(AVIMTypedMessage*)typedMessage{
    AVIMMessageMediaType msgType = typedMessage.mediaType;
    JSQMessage *message;
    NSDate* timestamp=[NSDate dateWithTimeIntervalSince1970:typedMessage.sendTimestamp/1000];
    NSString *senderId=typedMessage.clientId;
    NSString *senderDisplayName=[self displayNameByClientId:senderId];
    BOOL outgoing=[self.senderId isEqualToString:typedMessage.clientId];
    switch (msgType) {
        case kAVIMMessageMediaTypeText: {
            AVIMTextMessage *receiveTextMessage = (AVIMTextMessage *)typedMessage;
            message=[[JSQMessage alloc] initWithSenderId:typedMessage.clientId senderDisplayName:senderDisplayName date:timestamp text:receiveTextMessage.text];
            break;
        }
        case kAVIMMessageMediaTypeImage: {
            AVIMImageMessage *imageMessage = (AVIMImageMessage *)typedMessage;
            NSError *error;
            NSData *data=[imageMessage.file getData:&error];
            UIImage *image=[UIImage imageWithData:data];
            JSQPhotoMediaItem *photoItem=[[JSQPhotoMediaItem alloc] initWithImage:image];
            photoItem.appliesMediaViewMaskAsOutgoing=outgoing;
            message=[[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:timestamp media:photoItem];
            break;
        }
        case kAVIMMessageMediaTypeVideo:{
            AVIMVideoMessage* receiveVideoMessage=(AVIMVideoMessage*)typedMessage;
            NSString* format=receiveVideoMessage.format;
            NSError* error;
            NSString* path=[self fetchDataOfMessageFile:typedMessage.file fileName:[NSString stringWithFormat:@"%@.%@",typedMessage.messageId,format] error:&error];
            NSURL *videoURL = [NSURL fileURLWithPath:path];
            JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
            videoItem.appliesMediaViewMaskAsOutgoing=outgoing;
            message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:timestamp media:videoItem];
            break;
        }
        case kAVIMMessageMediaTypeLocation:{
            WEAKSELF
            AVIMLocationMessage *locationMessage=(AVIMLocationMessage*)typedMessage;
            CLLocation *location = [[CLLocation alloc] initWithLatitude:locationMessage.location.latitude longitude:locationMessage.location.longitude];
            JSQLocationMediaItem *locationItem = [[JSQLocationMediaItem alloc] init];
            [locationItem setLocation:location withCompletionHandler:^{
                [weakSelf.collectionView reloadData];
            }];
            locationItem.appliesMediaViewMaskAsOutgoing=outgoing;
            message=[[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:timestamp media:locationItem];
        }
        default:
            break;
    }
    return message;
}

-(BOOL)filterError:(NSError*)error{
    if(error){
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:nil message:error.description delegate:nil
                                cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}

-(void)addMessage:(AVIMTypedMessage*)message completion:(dispatch_block_t)completion{
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JSQMessage *displayMessage=[self displayMessageByAVIMTypedMessage:message];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.displayMessages addObject:displayMessage];
            completion();
        });
    });
}

-(XHPhotographyHelper*)photographyHelper{
    if(_photographyHelper==nil){
        _photographyHelper=[[XHPhotographyHelper alloc] init];
    }
    return _photographyHelper;
}

-(void)sendMessage:(AVIMTypedMessage*)message{
    WEAKSELF
    [self.conversation sendMessage:message callback:^(BOOL succeeded, NSError *error) {
        [JSQSystemSoundPlayer jsq_playMessageSentSound];
        if([ weakSelf filterError:error]){
            [ weakSelf addMessage:message completion:^{
                [weakSelf finishSendingMessageAnimated:YES];
            }];
        }
    }];
}
-(void)didSendMessageWithPhoto:(UIImage*)photo{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"tmp.jpg"];
    NSData* photoData=UIImageJPEGRepresentation(photo,1.0);
    [photoData writeToFile:filePath atomically:YES];
    AVIMImageMessage *message = [AVIMImageMessage messageWithText:nil attachedFilePath:filePath attributes:nil];
    [self sendMessage:message];
}

-(void)didSendMessageWithVideoPath:(NSString*)path{
    AVIMVideoMessage* message=[AVIMVideoMessage messageWithText:nil attachedFilePath:path attributes:nil];
    [self sendMessage:message];
}

-(void)didSendMessageWithLatitude:(long)latitude longitude:(long)longitude{
    AVIMLocationMessage *message=[AVIMLocationMessage messageWithText:@"北京" latitude:39.f longitude:116.f attributes:nil];
    [self sendMessage:message];
}

- (NSString*)displayNameByClientId:(NSString*)clientId{
    return clientId;
}
@end
