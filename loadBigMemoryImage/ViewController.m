//
//  ViewController.m
//  loadBigMemoryImage
//
//  Created by 王玉松 on 2025/4/14.
//

#import "ViewController.h"
#import "ImageLoader.h"
@interface ViewController ()
@property (nonatomic, strong)  UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 300, 300)];
    imageView.backgroundColor = UIColor.blueColor;
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touchesBegan");
    self.imageView.image = nil;
    // 获取图片路径
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"bigMemoryImage" ofType:@"JPG"];
    
    // 加载图片
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
//    image = [self resizeImage:image targetSize:CGSizeMake(300, 300)];
//    image = [self scaleImage:image maxDimension:300];
    image = [ImageLoader loadLargeImageWithPath:imagePath];
    self.imageView.image = image;
}

- (UIImage *)resizeImage:(UIImage *)image targetSize:(CGSize)targetSize {
    CGSize size = image.size;
    
    CGFloat widthRatio = targetSize.width / size.width;
    CGFloat heightRatio = targetSize.height / size.height;
    
    CGSize newSize;
    if (widthRatio > heightRatio) {
        newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio);
    } else {
        newSize = CGSizeMake(size.width * widthRatio, size.height * widthRatio);
    }
    
    CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleImage:(UIImage *)image maxDimension:(CGFloat)maxDimension {
    CGFloat scale = MIN(maxDimension / image.size.width, maxDimension / image.size.height);
    CGFloat newWidth = image.size.width * scale;
    CGFloat newHeight = image.size.height * scale;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
