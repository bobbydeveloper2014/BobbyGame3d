// BobbyGame3D.h
#import <SceneKit/SceneKit.h>  // Import SceneKit để sử dụng SCNNode, SCNGeometry, SCNMaterial...
#import <Metal/Metal.h>        // Import Metal để sử dụng MTLDevice, Metal shaders, và rendering pipeline...
#import <UIKit/UIKit.h>        // Import UIKit để sử dụng UIColor

// Khai báo lớp BobbyGeometry
@interface BobbyGeometry : NSObject

@property (nonatomic, strong) SCNGeometry *geometry;

// Phương thức để áp dụng material cho geometry
- (void)setMaterial:(SCNMaterial *)material;

// Phương thức để áp dụng shader cho geometry
- (void)applyShader:(NSString *)shader;

// Phương thức tĩnh để tạo geometry từ thông số và cache
+ (SCNGeometry *)geometryWithType:(NSString *)geometryType parameters:(NSDictionary *)params;

@end

// Khai báo lớp BobbyGame3D
@interface BobbyGame3D : NSObject

// Phương thức khởi tạo cache cho geometry và material
+ (void)initialize;

// Phương thức lấy SCNMaterial từ cache hoặc tạo mới nếu chưa có
+ (SCNMaterial *)materialWithColor:(UIColor *)color;

@end
