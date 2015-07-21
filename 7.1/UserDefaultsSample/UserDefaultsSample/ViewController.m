//
//  ViewController.m
//  UserDefaultsSample
//
//  Created by 大久保直昭 on 2015/07/21.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL isNewKeyValid;
    BOOL isNewValueValid;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (strong, nonatomic) UIAlertAction *addItemAction;

@end

@implementation ViewController
+ (BOOL)isValidStringIgnoreSpace:(NSString *)string
{
    if (!string) return NO;
    NSString *str = [[[[[string stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"　" withString:@""] stringByReplacingOccurrencesOfString:@"\r" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return str.length > 0;
}

- (BOOL)isValidStringForKey:(NSString *)string
{
    return [self.class isValidStringIgnoreSpace:string] && ([_dictionary objectForKey:string] == nil);
}

- (BOOL)isValidStringForValue:(NSString *)string
{
    return [self.class isValidStringIgnoreSpace:string];
}

+ (NSString *)getDictionaryKey
{
    return @"dictionary";
}

+ (NSString *)getFileName
{
    return @"savedItems";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action)];
    self.navigationController.toolbarHidden = NO;
    self.toolbarItems = @[space, actionButton, space];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self applicationActivation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applicationActivation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // loading defaults
    NSMutableDictionary *defaultDictionary = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist" inDirectory:@"Settings.bundle"];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:path];
    id specifiers = [settings objectForKey:@"PreferenceSpecifiers"];
    for (id prefItem in specifiers) {
        id key = [prefItem objectForKey:@"Key"];
        id value = [prefItem objectForKey:@"DefaultValue"];
        if (key && value) {
            [defaultDictionary setObject:value forKey:key];
        }
    }
    [defaults registerDefaults:defaultDictionary];
    
    
    self.title = [defaults objectForKey:@"appTitle"];
    [self loadUserDefaults];
    [_tableView reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dictionary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dictionary.allKeys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    cell.textLabel.text = [_dictionary.allValues objectAtIndex:indexPath.section];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"indent"]).integerValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *key = [_dictionary.allKeys objectAtIndex:indexPath.section];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Confirm" message:[NSString stringWithFormat:@"remove '%@' from user defaults?", key] preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [_dictionary removeObjectForKey:key];
        [self updateUserDefaults];
    }]];
    [self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)loadUserDefaults
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:[self.class getDictionaryKey]];
    if (dic) {
        _dictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
    } else {
        _dictionary = [NSMutableDictionary dictionary];
    }
}

- (void)updateUserDefaults
{
    [[NSUserDefaults standardUserDefaults] setObject:_dictionary forKey:[self.class getDictionaryKey]];
    
    [_tableView reloadData];
}

- (void)addItem
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"New Item" message:@"input new key and value" preferredStyle:UIAlertControllerStyleAlert];
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"input new key";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddTextFieldNotification1:) name:UITextFieldTextDidChangeNotification object:textField];
        isNewKeyValid = NO;
    }];
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"input new value";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddTextFieldNotification2:) name:UITextFieldTextDidChangeNotification object:textField];
        isNewValueValid = NO;
    }];
    
    void (^removeNotifications)() = ^{
        NSArray *array = controller.textFields;
        for (UITextField *field in array) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:field];
        }
        [self setAddItemAction:nil];
    };
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        removeNotifications();
    }]];
    [self setAddItemAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        removeNotifications();
        [_dictionary setObject:((UITextField *)controller.textFields[1]).text forKey:((UITextField *)controller.textFields[0]).text];
        [self updateUserDefaults];
    }]];
    _addItemAction.enabled = false;
    [controller addAction:_addItemAction];
    
    [self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)handleAddTextFieldNotification1:(NSNotification *)notification
{
    UITextField *field = notification.object;
    isNewKeyValid = [self isValidStringForKey:field.text];
    
    _addItemAction.enabled = isNewKeyValid && isNewValueValid;
}

- (void)handleAddTextFieldNotification2:(NSNotification *)notification
{
    UITextField *field = notification.object;
    isNewValueValid = [self isValidStringForValue:field.text];
    
    _addItemAction.enabled = isNewKeyValid && isNewValueValid;
}

- (void)action
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Menu" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *loadAction;
    UIAlertAction *deleteAction;
    [controller addAction:loadAction = [UIAlertAction actionWithTitle:@"Load from file" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self loadFromFile];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Save to file" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self saveToFile];
    }]];
    [controller addAction:deleteAction = [UIAlertAction actionWithTitle:@"Delete file" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self deleteFile];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Remove all items" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self removeAllItems];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *urls = [manager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    NSURL *baseUrl = urls[0];
    NSURL *fileUrl = [baseUrl URLByAppendingPathComponent:[self.class getFileName]];
    if (![manager fileExistsAtPath:fileUrl.path]) {
        loadAction.enabled = NO;
        deleteAction.enabled = NO;
    }
    [self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)loadFromFile
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *urls = [manager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    NSURL *baseUrl = urls[0];
    NSURL *fileUrl = [baseUrl URLByAppendingPathComponent:[self.class getFileName]];
    NSString *reason = @"";
    if ([manager fileExistsAtPath:fileUrl.path]) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:fileUrl];
        if (dic) {
            _dictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
            [self updateUserDefaults];
            
            UIAlertController *complete = [UIAlertController alertControllerWithTitle:@"Complete" message:@"loading from file succeeded" preferredStyle:UIAlertControllerStyleAlert];
            [complete addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self.view.window.rootViewController presentViewController:complete animated:YES completion:nil];
            return;
        }
        reason = @"loading from file failed";
    } else {
        reason = @"file not found";
    }
    
    UIAlertController *complete = [UIAlertController alertControllerWithTitle:@"Failed" message:reason preferredStyle:UIAlertControllerStyleAlert];
    [complete addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.view.window.rootViewController presentViewController:complete animated:YES completion:nil];
}

- (void)saveToFile
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    NSURL *baseUrl = urls[0];
    NSURL *fileUrl = [baseUrl URLByAppendingPathComponent:[self.class getFileName]];
    [_dictionary writeToURL:fileUrl atomically:YES];
    
    UIAlertController *complete = [UIAlertController alertControllerWithTitle:@"Complete" message:@"saving to file succeeded" preferredStyle:UIAlertControllerStyleAlert];
    [complete addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.view.window.rootViewController presentViewController:complete animated:YES completion:nil];
}

- (void)deleteFile
{
    UIAlertController *confirm = [UIAlertController alertControllerWithTitle:@"Confirm" message:@"really remove the file?" preferredStyle:UIAlertControllerStyleAlert];
    [confirm addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [confirm addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *urls = [manager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
        NSURL *baseUrl = urls[0];
        NSURL *fileUrl = [baseUrl URLByAppendingPathComponent:[self.class getFileName]];
        NSString *reason = @"";
        if ([manager fileExistsAtPath:fileUrl.path]) {
            NSError *error = nil;
            [manager removeItemAtURL:fileUrl error:&error];
            if (!error) {
                UIAlertController *complete = [UIAlertController alertControllerWithTitle:@"Complete" message:@"removing file succeeded" preferredStyle:UIAlertControllerStyleAlert];
                [complete addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self.view.window.rootViewController presentViewController:complete animated:YES completion:nil];
                return;
            }
            reason = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        } else {
            reason = @"file not found";
        }
        
        UIAlertController *complete = [UIAlertController alertControllerWithTitle:@"Failed" message:reason preferredStyle:UIAlertControllerStyleAlert];
        [complete addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self.view.window.rootViewController presentViewController:complete animated:YES completion:nil];
    }]];
    [self.view.window.rootViewController presentViewController:confirm animated:YES completion:nil];
}

- (void)removeAllItems
{
    UIAlertController *confirm = [UIAlertController alertControllerWithTitle:@"Confirm" message:@"really remove all items?" preferredStyle:UIAlertControllerStyleAlert];
    [confirm addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [confirm addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _dictionary = [NSMutableDictionary dictionary];
        [self updateUserDefaults];
        
        UIAlertController *complete = [UIAlertController alertControllerWithTitle:@"Complete" message:@"removing all items succeeded" preferredStyle:UIAlertControllerStyleAlert];
        [complete addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self.view.window.rootViewController presentViewController:complete animated:YES completion:nil];
    }]];
    [self.view.window.rootViewController presentViewController:confirm animated:YES completion:nil];
}
@end
