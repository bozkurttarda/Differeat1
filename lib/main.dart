import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipepicker/contanst.dart';
import 'package:recipepicker/screens/home.dart';
import 'package:recipepicker/state/app_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // State; Data global vs.
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      // Design(Google)
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.orange,
          appBarTheme: const AppBarTheme().copyWith(
            color: Colors.orange,
          ),
        ),
        home: const Home(),
      ),
    );
  }
}
