//
//  ViewController.m
//  IconResize
//
//  Created by quentin on 2017/1/25.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "ViewController.h"
#import "NSImage+Utitly.h"

//NSLocalizedString
#define  LSTR(str)  NSLocalizedString(str, nil)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
}

#pragma mark - on click

- (IBAction)onOpenChooseClick:(id)sender
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.allowedFileTypes = @[@"png", @"jpg", @"jpeg"];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
       
        NSData *data = [NSData dataWithContentsOfURL:panel.URL];

        NSImage *image = [[NSImage alloc] initWithData:data];
        
        NSImageRep *imageRep = [image bestRepresentationForRect:NSMakeRect(0, 0, image.size.width, image.size.height) context:NULL hints:nil];
        NSSize size = NSMakeSize([imageRep pixelsWide],[imageRep pixelsHigh]);
        [image setSize:size];
        
        self.iconImageView.image = image;
        
    }];
}

- (IBAction)onGeneratResultClick:(id)sender
{
    NSSavePanel *panel = [NSSavePanel savePanel];
    panel.canCreateDirectories = YES;
    panel.title = LSTR(@"save file");
    panel.message = LSTR(@"save file image");
    panel.nameFieldLabel = @"Name:";
    panel.nameFieldStringValue = @"IconResize";
    [panel beginWithCompletionHandler:^(NSInteger result) {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL success = [fileManager createDirectoryAtURL:panel.URL withIntermediateDirectories:YES attributes:nil error:NULL];
        if (success) {

            NSArray *sizes = @[@{@"20" : @"Icon-App-20x20@1x.png"} ,
                               @{@"40" : @"Icon-App-20x20@2x.png"} ,
                               @{@"60" : @"Icon-App-20x20@3x.png"} ,
                               @{@"29" : @"Icon-App-29x29@1x.png"} ,
                               @{@"58" : @"Icon-App-29x29@2x.png"} ,
                               @{@"87" : @"Icon-App-29x29@3x.png"} ,
                               @{@"40" : @"Icon-App-40x40@1x.png"} ,
                               @{@"80" : @"Icon-App-40x40@2x.png"} ,
                               @{@"120" : @"Icon-App-40x40@3x.png"} ,
                               @{@"60" : @"Icon-App-60x60@1x.png"} ,
                               @{@"120" : @"Icon-App-60x60@2x.png"} ,
                               @{@"180" : @"Icon-App-60x60@3x.png"} ,
                               @{@"76" : @"Icon-App-76x76@1x.png"} ,
                               @{@"152" : @"Icon-App-76x76@2x.png"} ,
                               @{@"228" : @"Icon-App-76x76@3x.png"} ,
                               @{@"167" : @"Icon-App-83.5x83.5@2x.png"} ,
                               ];
            
            for (NSDictionary *dict in sizes) {

                // 尺寸
                float width = [[[dict allKeys] lastObject] floatValue];
                
                NSImage *image = [self.iconImageView.image scaleImageSize:NSMakeSize(width, width)];
                
                // 名称
                NSString *fileName = [[dict allValues] lastObject];
                
                // 保存
                BOOL success = [[image TIFFRepresentationUsingCompression:NSTIFFCompressionJPEG factor:0.1f] writeToURL:[NSURL URLWithString:[panel.URL.absoluteString stringByAppendingPathComponent:fileName]] atomically:YES];
                if (!success) {
                    NSLog(@"失败");
                }
            }

            
            // 保存匹对文件
            NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Contents" ofType:@"json"]];
            BOOL success = [data writeToFile:[panel.URL.absoluteString stringByAppendingPathComponent:@"Contents.json"] atomically:YES];
            if (!success) {
                NSLog(@"匹对文件失败");
            }
        }
        else {
            
        }
    }];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
