import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final VoidCallback? onTap;
  const ItemListTile({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(item.imageUrl)),
      title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: onTap,
    );
  }
}
