//
//  FirstViewController.m
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/2/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import "FileSaveViewController.h"
#import "FileHelper.h"



@interface FileSaveViewController ()


@end

@implementation FileSaveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadFilename];
    
    
    
    // Tap Recognizer for dismissing the keyboard
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.scrollView addGestureRecognizer:tapRecognizer];
}

- (void)loadFilename
{
    self.filename = @"dataFile.txt";
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSavedData
{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSString *dataFile = [FileHelper pathForFileName:self.filename];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFile])
    {
        // Read file contents and display in textBox
        NSData *databuffer = [filemgr contentsAtPath: dataFile];
        
        NSDictionary *dict = [self dictFromData:databuffer];
        
        if (dict != nil) {
            self.nameTextField.text = dict[NAME_KEY];
            self.authorTextField.text = dict[AUTHOR_KEY];
            self.descTextView.text = dict[DESC_KEY];
        }
    }

}

- (NSDictionary *)dictFromData:(NSData *)savedData
{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:savedData options:NSJSONReadingAllowFragments error:&error];
    
    return dict;
}

- (IBAction)didClickSave:(UIButton *)sender
{
    NSDictionary *info = @{NAME_KEY: self.nameTextField.text, AUTHOR_KEY:self.authorTextField.text, DESC_KEY:self.descTextView.text};
    [self saveDataDict:info];
}

- (IBAction)didClickLoad:(UIButton *)sender
{
    [self loadSavedData];
}

- (void)saveDataDict:(NSDictionary *)dict
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];

    NSString *filePath = [FileHelper pathForFileName:self.filename];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    
}


#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tag = textField.tag + 1;
    UIView *nextView = [self.view viewWithTag:tag];
    [nextView becomeFirstResponder];

    return YES;
}

@end
