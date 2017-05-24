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

{
    BOOL  _checkIphone;
    BOOL  _checkWatch;
    BOOL  _checkMessage;
    BOOL  _checkMac;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    _checkIphone = _iphoneCheck.state;
    _checkMessage = _messageCheck.state;
    _checkWatch = _watchCheck.state;
    _checkMac = _macCheck.state;
    
}

#pragma mark - on check

- (IBAction)onCheckIphone:(id)sender
{
    _checkIphone = _iphoneCheck.state;
}

- (IBAction)onCheckWatch:(id)sender
{
    _checkWatch = _watchCheck.state;
}

- (IBAction)onCheckMessage:(id)sender
{
    _checkMessage = _messageCheck.state;
}

- (IBAction)onCheckMac:(id)sender
{
    _checkMac = _macCheck.state;
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
    if (self.iconImageView.image == nil) {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:LSTR(@"Need choose the obj of Image ?")];
        [alert addButtonWithTitle:LSTR(@"I know it!")];
        [alert beginSheetModalForWindow:self.view.window completionHandler:NULL];
        
        return;
    }
    
    if (!_checkMessage &&
        !_checkWatch &&
        !_checkIphone &&
        !_checkMac) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:LSTR(@"Need choose the least a type ?")];
        [alert addButtonWithTitle:LSTR(@"I know it!")];
        [alert beginSheetModalForWindow:self.view.window completionHandler:NULL];
        
        return;
    }
    
    NSSavePanel *panel = [NSSavePanel savePanel];
    panel.canCreateDirectories = YES;
    panel.title = LSTR(@"Save Icon files");
    panel.nameFieldLabel = LSTR(@"Name:");
    panel.nameFieldStringValue = @"IconResize";
    [panel beginWithCompletionHandler:^(NSInteger result) {
        
        if (result != NSModalResponseOK) {
            return;
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL success = [fileManager createDirectoryAtURL:panel.URL withIntermediateDirectories:YES attributes:nil error:NULL];
        if (success) {

            // ios
            NSArray *ios_sizes = @[@{@"28.5" : @"Icon-57.png"} ,
                                   @{@"57" : @"Icon-57@2x.png"} ,
                                   @{@"60" : @"Icon-60@2x.png"} ,
                                   @{@"90" : @"Icon-60@3x.png"} ,
                                   @{@"14.5" : @"Icon-Small.png"} ,
                                   @{@"29" : @"Icon-Small@2x.png"} ,
                                   @{@"43.5" : @"Icon-Small@3x.png"} ,
                                   @{@"40" : @"Icon-Spotlight-40@2x.png"} ,
                                   @{@"60" : @"Icon-Spotlight-40@3x.png"}
                                   ];
//            NSArray *ios_sizes = @[@{@"20" : @"Icon-App-20x20@1x.png"} ,
//                               @{@"40" : @"Icon-App-20x20@2x.png"} ,
//                               @{@"60" : @"Icon-App-20x20@3x.png"} ,
//                               @{@"29" : @"Icon-App-29x29@1x.png"} ,
//                               @{@"58" : @"Icon-App-29x29@2x.png"} ,
//                               @{@"87" : @"Icon-App-29x29@3x.png"} ,
//                               @{@"40" : @"Icon-App-40x40@1x.png"} ,
//                               @{@"80" : @"Icon-App-40x40@2x.png"} ,
//                               @{@"120" : @"Icon-App-40x40@3x.png"} ,
//                               @{@"57" : @"Icon-App-57x57@1x.png"} ,
//                               @{@"114" : @"Icon-App-57x57@2x.png"} ,
//                               @{@"60" : @"Icon-App-60x60@1x.png"} ,
//                               @{@"120" : @"Icon-App-60x60@2x.png"} ,
//                               @{@"180" : @"Icon-App-60x60@3x.png"} ,
//                               @{@"72" : @"Icon-App-72x72@1x.png"} ,
//                               @{@"144" : @"Icon-App-72x72@2x.png"} ,
//                               @{@"76" : @"Icon-App-76x76@1x.png"} ,
//                               @{@"152" : @"Icon-App-76x76@2x.png"} ,
//                               @{@"228" : @"Icon-App-76x76@3x.png"} ,
//                               @{@"167" : @"Icon-App-83.5x83.5@2x.png"} ,
//                               @{@"50" : @"Icon-Small-50x50@1x.png"} ,
//                               @{@"100" : @"Icon-Small-50x50@2x.png"} ,
//                               ];
            
            // watch
            NSArray *watch_sizes = @[@{@"48" : @"Icon-24@2x.png"} ,
                                   @{@"55" : @"Icon-27.5@2x.png"} ,
                                   @{@"58" : @"Icon-29@2x.png"} ,
                                   @{@"87" : @"Icon-29@3x.png"} ,
                                   @{@"80" : @"Icon-40@2x.png"} ,
                                   @{@"88" : @"Icon-44@2x.png"} ,
                                   @{@"172" : @"Icon-86@2x.png"} ,
                                   @{@"196" : @"Icon-98@2x.png"} ,
                                   ];
            
            // imessenger
            NSArray *message_sizes = @[@{@"27*20" : @"icon-messages-app-27x20@1x.png"} ,
                                   @{@"54*40" : @"icon-messages-app-27x20@2x.png"} ,
                                   @{@"81*60" : @"Iicon-messages-app-27x20@3x.png"} ,
                                   @{@"134*100" : @"icon-messages-app-iPadAir-67x50@2x.png"} ,
                                   @{@"148*110" : @"icon-messages-app-iPadAir-74x55@2x.png"} ,
                                   @{@"60*45" : @"icon-messages-app-iPhone-60x45@1x.png"} ,
                                   @{@"120*90" : @"icon-messages-app-iPhone-60x45@2x.png"} ,
                                   @{@"180*135" : @"icon-messages-app-iPhone-60x45@3x.png"} ,
                                   @{@"1024*768" : @"icon-messages-app-store-1024x768.png"} ,
                                   @{@"32*24" : @"icon-messages-transcript-32x24@1x.png"} ,
                                   @{@"64*48" : @"icon-messages-transcript-32x24@2x.png"} ,
                                   @{@"96*72" : @"icon-messages-transcript-32x24@3x.png"} ,
                                   ];
            
            // mac
            NSArray *mac_sizes = @[@{@"16" : @"Icon-Mac-16x16@1x.png"} ,
                                   @{@"32" : @"Icon-Mac-16x16@2x.png"} ,
                                   @{@"32" : @"Icon-Mac-32x32@1x.png"} ,
                                   @{@"64" : @"Icon-Mac-32x32@2x.png"} ,
                                   @{@"128" : @"Icon-Mac-128x128@1x.png"} ,
                                   @{@"256" : @"Icon-Mac-128x128@2x.png"} ,
                                   @{@"256" : @"Icon-Mac-256x256@1x.png"} ,
                                   @{@"512" : @"Icon-Mac-256x256@2x.png"} ,
                                   @{@"512" : @"Icon-Mac-512x512@1x.png"} ,
                                   @{@"1024" : @"Icon-Mac-512x512@2x.png"} ,
                                   ];
            
            BOOL showSuccess = YES;
            
            if (_checkIphone) {// 保存iphone icon
                
                NSString *path = [panel.URL.absoluteString stringByAppendingPathComponent:@"ios/AppIcon.appiconset"];
                success = [fileManager createDirectoryAtURL:[NSURL URLWithString:path] withIntermediateDirectories:YES attributes:nil error:NULL];

                if (success) {
                    showSuccess = [self saveIcons:ios_sizes path:path plistName:@"IOS_Contents" needPlist:NO];
                }

            }
            
            if (_checkWatch) {// 保存watch icon
                
                NSString *path = [panel.URL.absoluteString stringByAppendingPathComponent:@"watchkit/AppIcon.appiconset"];
                success = [fileManager createDirectoryAtURL:[NSURL URLWithString:path] withIntermediateDirectories:YES attributes:nil error:NULL];
                
                if (success) {
                    showSuccess = [self saveIcons:watch_sizes path:path plistName:@"Watch_Contents" needPlist:YES];
                }
                
            }
            
            if (_checkMessage) {// 保存message icon
                NSString *path = [panel.URL.absoluteString stringByAppendingPathComponent:@"message"];
                success = [fileManager createDirectoryAtURL:[NSURL URLWithString:path] withIntermediateDirectories:YES attributes:nil error:NULL];
                
                if (success) {
                    showSuccess = [self saveIcons:message_sizes path:path plistName:nil needPlist:NO];
                }
            }
            
            if (_checkMac) {// 保存mac icon
                NSString *path = [panel.URL.absoluteString stringByAppendingPathComponent:@"mac/AppIcon.appiconset"];
                success = [fileManager createDirectoryAtURL:[NSURL URLWithString:path] withIntermediateDirectories:YES attributes:nil error:NULL];
                
                if (success) {
                    showSuccess = [self saveIcons:mac_sizes path:path plistName:@"Mac_Contents" needPlist:YES];
                }
            }

            
            if (showSuccess) {
                NSAlert *alert = [[NSAlert alloc] init];
                [alert setMessageText:LSTR(@"Icon generate successed!")];
                [alert addButtonWithTitle:LSTR(@"I know it!")];
                [alert beginSheetModalForWindow:self.view.window completionHandler:NULL];
            }
            else {
                NSAlert *alert = [[NSAlert alloc] init];
                [alert setMessageText:LSTR(@"Icon generate failed!")];
                [alert addButtonWithTitle:LSTR(@"I know it!")];
                [alert beginSheetModalForWindow:self.view.window completionHandler:NULL];
            }
        }
        else {
            
        }
    }];
}

#pragma mark - 保存文件

- (BOOL)saveIcons:(NSArray *)icons path:(NSString *)path plistName:(NSString *)plistName needPlist:(BOOL)need
{
    BOOL showSuccess = YES;
    
    for (NSDictionary *dict in icons) {
        
        // 尺寸
        float width = 0;
        float height = 0;
        
        NSString *size = [dict.allKeys lastObject];
        if ([[size componentsSeparatedByString:@"*"] count] > 1) {
            
            NSArray *sizes = [size componentsSeparatedByString:@"*"];
            
            width = [[sizes firstObject] floatValue];
            height = [[sizes lastObject] floatValue];
        }
        else {
            width = [[[dict allKeys] lastObject] floatValue];
            height = width;
        }
        
        
        
        NSImage *image = [self.iconImageView.image scaleImageSize:NSMakeSize(width, height)];
        
        // 名称
        NSString *fileName = [[dict allValues] lastObject];
        
        // 保存
        BOOL success = [[image TIFFRepresentationUsingCompression:NSTIFFCompressionJPEG factor:0.1f] writeToURL:[NSURL URLWithString:[path stringByAppendingPathComponent:fileName]] atomically:YES];
        if (!success) {
            showSuccess = NO;
        }
    }
    
    
    // 保存匹对文件
    if (need) {
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"json"]];
        BOOL success = [data writeToURL:[NSURL URLWithString:[path stringByAppendingPathComponent:@"Contents.json"]] atomically:YES];
        if (!success) {
            showSuccess = NO;
        }
    }
    
    return showSuccess;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
