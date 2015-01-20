//
//  ViewController.m
//  ARCTest
//
//  Created by Saravanan Ramaswamy on 1/20/15.
//  Copyright (c) 2015 Saravanan Ramaswamy. All rights reserved.
//

#import "ViewController.h"

@class Child;
@interface Child : NSObject

@property (nonatomic, strong) NSString *name;

@end

@implementation Child

@synthesize name;

@end

@class Parent;
@interface Parent : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Child *child;

@end

@implementation Parent

@synthesize name, child;

@end

@class GrandParent;
@interface GrandParent : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Parent *parent;

@end

@implementation GrandParent

@synthesize name, parent;

@end

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) GrandParent *grandparent;

@property (nonatomic, strong) Parent *strongSavedParent;
@property (nonatomic, strong) Child *strongSavedChild;
@property (nonatomic, weak) Parent *weakSavedParent;
@property (nonatomic, weak) Child *weakSavedChild;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initGP];
}

-(void) initGP {

    self.grandparent = nil;
    self.strongSavedChild = nil;
    self.strongSavedParent = nil;
    self.weakSavedChild = nil;
    self.weakSavedParent = nil;

    Child *child = [[Child alloc] init];
    child.name = @"Harry";

    Parent *parent = [[Parent alloc] init];
    parent.name = @"Charles";
    parent.child = child;

    self.grandparent = [[GrandParent alloc] init];
    self.grandparent.name = @"Elizabeth";
    self.grandparent.parent = parent;
}

-(IBAction) onePressed:(id)sender {

    self.strongSavedChild = self.grandparent.parent.child;
    self.strongSavedParent = self.grandparent.parent;

    self.grandparent.parent = nil;
    NSString *parentName = self.strongSavedParent.name;
    NSString *childName = self.strongSavedChild.name;
    NSString *text = [NSString stringWithFormat:@"Cutloose parent (strong): %@ - %@ - %@", self.grandparent.name, parentName, childName];
    self.label.text = text;

    [self initGP];
}

-(IBAction) twoPressed:(id)sender {

    self.weakSavedChild = self.grandparent.parent.child;
    self.weakSavedParent = self.grandparent.parent;

    self.grandparent.parent = nil;
    NSString *parentName = self.weakSavedParent.name;
    NSString *childName = self.weakSavedChild.name;
    NSString *text = [NSString stringWithFormat:@"Cutloose parent (weak): %@ - %@ - %@", self.grandparent.name, parentName, childName];
    self.label.text = text;

    [self initGP];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
