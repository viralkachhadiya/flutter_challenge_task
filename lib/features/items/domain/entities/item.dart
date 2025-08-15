import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  const Item({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl];

  Item copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
