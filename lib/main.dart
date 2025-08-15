import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injector.dart';
import 'features/items/presentation/bloc/item_bloc.dart';
import 'features/items/presentation/bloc/item_event.dart';
import 'features/items/presentation/pages/item_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC CRUD Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => locator<ItemBloc>()..add(ItemLoadRequested()),
        child: const ItemListPage(),
      ),
    );
  }
}
