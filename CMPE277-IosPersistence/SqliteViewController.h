//
//  SqliteViewController.h
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/4/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileSaveViewController.h"

@interface SqliteViewController : FileSaveViewController

@property (weak, nonatomic) IBOutlet UITextField *addrTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;


@end
