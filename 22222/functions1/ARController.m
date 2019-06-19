//
//  ARController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/12/28.
//  Copyright © 2018 玉岳鹏. All rights reserved.
//

#import "ARController.h"
#import <ARKit/ARKit.h>
@interface ARController ()<ARSCNViewDelegate>

@property(nonatomic, strong) ARSCNView *sceneView;

@end

@implementation ARController

- (ARSCNView *)sceneView {
    if (_sceneView == nil) {
        _sceneView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        _sceneView.delegate = self;
        _sceneView.showsStatistics = YES;
        // Create a new scene
        SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
        
        // Set the scene to the view
        _sceneView.scene = scene;
    }
    return _sceneView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ARWorldTrackingConfiguration *trackingConfiguration = [[ARWorldTrackingConfiguration alloc] init];
    trackingConfiguration.worldAlignment = ARWorldAlignmentGravity;
    trackingConfiguration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:trackingConfiguration];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.sceneView];
    
    // Do any additional setup after loading the view.
}
#pragma mark - ARSCNViewDelegate

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    ARPlaneAnchor *planeAnchor = anchor;
    
    SCNPlane *plane = [SCNPlane planeWithWidth:planeAnchor.extent.x height:planeAnchor.extent.z];
    SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
    planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
    
    planeNode.transform = SCNMatrix4MakeRotation(- M_PI/2, 1, 0, 0);
    
    [node addChildNode:planeNode];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
