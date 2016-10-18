//
//  UIImage+Extensions.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/12.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "UIImage+Extensions.h"
#import "UIColor+Extension.h"

@implementation UIImage (Extensions)

+ (instancetype)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIColor *)colorWithCreatedImage {
    return [self colorWithPoint:CGPointMake(1, 1)];
}

- (UIColor *)colorWithPoint:(CGPoint)point {
    return [self getPixelColorAtLocation:point];
}

- (UIColor *)getPixelColorAtLocation:(CGPoint)point {
    UIColor* color = nil;
    CGImageRef inImage = self.CGImage;
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) { return nil;  }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        @try {
            int offset = 4*((w*round(point.y))+round(point.x));
            NSLog(@"offset: %d", offset);
            int alpha =  data[offset];
            int red = data[offset+1];
            int green = data[offset+2];
            int blue = data[offset+3];
            NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
            color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
        }
        @catch (NSException * e) {
            NSLog(@"%@",[e reason]);
        }
        @finally {
        }
        
    }
    // When finished, release the context
    CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data) { free(data); }
    
    return color;
}

- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    size_t          bitmapByteCount;
    size_t          bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color spacen");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}


- (UIImage *)imageWithBrightness:(CGFloat)brightness {
    
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:inputImage forKey:kCIInputImageKey];
    [lighten setValue:@(brightness) forKey:@"inputBrightness"];
    //  饱和度      0---2
    //  [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputSaturation"];
    //  亮度  10   -1---1
    //  [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputBrightness"];
    //  对比度 -11  0---4
    //  [filter setValue:[NSNumber numberWithFloat:2] forKey:@"inputContrast"];
    
    CIImage *outputImage = [lighten valueForKey:kCIOutputImageKey];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    UIImage *brighterImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return brighterImage;
}

@end


@interface StarImageCache ()

@property (nonatomic, strong) NSDictionary *cacheDict;

@end

@implementation StarImageCache

+ (instancetype)sharedCache {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSDictionary *)cacheDict {
    if (_cacheDict == nil) {
        _cacheDict = [[NSDictionary alloc] init];
    }
    return _cacheDict;
}

- (void)storeImage:(UIImage *)image forColor:(UIColor *)color {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.cacheDict];
    [dict setObject:image forKey:color];
    self.cacheDict = [dict copy];
}

- (UIImage *)imageWithContains:(UIColor *)color {
    for (int i = 0; i < self.cacheDict.allKeys.count; i++) {
        UIColor *h_color = self.cacheDict.allKeys[i];
        if ([h_color isEqualToColor:color]) {
            return self.cacheDict.allValues[i];
        }
    }
    return false;
}

- (UIImage *)imageFromCacheForColor:(UIColor *)color {
    
    UIImage *img = [self imageWithContains:color];
    if (img == nil) {
        img = [UIImage imageWithColor:color];
        [self storeImage:img forColor:color];
    }
    return img;
}

@end
