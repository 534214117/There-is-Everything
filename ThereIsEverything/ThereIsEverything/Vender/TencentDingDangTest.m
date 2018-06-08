//
//  TencentDingDangTest.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/2/7.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "TencentDingDangTest.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonHMAC.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#define iPhoneUUID [[[[UIDevice currentDevice].identifierForVendor UUIDString] componentsSeparatedByString:@"-"] componentsJoinedByString:@""]

@implementation TencentDingDangTest

+ (void)test {
    
    [TencentDingDangTest signWithSigningContent:@"This is signing-content" signingKey:@"bot_secret"];
    
    NSString *Botkey = @"8c1016f0-1c84-4446-a3d4-f04fde3610a8";
    NSString *BotSecret = @"cd424483685d4db1bcd422394eefc2db";
    
    NSDictionary *postDataDictonary = @{@"header": @{
                                                @"guid": iPhoneUUID,
                                                @"qua": @"QV=3&PL=IOS&PR=Test&VE=LAB&VN=0.1.0.1000&PP=com.Mine.ThereIsEverything&DE=PHONE&CHID=app_channel_id",
                                                @"ip": [TencentDingDangTest getIPAddress:YES]
                                                },
                                        @"payload": @{
                                                @"query": @"心肺复苏"
                                                }
                                        };
    NSString *postData = [TencentDingDangTest DictionaryToJsonString:postDataDictonary];
    NSString *credentialDate = [TencentDingDangTest getTime];
    
    NSString *signingContent = [NSString stringWithFormat:@"%@%@", postData, credentialDate];
    
    NSString *signature = [TencentDingDangTest signWithSigningContent:signingContent signingKey:BotSecret];
    NSString *authorizationHeader = [NSString stringWithFormat:@"TVS-HMAC-SHA256-BASIC CredentialKey=%@, Datetime=%@, Signature=%@", Botkey, credentialDate, signature];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://aiwx.html5.qq.com/api/v1/richanswer"]];
    request.HTTPBody = [postData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:authorizationHeader forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"%@", responseObject);
        NSLog(@"%@", error);
    }];
    
    [task resume];
    
}

+ (NSString *)getTime {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd HHmmss"];
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSArray *temp = [currentDateString componentsSeparatedByString:@" "];
    currentDateString = [NSString stringWithFormat:@"%@T%@Z", temp[0], temp[1]];
    NSLog(@"%@", currentDateString);
    
    return currentDateString;
}

+ (NSString *)signWithSigningContent:(NSString *)signingContent signingKey:(NSString *)signingKey {
    
    const char *key = [signingKey cStringUsingEncoding:NSUTF8StringEncoding];
    const char *data = [signingContent cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, key, strlen(key), data, strlen(data), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *sign = [TencentDingDangTest convertDataToHexStr:hash];
    NSLog(@"%@", sign);
    
    return sign;
}


+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}


+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([self isValidatIP:address]) *stop = YES;
     } ];
    
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)DictionaryToJsonString:(NSDictionary *)data {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}




@end
