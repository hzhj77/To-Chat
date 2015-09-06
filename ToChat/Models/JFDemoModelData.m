//
//  JFDemoModelData.m
//  ChatUITest
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 jft0m. All rights reserved.
//

#import "JFDemoModelData.h"

@implementation JFDemoModelData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self loadFakeMessages];
        
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    }
    
    return self;
}


- (void)loadFakeMessages
{
    /**
     *  Load some fake messages for demo.
     *
     *  You should have a mutable array or orderedSet, or something.
     */
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithSenderId:kJFDemoAvatarIdWoz
                                        senderDisplayName:kJFDemoAvatarDisplayNameWoz
                                                     date:[NSDate distantPast]
                                                     text:@"Welcome to JSQMessages: A messaging UI framework for iOS."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJFDemoAvatarIdJon
                                        senderDisplayName:kJFDemoAvatarDisplayNameJon
                                                     date:[NSDate distantPast]
                                                     text:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJFDemoAvatarIdWoz
                                        senderDisplayName:kJFDemoAvatarDisplayNameWoz
                                                     date:[NSDate distantPast]
                                                     text:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJFDemoAvatarIdJon
                                        senderDisplayName:kJFDemoAvatarDisplayNameJon
                                                     date:[NSDate date]
                                                     text:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better."],
                     nil];
    
    JSQMessagesAvatarImage *jonImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"ToChat"]
                                                                                   diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
    
    JSQMessagesAvatarImage *wofImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"ToChat"]
                                                                                   diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
    
    self.avatars = @{ kJFDemoAvatarIdJon : jonImage,
                      kJFDemoAvatarIdWoz : wofImage};
    
    [self addPhotoMediaMessage];
    
}

- (void)addPhotoMediaMessage
{
    JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageNamed:@"goldengate"]];
    JSQMessage *photoMessage = [JSQMessage messageWithSenderId:kJFDemoAvatarIdJon
                                                   displayName:kJFDemoAvatarDisplayNameJon
                                                         media:photoItem];
    
    JSQPhotoMediaItem *photoItemInComming = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageNamed:@"goldengate"]];
    JSQMessage *photoMessageInComming = [JSQMessage messageWithSenderId:kJFDemoAvatarIdWoz
                                                   displayName:kJFDemoAvatarDisplayNameWoz
                                                         media:photoItemInComming];
    photoItemInComming.appliesMediaViewMaskAsOutgoing = NO;
    
    [self.messages addObject:photoMessage];
    [self.messages addObject:photoMessageInComming];
    
}

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion
{
    CLLocation *ferryBuildingInSF = [[CLLocation alloc] initWithLatitude:37.795313 longitude:-122.393757];
    
    JSQLocationMediaItem *locationItem = [[JSQLocationMediaItem alloc] init];
    [locationItem setLocation:ferryBuildingInSF withCompletionHandler:completion];
    
    JSQMessage *locationMessage = [JSQMessage messageWithSenderId:kJFDemoAvatarIdWoz
                                                      displayName:kJFDemoAvatarDisplayNameWoz
                                                            media:locationItem];
    [self.messages addObject:locationMessage];
}

- (void)addVideoMediaMessage
{
    // don't have a real video, just pretending
    NSURL *videoURL = [NSURL URLWithString:@"file://"];
    
    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:kJFDemoAvatarIdJon
                                                   displayName:kJFDemoAvatarDisplayNameJon
                                                         media:videoItem];
    [self.messages addObject:videoMessage];
}


@end
