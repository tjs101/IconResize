//
//  NSImage+Utitly.m
//  IconResize
//
//  Created by quentin on 2017/1/25.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "NSImage+Utitly.h"

@implementation NSImage (Utitly)

- (NSImage *)scaleImageSize:(NSSize)newSize
{
    NSImage *sourceImage = self;
    if ([sourceImage isValid])
    {
        if (self.size.width == newSize.width && self.size.height == newSize.height && newSize.width <= 0 && newSize.height <= 0) {
            return self;
        }
        
        NSRect oldRect = NSMakeRect(0.0, 0.0, self.size.width, self.size.height);
        NSRect newRect = NSMakeRect(0,0,newSize.width,newSize.height);
        NSImage *newImage = [[NSImage alloc] initWithSize:newSize];
        
        [newImage lockFocus];
        [sourceImage drawInRect:newRect fromRect:oldRect operation:NSCompositingOperationCopy fraction:1.0];
        [newImage unlockFocus];
        
        return newImage;
    }
    
    return self;
}

@end
