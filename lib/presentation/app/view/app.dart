import 'package:flutter/material.dart';

import '../../authentication/view/authentication_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 212, 192, 218)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthenticationView(),
    );
  }
}
