//
//  RueConfigModel.m
//  linphone
//
//  Created by Zack Matthews on 2/23/16.
//
//

#import "RueConfigModel.h"
#import "LinphoneManager.h"

@implementation RueConfigModel
#pragma mark Constants
const NSString *VERSION_KEY=@"version";

const NSString *CONFIG_DICT_KEY=@"config";
const NSString *CONFIG_TOKEN_KEY=@"token";
const NSString *CONFIG_EXPIRATION_KEY=@"expiration";

const NSString *ACCOUNT_DICT_KEY=@"accounts";
const NSString *ACCOUNT_LABEL_KEY=@"label";

const NSString *ACCOUNT_SIP_DICT_KEY=@"sip";
const NSString *ACCOUNT_SIP_REGISTRAR_DICT_KEY=@"registrar";
const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_DICT_KEY=@"auth";
const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_USERNAME_KEY=@"username";
const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_REALM_KEY=@"realm";
const NSString *ACCOUNT_SIP_REGISTRAR_AUTH_PASSWORD_KEY=@"password";

const NSString *ACCOUNT_SIP_REGISTRAR_USER_KEY=@"user";
const NSString *ACCOUNT_SIP_REGISTRAR_DOMAIN_KEY=@"domain";
const NSString *ACCOUNT_SIP_REGISTRAR_PORT_KEY=@"port";

const NSString *ACCOUNT_SIP_REGISTRAR_TAGS_DICT=@"tags";
const NSString *ACCOUNT_SIP_REGISTRAR_TAGS_TRANSPORT_KEY=@"transport";
const NSString *ACCOUNT_SIP_REGISTRAR_OUTBOUND_PROXY_KEY=@"outbound_proxy";

const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY=@"outbound_proxy";
const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_DICT_KEY=@"auth";
const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_USERNAME_KEY=@"username";
const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_REALM_KEY=@"realm";
const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_PASSWORD_KEY=@"password";

const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_DOMAIN_KEY=@"domain";
const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_PORT_KEY=@"port";
const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_DICT_KEY=@"tags";
const NSString *ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_TRANSPORT_KEY=@"transport";


const NSString *ACCOUNT_ICE_DICT_KEY=@"ice";
const NSString *ACCOUNT_ICE_SERVERS_DICT_KEY=@"servers";
const NSString *ACCOUNT_ICE_STUN_SERVER_URL_KEY=@"url";
const NSString *ACCOUNT_ICE_TURN_SERVER_URL_KEY=@"url";
const NSString *ACCOUNT_ICE_TURN_SERVER_USERNAME_KEY=@"username";
const NSString *ACCOUNT_ICE_TURN_SERVER_CREDENTIAL_KEY=@"credential";


const NSString *MEDIA_DICT_KEY=@"media";
const NSString *MEDIA_CODECS_DICT_KEY=@"codecs";
const NSString *MEDIA_CODECS_AUDIO_KEY=@"audio";
const NSString *MEDIA_CODECS_VIDEO_KEY=@"video";

#pragma mark Constructors
-(id)init{
    self = [super init];
    if(self){
    }
    return self;
}
-(id)initFromNSDictionary:(NSDictionary*)dict{
    self = [super init];
    if(self){
        [self parseConfigFromDict:dict];
    }
    return self;
}

-(id)initFromNSUserDefaults{
    self = [super init];
    if(self){
    }
    return self;
}

#pragma mark Persistence
-(NSUserDefaults*)getDefaults{
    return [NSUserDefaults standardUserDefaults];
}
-(LinphoneCore*)getLc{
    if([LinphoneManager getLc]){
        return [LinphoneManager getLc];
    }
    //May throw null pointer. Always use sanity checks!
    return nil;
}
#pragma mark Helpers
-(NSString*)constructPersistenceKeyFromPathKeys:(NSArray*)keys{
    if(!keys)return @"";
    
    NSString *finalKey=@"";
    for(NSObject *key in keys){
        finalKey = [NSString stringWithFormat:@"%@/%@",finalKey, key];
    }
    return finalKey;
}
-(void)parseConfigFromDict:(NSDictionary*)dict{
    if(!dict) return;
    NSObject *value;

    //Version
    value = ([[dict allKeys] containsObject:VERSION_KEY]) ? [dict objectForKey:VERSION_KEY] : nil;
    [self setVersion:(NSNumber*)value];

    //Config (token, expiry)
    NSDictionary *configDict =([[dict allKeys] containsObject:CONFIG_DICT_KEY]) ? [dict objectForKey:CONFIG_DICT_KEY] : nil;
    if(configDict){
        //Token
        value =([[configDict allKeys] containsObject:CONFIG_TOKEN_KEY]) ? [configDict objectForKey:CONFIG_TOKEN_KEY] : nil;
        [self setConfigToken:value];
     
        //Expiration
        value =([[configDict allKeys] containsObject:CONFIG_EXPIRATION_KEY]) ? [configDict objectForKey:CONFIG_EXPIRATION_KEY] : nil;
        [self setConfigExpiration:(NSNumber*)value];
    }
    
    //Accounts
    NSDictionary *accountDict = ([[dict allKeys] containsObject:ACCOUNT_DICT_KEY]) ? [dict objectForKey:ACCOUNT_DICT_KEY] : nil;
    if(accountDict){ //Account Label
        value =([[accountDict allKeys] containsObject:ACCOUNT_LABEL_KEY]) ? [accountDict objectForKey:ACCOUNT_LABEL_KEY] : nil;
        [self setAccountLabel:(NSString*)value];
        
        /****** SIP *******/
        NSDictionary *sipDict = ([[accountDict allKeys] containsObject:ACCOUNT_SIP_DICT_KEY]) ? [accountDict objectForKey:ACCOUNT_SIP_DICT_KEY] : nil;
        if(sipDict){
            NSDictionary *registrarDict = ([[sipDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_DICT_KEY]) ? [sipDict objectForKey:ACCOUNT_SIP_REGISTRAR_DICT_KEY] : nil;
            
            value = ([[registrarDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_USER_KEY]) ? [registrarDict objectForKey:ACCOUNT_SIP_REGISTRAR_USER_KEY] : nil;
            [self setAccountSipRegistrarUser:(NSString*)value];
            
            value = ([[registrarDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_DOMAIN_KEY]) ? [registrarDict objectForKey:ACCOUNT_SIP_REGISTRAR_DOMAIN_KEY] : nil;
            [self setAccountSipRegistrarDomain:(NSString*)value];
            
            value = ([[registrarDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_PORT_KEY]) ? [registrarDict objectForKey:ACCOUNT_SIP_REGISTRAR_PORT_KEY] : nil;
            [self setAccountSipRegistrarPort:(NSNumber*)value];
            
            value = ([[registrarDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_OUTBOUND_PROXY_KEY]) ? [registrarDict objectForKey:ACCOUNT_SIP_REGISTRAR_OUTBOUND_PROXY_KEY] : nil;
            [self setAccountSipRegistrarOutboundProxy:value];
            
            if(registrarDict){ //Registrar
                NSDictionary *authDict = ([[registrarDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_AUTH_DICT_KEY]) ? [registrarDict objectForKey:ACCOUNT_SIP_REGISTRAR_AUTH_DICT_KEY] : nil;
                if(authDict){ //Auth
                    value =([[authDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_AUTH_USERNAME_KEY]) ? [authDict objectForKey:ACCOUNT_SIP_REGISTRAR_AUTH_USERNAME_KEY] : nil;
                    [self setAccountSipRegistrarAuthUsername:(NSString*)value];
                    
                    value =([[authDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_AUTH_REALM_KEY]) ? [authDict objectForKey:ACCOUNT_SIP_REGISTRAR_AUTH_REALM_KEY] : nil;
                    [self setAccountSipRegistrarAuthRealm:(NSString*)value];
                    
                    value =([[authDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_AUTH_PASSWORD_KEY]) ? [authDict objectForKey:ACCOUNT_SIP_REGISTRAR_AUTH_PASSWORD_KEY] : nil;
                    [self setAccountSipRegistrarAuthPassword:(NSString*)value];
                }
                //Registrar Tags
                NSDictionary *registrarTagsDict = ([[registrarDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_TAGS_DICT]) ? [registrarDict objectForKey:ACCOUNT_SIP_REGISTRAR_TAGS_DICT] : nil;
                if(registrarTagsDict){ //Transport
                    value = ([[registrarTagsDict allKeys] containsObject:ACCOUNT_SIP_REGISTRAR_TAGS_TRANSPORT_KEY]) ? [registrarTagsDict objectForKey:ACCOUNT_SIP_REGISTRAR_TAGS_TRANSPORT_KEY] : nil;
                    [self setAccountSipRegistrarTagsTransport:(NSString*)value];
                }
            }
            /****** OUTBOUND PROXY *******/
            NSDictionary *outboundProxyDict = ([[sipDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY]) ? [sipDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY] : nil;
            
            if(outboundProxyDict){ //Outbound proxy
                value = ([[outboundProxyDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_DOMAIN_KEY]) ? [outboundProxyDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_DOMAIN_KEY] : nil;
                [self setAccountSipOutboundProxyDomain:(NSString*)value];
                
                value = ([[outboundProxyDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_PORT_KEY]) ? [outboundProxyDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_PORT_KEY] : nil;
                [self setAccountSipOutboundProxyPort:(NSNumber*)value];
                
                NSDictionary *authDict = ([[outboundProxyDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_DICT_KEY]) ? [outboundProxyDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_DICT_KEY] : nil;
                if(authDict){ //Auth
                    value =([[authDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_USERNAME_KEY]) ? [authDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_USERNAME_KEY] : nil;
                    [self setAccountSipOutboundProxyAuthUsername:(NSString*)value];
                    
                    value =([[authDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_REALM_KEY]) ? [authDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_REALM_KEY] : nil;
                    [self setAccountSipOutboundProxyAuthRealm:(NSString*)value];
                    
                    value =([[authDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_PASSWORD_KEY]) ? [authDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_PASSWORD_KEY] : nil;
                    [self setAccountSipOutboundProxyAuthPassword:(NSString*)value];
                }
                //Outbound proxy tags
                NSDictionary *outboundProxyTagsDict = ([[registrarDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_DICT_KEY]) ? [registrarDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_DICT_KEY] : nil;
                if(outboundProxyTagsDict){
                    value = ([[outboundProxyTagsDict allKeys] containsObject:ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_TRANSPORT_KEY]) ? [outboundProxyTagsDict objectForKey:ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_TRANSPORT_KEY] : nil;
                    [self setAccountSipOutboundProxyTagsTransport:(NSString*)value];
                }
            }
            
            /****** ICE *******/
            NSDictionary *iceDict =([[accountDict allKeys] containsObject:ACCOUNT_ICE_DICT_KEY]) ? [accountDict objectForKey:ACCOUNT_ICE_DICT_KEY] : nil;
            if(iceDict){
                NSDictionary *iceServers = ([[iceDict allKeys] containsObject:ACCOUNT_ICE_SERVERS_DICT_KEY]) ? [iceDict objectForKey:ACCOUNT_ICE_SERVERS_DICT_KEY] : nil;
                if(iceServers){

                }
            }
            /****** MEDIA CODECS *******/
            NSDictionary *mediaDict =([[accountDict allKeys] containsObject:MEDIA_DICT_KEY]) ? [accountDict objectForKey:MEDIA_DICT_KEY] : nil;
            if(mediaDict){
                NSDictionary *mediaCodecsDict = ([[mediaDict allKeys] containsObject:MEDIA_CODECS_DICT_KEY]) ? [mediaDict objectForKey:MEDIA_CODECS_DICT_KEY] : nil;
                if(mediaCodecsDict){
                    NSArray *audioCodecs = ([[mediaCodecsDict allKeys] containsObject:MEDIA_CODECS_AUDIO_KEY]) ? [mediaCodecsDict objectForKey:MEDIA_CODECS_AUDIO_KEY] : nil;
                    [self setMediaCodecsAudio:audioCodecs];
                    
                    NSArray *videoCodecs = ([[mediaCodecsDict allKeys] containsObject:MEDIA_CODECS_VIDEO_KEY]) ? [mediaCodecsDict objectForKey:MEDIA_CODECS_VIDEO_KEY] : nil;
                    [self setMediaCodecsVideo:videoCodecs];
                }
            }
        }
    }
}
//todo: add defaults and linphone core settings
#pragma mark Setters
-(void)setVersion:(NSNumber*)version{
    if(!version){ version = @2; }
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[VERSION_KEY]];
    [[self getDefaults] setObject:version forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, version);
}

-(void)setConfigToken:(NSObject*)token{
    if(!token){ token = @""; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[CONFIG_DICT_KEY, CONFIG_TOKEN_KEY]];
    [[self getDefaults] setObject:token forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, token);
}
-(void)setConfigExpiration:(NSNumber*)expiration{
    if(!expiration){ expiration = @280; }
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[CONFIG_DICT_KEY, CONFIG_EXPIRATION_KEY]];
    [[self getDefaults] setObject:expiration forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, expiration);
}

-(void)setAccountLabel:(NSString*)label{
    if(!label){ label = @""; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_LABEL_KEY]];
    [[self getDefaults] setObject:label forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, label);
}

-(void)setAccountSipRegistrarAuthUsername:(NSString*)authUsername{
    if(!authUsername){ authUsername = @""; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_AUTH_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_AUTH_USERNAME_KEY]];
    [[self getDefaults] setObject:authUsername forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, authUsername);
}
-(void)setAccountSipRegistrarAuthRealm:(NSString*)realm{
    if(!realm){ realm = @""; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_AUTH_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_AUTH_REALM_KEY]];
    [[self getDefaults] setObject:realm forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, realm);
}
-(void)setAccountSipRegistrarAuthPassword:(NSString*)password{
    if(!password){ password = @""; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_AUTH_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_AUTH_PASSWORD_KEY]];
    [[self getDefaults] setObject:password forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, password);
}

-(void)setAccountSipRegistrarUser:(NSString*)user{
    if(!user){ user = @""; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_USER_KEY]];
    [[self getDefaults] setObject:user forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, user);
}
-(void)setAccountSipRegistrarDomain:(NSString*)domain{
    if(!domain){ domain = @""; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DOMAIN_KEY]];
    [[self getDefaults] setObject:domain forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, domain);
}
-(void)setAccountSipRegistrarPort:(NSNumber*)port{
    if(!port){ port = @5060; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_PORT_KEY]];
    [[self getDefaults] setObject:port forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, port);
}

-(void)setAccountSipRegistrarTagsTransport:(NSString *)transport{
    if(!transport){ transport = @"tcp"; };
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_TAGS_DICT,
                                                                ACCOUNT_SIP_REGISTRAR_TAGS_TRANSPORT_KEY]];
    [[self getDefaults] setObject:transport forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, transport);
    
}
-(void)setAccountSipRegistrarOutboundProxy:(BOOL)useOutboundProxy{
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_DICT_KEY,
                                                                ACCOUNT_SIP_REGISTRAR_OUTBOUND_PROXY_KEY]];
    [[self getDefaults] setBool:useOutboundProxy forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%d", key, useOutboundProxy);
    
}

-(void)setAccountSipOutboundProxyAuthUsername:(NSString*)authUsername{
    if(!authUsername) authUsername = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_DICT_KEY,
                                                            ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_USERNAME_KEY]];
    [[self getDefaults] setObject:authUsername forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, authUsername);
}
-(void)setAccountSipOutboundProxyAuthRealm:(NSString*)realm{
    if(!realm) realm = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_REALM_KEY]];
    [[self getDefaults] setObject:realm forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, realm);
    
}
-(void)setAccountSipOutboundProxyAuthPassword:(NSString*)password{
    if(!password) password = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_AUTH_PASSWORD_KEY]];
    [[self getDefaults] setObject:password forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, password);
    
}

-(void)setAccountSipOutboundProxyDomain:(NSString*)domain{
    if(!domain) domain = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_DOMAIN_KEY]];
    [[self getDefaults] setObject:domain forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, domain);
}
-(void)setAccountSipOutboundProxyPort:(NSNumber*)port{
    if(!port) port = @5060;
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_PORT_KEY]];
    [[self getDefaults] setObject:port forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, port);
}
-(void)setAccountSipOutboundProxyTagsTransport:(NSString*)transport{
    if(!transport) transport = @"tcp";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_SIP_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_DICT_KEY,
                                                                ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_DICT_KEY,
                                                            ACCOUNT_SIP_OUTBOUND_PROXY_TAGS_TRANSPORT_KEY]];
    [[self getDefaults] setObject:transport forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, transport);
}

-(void)setAccountICEStunServerURL:(NSString*)url{
    if(!url) url = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_ICE_DICT_KEY,
                                                                ACCOUNT_ICE_SERVERS_DICT_KEY, @"stun",ACCOUNT_ICE_STUN_SERVER_URL_KEY]];
    [[self getDefaults] setObject:url forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, url);
    
}
-(void)setAccountICETurnServerURL:(NSString*)url{
    if(!url) url = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_ICE_DICT_KEY,
                                                                ACCOUNT_ICE_SERVERS_DICT_KEY, @"turn",ACCOUNT_ICE_TURN_SERVER_URL_KEY]];
                     [[self getDefaults] setObject:url forKey:key];
                     [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, url);
    
}
-(void)setAccountICETurnServerUsername:(NSString*)username{
    if(!username) username = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_ICE_DICT_KEY,
                                                                ACCOUNT_ICE_SERVERS_DICT_KEY, @"turn",ACCOUNT_ICE_TURN_SERVER_USERNAME_KEY]];
    [[self getDefaults] setObject:username forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, username);
    
}
-(void)setAccountICETurnServerCredential:(NSString*)credential{
    if(!credential) credential = @"";
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, ACCOUNT_ICE_DICT_KEY,
                                                                ACCOUNT_ICE_SERVERS_DICT_KEY, @"turn",ACCOUNT_ICE_TURN_SERVER_CREDENTIAL_KEY]];
    [[self getDefaults] setObject:credential forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, credential);
}

-(void)setMediaCodecsAudio:(NSArray*)codecs{
    if(!codecs) codecs = @[@"G.722", @"PCMU", @"PCMA"];
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, MEDIA_DICT_KEY,
                                                                MEDIA_CODECS_DICT_KEY, MEDIA_CODECS_AUDIO_KEY]];
    [[self getDefaults] setObject:codecs forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, codecs);
    
}
-(void)setMediaCodecsVideo:(NSArray*)codecs{
    if(!codecs) codecs = @[@"H.264", @"H.263", @"VP8"];
    NSString *key = [self constructPersistenceKeyFromPathKeys:@[ACCOUNT_DICT_KEY, MEDIA_DICT_KEY,
                                                                MEDIA_CODECS_DICT_KEY, MEDIA_CODECS_VIDEO_KEY]];
    [[self getDefaults] setObject:codecs forKey:key];
    [[self getDefaults] synchronize];
    NSLog(@"%@:%@", key, codecs);
}
@end
