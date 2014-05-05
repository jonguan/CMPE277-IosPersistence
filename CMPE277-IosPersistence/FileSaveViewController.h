//
//  FirstViewController.h
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/2/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NAME_KEY        @"Name"
#define AUTHOR_KEY  @"Author"
#define DESC_KEY        @"Description"


@interface FileSaveViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSString *filename;

- (IBAction)didClickSave:(UIButton *)sender;
- (IBAction)didClickLoad:(UIButton *)sender;

- (void)loadFilename;
- (void)loadSavedData;
- (void)saveDataDict:(NSDictionary *)dict;

- (NSDictionary *)dictFromData:(NSData *)savedData;

@end
