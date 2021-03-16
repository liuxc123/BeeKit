//
//  UIImage+ImageCompress.h
//  UIIImageCompressExample
//
//  Created by Abraham Kuri on 12/12/13.
//  Copyright (c) 2013 Icalia Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageCompress)

/*
 *  压缩图片方法(先压缩质量再压缩尺寸)
 */
- (NSData *)compressWithLengthLimit:(NSUInteger)maxLength;

/*
 *  压缩图片方法(压缩质量)
 */
- (NSData *)compressQualityWithLengthLimit:(NSInteger)maxLength;

/*
 *  压缩图片方法(压缩质量二分法)
 */
- (NSData *)compressMidQualityWithLengthLimit:(NSInteger)maxLength;

/*
 *  压缩图片方法(压缩尺寸)
 */
- (NSData *)compressBySizeWithLengthLimit:(NSUInteger)maxLength;

@end
