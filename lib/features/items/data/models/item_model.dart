import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: (json['thumbnail'] ?? json['imageUrl'] ?? '') as String,
    );
  }

  Map<String, dynamic> toCreateJson() => {
        'title': title,
        'description': description,
        'thumbnail': imageUrl,
      };

  Map<String, dynamic> toUpdateJson() => {
        'title': title,
        'description': description,
        'thumbnail': imageUrl,
      };
}
