import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemLoadRequested extends ItemEvent {}

class ItemDetailRequested extends ItemEvent {
  final int id;
  ItemDetailRequested(this.id);
  @override
  List<Object?> get props => [id];
}

class ItemCreateRequested extends ItemEvent {
  final String title;
  final String description;
  final String imageUrl;
  ItemCreateRequested({required this.title, required this.description, required this.imageUrl});
  @override
  List<Object?> get props => [title, description, imageUrl];
}

class ItemUpdateRequested extends ItemEvent {
  final Item item;
  ItemUpdateRequested(this.item);
  @override
  List<Object?> get props => [item];
}

class ItemDeleteRequested extends ItemEvent {
  final int id;
  ItemDeleteRequested(this.id);
  @override
  List<Object?> get props => [id];
}
