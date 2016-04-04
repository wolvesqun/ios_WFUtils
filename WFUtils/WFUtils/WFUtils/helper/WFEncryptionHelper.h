//
//  WFEncryptionHelper.h
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  加密解密工具类
 */
@interface WFEncryptionHelper : NSObject


+ (NSString *)md5:(NSString *)key;

#pragma mark - AES 加密与解密
+ (NSData*)AES256Encrypt:(NSString*)strSource andKey:(NSString*)key;
+ (NSString*)AES256Decrypt:(NSData*)dataSource andKey:(NSString*)key;

@end
