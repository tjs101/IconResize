//
//  ViewController.h
//  IconResize
//
//  Created by quentin on 2017/1/25.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (nonatomic, strong) IBOutlet NSImageView *iconImageView;/**<解释>*/

@property (nonatomic, strong) IBOutlet NSButton *iphoneCheck;/**<解释>*/
@property (nonatomic, strong) IBOutlet NSButton *watchCheck;/**<解释>*/
@property (nonatomic, strong) IBOutlet NSButton *messageCheck;/**<解释>*/
@property (nonatomic, strong) IBOutlet NSButton *macCheck;/**<解释>*/

@end

