//
//  DLXMPPManager.h
//  DLXMPPFrame
//
//  Created by DalinXie on 17/1/11.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLXMPPManager : NSObject

+(instancetype)sharedManager;

//loginMethod

-(void)loginWithJID:(XMPPJID *)jid password:(NSString *)password;

-(void)RegisterWithJID:(XMPPJID *)jid password:(NSString *)password;

@end
