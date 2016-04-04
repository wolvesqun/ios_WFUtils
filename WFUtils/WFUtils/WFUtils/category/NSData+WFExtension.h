//
//  NSData+WFExtension.h
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (WFExtension)

@end

// 加密相关
@interface NSData (WFCryptUtil)

- (NSData*)AES256EncryptWithKey:(NSString*)key;

- (NSData*)AES256DecryptWithKey:(NSString*)key;

@end
