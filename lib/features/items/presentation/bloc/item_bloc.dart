import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';
import 'package:flutter_challenge_task/features/items/domain/repositories/item_repository.dart';

import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository repository;

  ItemBloc({required this.repository}) : super(const ItemState()) {
    on<ItemLoadRequested>(_onLoad);
    on<ItemDetailRequested>(_onDetail);
    on<ItemCreateRequested>(_onCreate);
    on<ItemUpdateRequested>(_onUpdate);
    on<ItemDeleteRequested>(_onDelete);
  }

  Future<void> _onLoad(ItemLoadRequested event, Emitter<ItemState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final items = await repository.fetchItems();
      emit(state.copyWith(items: items, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onDetail(ItemDetailRequested event, Emitter<ItemState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final item = await repository.fetchItem(event.id);
      emit(state.copyWith(selected: item, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onCreate(ItemCreateRequested event, Emitter<ItemState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final newItem = await repository.createItem(
        title: event.title,
        description: event.description,
        imageUrl: event.imageUrl,
      );
      final updated = List<Item>.from(state.items)..insert(0, newItem);
      emit(state.copyWith(items: updated, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdate(ItemUpdateRequested event, Emitter<ItemState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final updatedItem = await repository.updateItem(event.item);
      final updatedList = state.items.map((i) => i.id == updatedItem.id ? updatedItem : i).toList();
      emit(state.copyWith(items: updatedList, selected: updatedItem, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onDelete(ItemDeleteRequested event, Emitter<ItemState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await repository.deleteItem(event.id);
      final updatedList = state.items.where((i) => i.id != event.id).toList();
      emit(state.copyWith(items: updatedList, selected: null, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
