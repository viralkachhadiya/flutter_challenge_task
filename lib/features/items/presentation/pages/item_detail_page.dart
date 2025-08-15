import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';
import 'item_form_page.dart';

class ItemDetailPage extends StatefulWidget {
  final int itemId;
  const ItemDetailPage({super.key, required this.itemId});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(ItemDetailRequested(widget.itemId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final item = context.read<ItemBloc>().state.selected;
              if (item == null) return;
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => ItemFormPage(existing: item)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text('Are you sure you want to delete this item?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                context.read<ItemBloc>().add(ItemDeleteRequested(widget.itemId));
                if (mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state.loading || state.selected == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final Item item = state.selected!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(imageUrl: item.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(item.description),
              ],
            ),
          );
        },
      ),
    );
  }
}
