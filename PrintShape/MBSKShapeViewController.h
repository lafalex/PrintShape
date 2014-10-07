//
//  TestSpriteKitViewController.h
//  MyBlee
//
//  Created by Alexandre Lafosse on 29/09/2014.
//  Copyright (c) 2014 LGM Learning. All rights reserved.
//

typedef enum
{
    MBShapeCube,
    MBShapeSphere,
    MBShapeCylinder,
    MBShapePyramid,
    MBShapeCone,
    MBShapeCuboid
} MBShapeType ;

@interface MBSKShapeViewController : UIViewController

@property (nonatomic, assign) MBShapeType shapeType;
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;
@property (nonatomic, weak) NSString *shapeTitle;

@end
