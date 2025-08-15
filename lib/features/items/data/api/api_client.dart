import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  // LIST
  Future<Response> getProducts({int limit = 50}) =>
      _dio.get('/products', queryParameters: {'limit': limit});

  // DETAIL
  Future<Response> getProduct(int id) => _dio.get('/products/$id');

  // CREATE
  Future<Response> createProduct(Map<String, dynamic> data) =>
      _dio.post('/products/add', data: data);

  // UPDATE
  Future<Response> updateProduct(int id, Map<String, dynamic> data) =>
      _dio.put('/products/$id', data: data);

  // DELETE
  Future<Response> deleteProduct(int id) => _dio.delete('/products/$id');
}
