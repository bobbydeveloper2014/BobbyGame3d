# BobbyGame3d
This is a library to make a game 3d on ios or macos with uikit (macos with mac catalyst)
`BobbyGame3D` là thư viện Objective-C cho iOS/macOS (SceneKit + UIKit), giúp bạn dễ dàng tạo **geometry 3D**, **material**, và **shader** với **cache tự động** để tối ưu hiệu năng.

---

## 🔹 Yêu cầu
- iOS 11+ / macOS 10.15+ (Catalina) nếu dùng Mac Catalyst
- Xcode 11+
- SceneKit framework
- UIKit framework

---

## 🔹 Cài đặt

1. Copy file `BobbyGame3D.h` và `BobbyGame3D.m` vào project của bạn.
2. Đảm bảo import framework:
```objc
#import <SceneKit/SceneKit.h>
#import <UIKit/UIKit.h>
#import "BobbyGame3D.h"
````

3. Link SceneKit và UIKit vào project nếu chưa có.

---

## 🔹 Hướng dẫn sử dụng

### 1. Tạo Geometry

```objc
// Tạo một sphere với radius = 1.0
SCNGeometry *sphere = [BobbyGeometry geometryWithType:@"sphere"
                                            parameters:@{@"radius": @(1.0)}];

// Tạo một box với width=1, height=2, length=3, chamferRadius=0.1
SCNGeometry *box = [BobbyGeometry geometryWithType:@"box"
                                        parameters:@{@"width": @(1.0),
                                                     @"height": @(2.0),
                                                     @"length": @(3.0),
                                                     @"chamferRadius": @(0.1)}];
```

* **Cache tự động**: nếu geometry đã được tạo trước đó, thư viện sẽ dùng lại để tiết kiệm bộ nhớ và tăng hiệu năng.

---

### 2. Tạo Material

```objc
// Lấy material màu đỏ
SCNMaterial *redMaterial = [BobbyGame3D materialWithColor:[UIColor redColor]];

// Gán material cho geometry
BobbyGeometry *geomWrapper = [[BobbyGeometry alloc] init];
geomWrapper.geometry = sphere;
[geomWrapper setMaterial:redMaterial];
```

* **Cache tự động**: material cùng màu sẽ được reuse để giảm overhead.

---

### 3. Áp dụng Shader

```objc
NSString *fragmentShader = @"_output.color.rgb = _output.color.rgb * vec3(1.0, 0.5, 0.5);";
[geomWrapper applyShader:fragmentShader];
```

* Hỗ trợ **shader modifiers** của SceneKit.
* `SCNShaderModifierEntryPointFragment` được dùng mặc định.

---

### 4. Thêm geometry vào SceneKit scene

```objc
SCNScene *scene = [SCNScene new];
SCNNode *node = [SCNNode node];
node.geometry = geomWrapper.geometry;

[scene.rootNode addChildNode:node];

SCNView *sceneView = [[SCNView alloc] initWithFrame:self.view.bounds];
sceneView.scene = scene;
[self.view addSubview:sceneView];
```

* Kết hợp với UIKit: bạn có thể thêm **UIButton**, **UILabel**, HUD overlay trên SCNView.

---

## 🔹 Tips

* Sử dụng cache **giúp tối ưu performance** khi tạo nhiều geometry hoặc material giống nhau.
* Nim có thể gọi các hàm Objective-C này nếu bạn biên dịch Nim sang ObjC backend.
* Có thể mở rộng `BobbyGeometry` với nhiều loại geometry (cylinder, torus, plane…) theo nhu cầu.



Nếu bạn muốn, mình có thể viết thêm **README phiên bản “Dùng BobbyGame3D từ Nim”**, tức là hướng dẫn Nim gọi ObjC backend trực tiếp, tận dụng geometry, material, shader.  

Bạn có muốn mình làm luôn không?
```
