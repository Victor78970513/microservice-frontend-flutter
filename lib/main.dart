import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_tancara/provider/create_task_provider.dart';
import 'package:reto_tancara/provider/home_provider.dart';
import 'package:reto_tancara/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateTaskProvider(),
        )
      ],
      child: const MaterialApp(
        title: 'Material App',
        home: HomeScreen(),
      ),
    );
  }
}
