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
    panel.nameFieldLabel = @"dirName";
    panel.nameFieldStringValue = @"IconResize.png";
    [panel beginWithCompletionHandler:^(NSInteger result) {
        
        NSString *path = panel.URL.absoluteString;
        NSLog(@"path----%@", panel.URL);
        
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        BOOL success = [fileManager createDirectoryAtURL:panel.URL withIntermediateDirectories:YES attributes:nil error:NULL];
        if (YES) {

            NSImage *image = [self.iconImageView.image scaleImageSize:NSMakeSize(100, 100)];

            BOOL success = [[image TIFFRepresentationUsingCompression:NSTIFFCompressionJPEG factor:0.1f] writeToURL:panel.URL atomically:YES];
            NSLog(@"success %d", success);
            
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
