import '../entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> fetchItems();
  Future<Item> fetchItem(int id);
  Future<Item> createItem({required String title, required String description, required String imageUrl});
  Future<Item> updateItem(Item item);
  Future<void> deleteItem(int id);
}
