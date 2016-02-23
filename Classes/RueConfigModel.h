//
//  RueConfigModel.h
//  linphone
//
//  Created by Zack Matthews on 2/23/16.
//
//

#import <Foundation/Foundation.h>

@interface RueConfigModel : NSObject
extern const NSString *VERSION_KEY;

extern const NSString *CONFIG_DICT_KEY;
extern const NSString *CONFIG_TOKEN_KEY;
extern const NSString *CONFIG_EXPIRATION_KEY;

extern const NSString *CONFIG_TOKEN_KEY;

extern const NSString *ACCOUNT_DICT_KEY;
extern const NSString *ACCOUNT_LABEL_KEY;

extern const NSString *ACCOUNT_SIP_DICT_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_DICT_KEY;

extern const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_DICT_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_USERNAME_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_REALM_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_PASSWORD_KEY;

extern const NSString *ACCOUNT_SIP_REGISTRAR_USER_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_DOMAIN_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_PORT_KEY;

extern const NSString *ACCOUNT_SIP_REGISTRAR_TAGS_DICT;
extern const NSString *ACCOUNT_SIP_REGISTRAR_TAGS_TRANSPORT_KEY;
extern const NSString *ACCOUNT_SIP_REGISTRAR_OUTBOUND_PROXY_KEY;

extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY;
extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_DICT_KEY;
extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_USERNAME_KEY;
extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_REALM_KEY;
extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_PASSWORD_KEY;

extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_DOMAIN_KEY;
extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_PORT_KEY;
extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_DICT_KEY;
extern const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_TRANSPORT_KEY;

extern const NSString *ACCOUNT_ICE_DICT_KEY;
extern const NSString *ACCOUNT_ICE_SERVERS_DICT_KEY;
extern const NSString *ACCOUNT_ICE_STUN_SERVER_URL_KEY;
extern const NSString *ACCOUNT_ICE_TURN_SERVER_URL_KEY;
extern const NSString *ACCOUNT_ICE_TURN_SERVER_USERNAME_KEY;
extern const NSString *ACCOUNT_ICE_TURN_SERVER_CREDENTIAL_KEY;

extern const NSString *MEDIA_DICT_KEY;
extern const NSString *MEDIA_CODECS_DICT_KEY;
extern const NSString *MEDIA_CODECS_AUDIO_KEY;
extern const NSString *MEDIA_CODECS_VIDEO_KEY;

-(id)initFromNSDictionary:(NSDictionary*)dict;

-(void)setVersion:(NSNumber*)version;

-(void)setConfigToken:(NSObject*)token;
-(void)setConfigExpiration:(NSNumber*)expiration;

-(void)setAccountLabel:(NSString*)label;

-(void)setAccountSipRegistrarAuthUsername:(NSString*)authUsername;
-(void)setAccountSipRegistrarAuthRealm:(NSString*)realm;
-(void)setAccountSipRegistrarAuthPassword:(NSString*)password;

-(void)setAccountSipRegistrarUser:(NSString*)user;
-(void)setAccountSipRegistrarDomain:(NSString*)domain;
-(void)setAccountSipRegistrarPort:(NSNumber*)port;

-(void)setAccountSipRegistrarTagsTransport:(NSString *)transport;
-(void)setAccountSipRegistrarOutboundProxy:(BOOL)useOutboundProxy;

-(void)setAccountSipOutboundProxyAuthUsername:(NSString*)authUsername;
-(void)setAccountSipOutboundProxyAuthRealm:(NSString*)realm;
-(void)setAccountSipOutboundProxyAuthPassword:(NSString*)password;

-(void)setAccountSipOutboundProxyDomain:(NSString*)domain;
-(void)setAccountSipOutboundProxyPort:(NSNumber*)port;
-(void)setAccountSipOutboundProxyTagsTransport:(NSString*)transport;

-(void)setAccountICEStunServerURL:(NSString*)url;
-(void)setAccountICETurnServerURL:(NSString*)url;
-(void)setAccountICETurnServerUsername:(NSString*)username;
-(void)setAccountICETurnServerCredential:(NSString*)credential;

-(void)setMediaCodecsAudio:(NSArray*)codecs;
-(void)setMediaCodecsVideo:(NSArray*)codecs;
@end
