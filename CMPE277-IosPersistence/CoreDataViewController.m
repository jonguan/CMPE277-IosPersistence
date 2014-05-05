//
//  CoreDataViewController.m
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/4/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import "CoreDataViewController.h"
#import "FileHelper.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didClickSave:(UIButton *)sender
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Contacts"
                  inManagedObjectContext:context];
    [newContact setValue: self.nameTextField.text forKey:@"name"];
    [newContact setValue: self.addrTextField.text forKey:@"address"];
    [newContact setValue: self.phoneTextField.text forKey:@"phone"];
    self.nameTextField.text = @"";
    self.addrTextField.text = @"";
    self.phoneTextField.text = @"";
    NSError *error;
    [context save:&error];
    self.statusTextField.text = @"Contact saved";

}

- (IBAction)didClickLoad:(UIButton *)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Contacts"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(name = %@)", self.nameTextField.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        self.statusTextField.text = @"No matches";
    } else {
        matches = objects[0];
        self.addrTextField.text = [matches valueForKey:@"address"];
        self.phoneTextField.text = [matches valueForKey:@"phone"];
        self.statusTextField.text = [NSString stringWithFormat:@"%@ matches found", @([objects count])];
    }

}

@end
