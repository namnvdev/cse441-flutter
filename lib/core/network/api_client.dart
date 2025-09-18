import 'dart:async';

class ApiClient {
  // Giả lập gọi GET và trả JSON sau 400ms
  Future<dynamic> get(String path) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (path == '/products') {
      //call a server api --> get dataset
      return [
        {"id": "p1", "name": "Táo Mỹ", "price": 2.5, "description": "Táo giòn ngọt"},
        {"id": "p2", "name": "Cam Úc", "price": 3.0, "description": "Cam mọng nước"},
        {"id": "p3", "name": "Xoài Cát", "price": 4.2, "description": "Xoài thơm dẻo"},
      ];
    }
    throw Exception('Unknown path: $path');
  }
}
