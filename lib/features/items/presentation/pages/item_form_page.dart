import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_task/features/items/domain/entities/item.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';

class ItemFormPage extends StatefulWidget {
  final Item? existing;
  const ItemFormPage({super.key, this.existing});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _desc;
  late final TextEditingController _image;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.existing?.title ?? '');
    _desc = TextEditingController(text: widget.existing?.description ?? '');
    _image = TextEditingController(text: widget.existing?.imageUrl ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _image.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final bloc = context.read<ItemBloc>();
    if (widget.existing == null) {
      bloc.add(
        ItemCreateRequested(
          title: _title.text.trim(),
          description: _desc.text.trim(),
          imageUrl: _image.text.trim(),
        ),
      );
    } else {
      bloc.add(
        ItemUpdateRequested(
          widget.existing!.copyWith(
            title: _title.text.trim(),
            description: _desc.text.trim(),
            imageUrl: _image.text.trim(),
          ),
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Item' : 'Create Item')),
      body: BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _desc,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _image,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.save),
                    label: Text(isEdit ? 'Save Changes' : 'Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
