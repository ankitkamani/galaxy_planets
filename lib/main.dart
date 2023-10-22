import 'package:flutter/material.dart';
import 'package:galaxy_planets/controllers/FavProvider.dart';
import 'package:galaxy_planets/screens/HomeScreen.dart';
import 'package:galaxy_planets/screens/SpleshScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => FavProvider(),)],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Galaxy Planets',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16),bodyLarge: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
        ),
        darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark(brightness: Brightness.dark),
            useMaterial3: true,
            textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16),bodyLarge: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
        ),
        themeMode: Provider.of<FavProvider>(context).themeMode,
        home: const SpleshScreen(),
      ),
    );
  }
}