//
//  ImageLoader.h
//  loadBigMemoryImage
//
//  Created by 王玉松 on 2025/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageLoader : NSObject

+ (UIImage *)loadLargeImageWithPath:(NSString *)imagePath;
+ (UIImage *)decodedImageWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
