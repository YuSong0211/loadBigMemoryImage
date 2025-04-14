//
//  ImageLoader.m
//  loadBigMemoryImage
//
//  Created by 王玉松 on 2025/4/14.
//

#import "ImageLoader.h"
#import <ImageIO/ImageIO.h>

@implementation ImageLoader
/*
 1.创建CGImageSourceCreateWihtURL从指定的URL创建图像源
 2.定义选项字典：
    创建一个包含缩略图选项的字典
     kCGImageSourceCreateThumbnailWithTransform:
     当设置为 @YES 时，生成的缩略图将应用图像的变换（如旋转），确保缩略图的方向与原图一致。
     kCGImageSourceCreateThumbnailFromImageAlways:

     当设置为 @YES 时，始终从源图像创建缩略图，即使源图像已经是缩略图。
     kCGImageSourceThumbnailMaxPixelSize:

     设置生成的缩略图的最大尺寸（以像素为单位）。在这个例子中，最大尺寸为 1024 像素。生成的缩略图将根据此限制进行缩放。
 3.创建缩略图:
 
     使用 CGImageSourceCreateThumbnailAtIndex 创建缩略图，传入图像源和选项字典。
 
 */

+ (UIImage *)loadLargeImageWithPath:(NSString *)imagePath {
    // 创建图片源
    NSURL *imageFileURL = [NSURL fileURLWithPath:imagePath];
    //CGImageSourceCreateWithURL 是 Core Graphics 框架中的一个函数，用于从指定的 URL 创建一个 CGImageSourceRef 对象。这个对象可以用于读取图像数据，支持多种图像格式（如 JPEG、PNG、GIF 等）
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)imageFileURL, NULL);
    if (!source) {
        return nil;
    }
    
    // 设置图片加载选项
    NSDictionary *options = @{
        (NSString *)kCGImageSourceCreateThumbnailWithTransform: @YES,
        (NSString *)kCGImageSourceCreateThumbnailFromImageAlways: @YES,
        (NSString *)kCGImageSourceThumbnailMaxPixelSize: @(1024) // 限制最大尺寸
    };
    
    // 创建缩略图
    CGImageRef thumbnailRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef)options);
    CFRelease(source);
    
    if (!thumbnailRef) {
        return nil;
    }
    
    // 创建UIImage并进行解码
    UIImage *image = [UIImage imageWithCGImage:thumbnailRef];
    CGImageRelease(thumbnailRef);
    return image;
    // 返回解码后的图片
//    return [self decodedImageWithImage:image];
}

+ (UIImage *)decodedImageWithImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    
    // 创建绘图上下文
    CGSize imageSize = CGSizeMake(image.size.width, image.size.height);
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:imageSize];
    
    // 在后台解码图片
    UIImage *decodedImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    }];
    
    return decodedImage;
}

@end
