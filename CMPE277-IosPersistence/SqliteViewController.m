//
//  SqliteViewController.m
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/4/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import "SqliteViewController.h"
#import "FileHelper.h"
#import "sqlite3.h"

@interface SqliteViewController ()

@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) NSString *databasePath;

@end

@implementation SqliteViewController

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
    [self loadDatabase];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDatabase
{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    self.databasePath = [FileHelper pathForFileName:self.filename];
    if (! [filemgr fileExistsAtPath:_databasePath])
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                self.statusTextField.text = @"Failed to create table";
            }
            sqlite3_close(_contactDB);
        } else {
            self.statusTextField.text = @"Failed to open/create database";
        }
    }

}

- (void)loadFilename
{
    self.filename = @"database.db";
}

- (IBAction)didClickSave:(UIButton *)sender
{
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, address, phone) VALUES (\"%@\", \"%@\", \"%@\")",
                               self.nameTextField.text, self.addrTextField.text, self.phoneTextField.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            self.statusTextField.text = @"Contact added";
            self.nameTextField.text = @"";
            self.addrTextField.text = @"";
            self.phoneTextField.text = @"";
        } else {
            self.statusTextField.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }

}

- (void)loadSavedData
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT address, phone FROM contacts WHERE name=\"%@\"",
                              self.nameTextField.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *addressField = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 0)];
                self.addrTextField.text = addressField;
                NSString *phoneField = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                self.phoneTextField.text = phoneField;
                self.statusTextField.text = @"Match found";
            } else {
                self.statusTextField.text = @"Match not found";
                self.addrTextField.text = @"";
                self.phoneTextField.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    

}
@end
