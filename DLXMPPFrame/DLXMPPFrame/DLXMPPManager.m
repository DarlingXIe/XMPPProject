//
//  DLXMPPManager.m
//  DLXMPPFrame
//
//  Created by DalinXie on 17/1/11.
//  Copyright © 2017年 itdarlin. All rights reserved.
//
/*
    9090
    9091
 */
#import "DLXMPPManager.h"

static DLXMPPManager * _instance;

@interface DLXMPPManager()<XMPPStreamDelegate>

@property (nonatomic, strong) XMPPStream *xmppStream;

@property (nonatomic, getter=isRegisterCount) BOOL registerCount;

@property (nonatomic, copy) NSString * password;

@end

@implementation DLXMPPManager

+(instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self new];
    });
    return _instance;
}
#pragma mark-1.login
-(void)loginWithJID:(XMPPJID *)jid password:(NSString *)password{
    
    self.xmppStream.hostName = @"127.0.0.1";
    self.xmppStream.hostPort = 5222;
    self.xmppStream.myJID = jid;
    self.password = password;
    if([self.xmppStream connectWithTimeout:-1 error:nil])
        {
            NSLog(@"connect successful");
        }
}
#pragma mark-2.authenticate the login information
//验证用户登陆成功失败
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"验证成功");
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"验证失败");
    NSLog(@"错误信息--%@", error);
}
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    
    if(self.registerCount){
        NSError * err = nil;
        [self.xmppStream registerWithPassword:self.password error:&err];
        NSLog(@"%@", err);
    }else{
        NSLog(@"connect successful");
        if([self.xmppStream authenticateWithPassword:self.password error:nil]){
        NSLog(@"验证请求发送成功");
        }
    }
}
#pragma mark- register
-(void)RegisterWithJID:(XMPPJID *)jid password:(NSString *)password{
    
    self.registerCount = true;
    [self loginWithJID:jid password:password];
    
}
#pragma mark-2.authenticate the register information
//验证用户登注册成功失败
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功");
}
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"注册失败");
    NSLog(@"错误信息--%@", error);
}

-(XMPPStream *)xmppStream{
    if(!_xmppStream){
        _xmppStream = [XMPPStream new];
        [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _xmppStream;
}

@end
