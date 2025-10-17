#import "BobbyGame3D.h"
#import <SceneKit/SceneKit.h>  // Đảm bảo import SceneKit
#import <UIKit/UIKit.h>         // Đảm bảo import UIKit

// Cache toàn cục cho geometry và material
static NSMutableDictionary<NSString *, SCNGeometry *> *geometryCache = nil;
static NSMutableDictionary<NSString *, SCNMaterial *> *materialCache = nil;

@implementation BobbyGeometry

// Phương thức để áp dụng material
- (void)setMaterial:(SCNMaterial *)material {
    self.geometry.firstMaterial = material;
}

// Phương thức để áp dụng shader
- (void)applyShader:(NSString *)shader {
    self.geometry.shaderModifiers = @{SCNShaderModifierEntryPointFragment : shader};
}

// Tạo geometry và cache
+ (SCNGeometry *)geometryWithType:(NSString *)geometryType parameters:(NSDictionary *)params {
    // Xây dựng một key duy nhất cho cache dựa trên geometryType và tham số
    NSString *cacheKey = [NSString stringWithFormat:@"%@-%@", geometryType, params.description];
    
    // Kiểm tra cache
    SCNGeometry *cachedGeometry = [geometryCache objectForKey:cacheKey];
    if (cachedGeometry) {
        return cachedGeometry;
    }
    
    // Tạo geometry mới nếu chưa có trong cache
    SCNGeometry *geometry = nil;
    if ([geometryType isEqualToString:@"sphere"]) {
        geometry = [SCNSphere sphereWithRadius:[params[@"radius"] floatValue]];
    } else if ([geometryType isEqualToString:@"box"]) {
        geometry = [SCNBox boxWithWidth:[params[@"width"] floatValue]
                                 height:[params[@"height"] floatValue]
                                  length:[params[@"length"] floatValue]
                           chamferRadius:[params[@"chamferRadius"] floatValue]];
    }
    
    // Lưu geometry vào cache
    if (geometry) {
        [geometryCache setObject:geometry forKey:cacheKey];
    }
    
    return geometry;
}

@end

@implementation BobbyGame3D

// Khởi tạo cache
+ (void)initialize {
    if (self == [BobbyGame3D class]) {
        geometryCache = [NSMutableDictionary dictionary];
        materialCache = [NSMutableDictionary dictionary];
    }
}

// Lấy SCNMaterial từ cache hoặc tạo mới
+ (SCNMaterial *)materialWithColor:(UIColor *)color {
    NSString *cacheKey = [color description];
    
    SCNMaterial *cachedMaterial = [materialCache objectForKey:cacheKey];
    if (cachedMaterial) {
        return cachedMaterial;
    }
    
    // Tạo material mới nếu chưa có trong cache
    SCNMaterial *material = [SCNMaterial material];
    material.diffuse.contents = color;
    
    // Lưu material vào cache
    [materialCache setObject:material forKey:cacheKey];
    
    return material;
}

@end
