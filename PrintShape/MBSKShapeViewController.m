//
//  TestSpriteKitViewController.m
//  MyBlee
//
//  Created by Alexandre Lafosse on 29/09/2014.
//  Copyright (c) 2014 LGM Learning. All rights reserved.
//
#import <SceneKit/SceneKit.h>
#import "MBSKShapeViewController.h"
#import <sys/utsname.h>

@interface MBSKShapeViewController ()

@property(nonatomic, strong) SCNNode *cameraNode;

- (SCNScene *)setupScene;
- (void)setupEnvironment:(SCNScene *)scene;

@end

@implementation MBSKShapeViewController {
    //some node references for manipulation
    
}

- (NSString*)getGoogleAnalyticsViewControllerName
{
    return @"Parent : Tutorials";
}

- (void)setupSceneElements:(SCNScene *)scene
{
    SCNNode *shape = [SCNNode node];
    shape.position = SCNVector3Make(0, 2, 0);
    
    switch (self.shapeType) {
        case MBShapeSphere:
            shape.geometry = [SCNSphere sphereWithRadius:5];
            break;
            
        case MBShapeCone:
            shape.geometry = [SCNCone coneWithTopRadius:0 bottomRadius:4 height:10];
            break;
        
        case MBShapePyramid:
            shape.geometry = [SCNPyramid pyramidWithWidth:8 height:8 length:8];
            break;
        
        case MBShapeCube:
            shape.geometry = [SCNBox boxWithWidth:8 height:8 length:8 chamferRadius:0];
            break;
        
        case MBShapeCuboid:
            shape.geometry = [SCNBox boxWithWidth:5 height:5 length:10 chamferRadius:0];
            break;
        
        case MBShapeCylinder:
            shape.geometry = [SCNCylinder cylinderWithRadius:4 height:10];
            break;
            
        default:
            break;
    }
    
    shape.geometry.firstMaterial.locksAmbientWithDiffuse = YES;
    shape.geometry.firstMaterial.diffuse.wrapS = SCNWrapModeMirror;
    
    CABasicAnimation *boxRotation = [CABasicAnimation animationWithKeyPath:@"rotation"];
    boxRotation.byValue = [NSValue valueWithSCNVector4:SCNVector4Make(1, 1, .5,2.0*M_PI)];
    boxRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    boxRotation.repeatCount = INFINITY;
    boxRotation.duration = 5.0;
    [shape addAnimation:boxRotation forKey:@"RotateTheBox"];
    
    [[scene rootNode] addChildNode:shape];
    
    self.labelTitle.text = self.shapeTitle;
    
}

- (void)setupEnvironment:(SCNScene *)scene
{
    // add an ambient light
    SCNNode *ambientLight = [SCNNode node];
    ambientLight.light = [SCNLight light];
    ambientLight.light.type = SCNLightTypeAmbient;
    ambientLight.light.color = [UIColor colorWithWhite:0.5 alpha:1.0];
    ambientLight.light.shadowColor = [UIColor blackColor];
    ambientLight.position = SCNVector3Make(0, 2, 0);;
    [[scene rootNode] addChildNode:ambientLight];
    
    //add a key light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeSpot;
    lightNode.light.color = [UIColor colorWithWhite:0.8 alpha:1.0];
    lightNode.position = SCNVector3Make(0, 80, 30);
    lightNode.rotation = SCNVector4Make(1,0,0,-M_PI/2.8);
    lightNode.light.spotInnerAngle = 0;
    lightNode.light.spotOuterAngle = 50;
    lightNode.light.shadowColor = [UIColor blackColor];
    lightNode.light.zFar = 500;
    lightNode.light.zNear = 50;
    [[scene rootNode] addChildNode:lightNode];
}


- (SCNScene *)setupScene
{
    // create a new scene
    SCNScene *scene = [SCNScene scene];
    
    //global environment
    [self setupEnvironment:scene];
    
    //add elements
    [self setupSceneElements:scene];
    
    //create a main camera
    self.cameraNode = [[SCNNode alloc] init];
    self.cameraNode.camera = [SCNCamera camera];
    self.cameraNode.camera.zFar = 500;
    self.cameraNode.position = SCNVector3Make(0, 0, 20);
    [scene.rootNode addChildNode:self.cameraNode];
    
    return scene;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.shapeType = MBShapeSphere;
        self.shapeTitle = @"sphere";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.frame] ;
    
    scnView.backgroundColor = [UIColor clearColor];
    
    //setup the scene
    SCNScene *scene = [self setupScene];
    
    //present it
    scnView.scene = scene;
    
    //tweak physics
    scnView.scene.physicsWorld.speed = 4.0;
    
    //initial point of view
    scnView.pointOfView = self.cameraNode;
    
    [self.view addSubview:scnView];
    
    //self.view addSubview:sce
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
