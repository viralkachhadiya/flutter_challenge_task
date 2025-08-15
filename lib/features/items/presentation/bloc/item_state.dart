import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';

class ItemState extends Equatable {
  final List<Item> items;
  final Item? selected;
  final bool loading;
  final String? error;

  const ItemState({
    this.items = const [],
    this.selected,
    this.loading = false,
    this.error,
  });

  ItemState copyWith({
    List<Item>? items,
    Item? selected,
    bool? loading,
    String? error,
  }) {
    return ItemState(
      items: items ?? this.items,
      selected: selected ?? this.selected,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, selected, loading, error];
}
