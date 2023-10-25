import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

const names = [
  'Omar',
  'Yasmin',
  'Fofa',
  'Zeina',
  'Zayna',
  'Adam',
  'Batta',
  'Panda',
  'Dina',
  'icy',
  'saint',
  'shakira',
  'starzee',
  'orange',
  'Doom',
  'Ahmed',
  'Ahmed',
  'egirl',
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);

final nameProvider = FutureProvider(
  (ref) async {
    final count = await ref.watch(
      tickerProvider.future,
    );
    return names.getRange(0, count);
  },
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream provider'),
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    names.elementAt(index),
                  ),
                );
              });
        },
        error: (error, stackTrace) => const Text('reached end of text'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
