//
//  ViewController.m
//  PrintShape
//
//  Created by Alexandre Lafosse on 07/10/2014.
//  Copyright (c) 2014 Alexandre Lafosse. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "ViewController.h"
#import "MBSKShapeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //on ios 8
    if ([SCNView class]) {
        MBSKShapeViewController* vc = [[MBSKShapeViewController alloc] initWithNibName:nil bundle:nil];
        vc.shapeType = MBShapeCylinder;
        vc.shapeTitle = @"CYLINDER";
    
        [self.view addSubview:vc.view];
        vc.view.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/2);
    }
    //ios 6 & ios 7
    else {
        UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Where are you cylinder?";
        [self.view addSubview:label];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
