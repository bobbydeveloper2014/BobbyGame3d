#import "GameViewController.h"
#import "BobbyGame3D.h"   // Import BobbyGame3D

@interface GameViewController ()

@end

@implementation GameViewController

// Đảm bảo GameViewController kế thừa từ UIViewController
- (instancetype)init {
    self = [super init];  // Khởi tạo lớp cha UIViewController
    if (self) {
        // Lớp đã được khởi tạo
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Khởi tạo scene
    self.scene = [SCNScene scene];
    
    // Tạo SCNGeometry (hình cầu) và SCNMaterial (màu đỏ)
    SCNGeometry *sphere = [BobbyGeometry geometryWithType:@"sphere" parameters:@{@"radius": @1.0}];
    SCNMaterial *material = [BobbyGame3D materialWithColor:[UIColor redColor]];
    
    // Tạo đối tượng BobbyGeometry và áp dụng material
    BobbyGeometry *geometryObj = [[BobbyGeometry alloc] init];
    geometryObj.geometry = sphere;  // Gán geometry cho đối tượng BobbyGeometry
    [geometryObj setMaterial:material];  // Áp dụng material cho geometry
    
    // Tạo SCNNode từ geometryObj và thêm vào scene
    SCNNode *node = [SCNNode nodeWithGeometry:geometryObj.geometry];  // Sử dụng geometry từ BobbyGeometry
    [self.scene.rootNode addChildNode:node];
    
    // Hiển thị scene (nếu bạn đang sử dụng SCNView)
    SCNView *scnView = (SCNView *)self.view;
    scnView.scene = self.scene;
}

@end
