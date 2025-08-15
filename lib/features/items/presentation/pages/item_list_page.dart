import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';
import '../pages/item_detail_page.dart';
import '../pages/item_form_page.dart';
import '../widgets/item_list_tile.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          if (state.loading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = state.items;
          if (items.isEmpty) {
            return const Center(child: Text('No items.'));
          }
          return RefreshIndicator(
            onRefresh: () async => context.read<ItemBloc>().add(ItemLoadRequested()),
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final Item item = items[index];
                return ItemListTile(
                  item: item,
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => ItemDetailPage(itemId: item.id)));
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  BlocProvider.value(value: context.read<ItemBloc>(), child: const ItemFormPage()),
            ),
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
