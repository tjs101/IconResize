//
//  NSImage+Utitly.m
//  IconResize
//
//  Created by quentin on 2017/1/25.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "NSImage+Utitly.h"

@implementation NSImage (Utitly)

+ (NSImage *)scaleImage:(NSImage *)image toSize:(NSSize)newSize proportionally:(BOOL)prop
{
    if (image) {
        NSImage *copy = [image copy];
        NSSize size = [copy size];
        
        if (prop) {
            float rx, ry, r;
            
            rx = newSize.width / size.width;
            ry = newSize.height / size.height;
            r = rx < ry ? rx : ry;
            size.width *= r;
            size.height *= r;
        } else
            size = newSize;
        
        [copy setScalesWhenResized:YES];
        [copy setSize:size];
        
        return copy;
    }
    return nil; // or 'image' if you prefer.
}

@end
