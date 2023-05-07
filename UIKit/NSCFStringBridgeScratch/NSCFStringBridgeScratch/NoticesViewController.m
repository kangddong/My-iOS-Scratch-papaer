//
//  NoticesViewController.m
//  NSCFStringBridgeScratch
//
//  Created by 강동영 on 2023/05/07.
//

#import "NoticesViewController.h"

@interface NoticesViewController ()

@end

@implementation NoticesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void) setLocalizedTitle:(NSString*)localizedTitle {
    NSLog(@"%@", localizedTitle);
    
    if ( [localizedTitle isEqualToString:NSLocalizedString(@"Notices", nil)]) {
        NSLog(@"Equal");
    } else {
        NSLog(@"Not Equal");
    }
    
}

@end
