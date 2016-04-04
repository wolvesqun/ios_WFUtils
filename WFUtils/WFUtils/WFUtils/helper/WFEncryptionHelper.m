//
//  WFEncryptionHelper.m
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFEncryptionHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+WFExtension.h"

@implementation WFEncryptionHelper

+ (NSString *)md5:(NSString *)key
{
    const char * cStrValue = [key UTF8String];
    unsigned char theResult[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStrValue, (uint32_t)strlen(cStrValue), theResult);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            theResult[0], theResult[1], theResult[2], theResult[3],
            theResult[4], theResult[5], theResult[6], theResult[7],
            theResult[8], theResult[9], theResult[10], theResult[11],
            theResult[12], theResult[13], theResult[14], theResult[15]];
}

+ (NSData*)AES256Encrypt:(NSString*)strSource andKey:(NSString*)key {
    NSData *dataSource = [strSource dataUsingEncoding:NSUTF8StringEncoding];
    return [dataSource AES256EncryptWithKey:[WFEncryptionHelper md5:key]];
}

+ (NSString*)AES256Decrypt:(NSData*)dataSource andKey:(NSString*)key {
    NSData *decryptData = [dataSource AES256DecryptWithKey:[WFEncryptionHelper md5:key]];
    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}


@end
