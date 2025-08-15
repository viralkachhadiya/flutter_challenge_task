import 'package:dio/dio.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';
import 'package:flutter_challenge_task/features/items/domain/repositories/item_repository.dart';
import '../api/api_client.dart';
import '../models/item_model.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ApiClient api;
  ItemRepositoryImpl(this.api);

  @override
  Future<List<Item>> fetchItems() async {
    final res = await api.getProducts(limit: 50);
    final data = res.data as Map<String, dynamic>;
    final List items = data['products'] as List? ?? [];
    return items.map((e) => ItemModel.fromJson(e)).toList();
  }

  @override
  Future<Item> fetchItem(int id) async {
    final res = await api.getProduct(id);
    return ItemModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<Item> createItem({required String title, required String description, required String imageUrl}) async {
    final res = await api.createProduct({
      'title': title,
      'description': description,
      'thumbnail': imageUrl,
    });
    return ItemModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<Item> updateItem(Item item) async {
    final res = await api.updateProduct(item.id, {
      'title': item.title,
      'description': item.description,
      'thumbnail': item.imageUrl,
    });
    return ItemModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      await api.deleteProduct(id);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200 || e.response?.statusCode == 204) {
        return;
      }
      rethrow;
    }
  }
}
