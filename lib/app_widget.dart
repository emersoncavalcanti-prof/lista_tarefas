import 'package:flutter/material.dart';
import 'package:lista_tarefas/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    carregaTema();
  }

  void carregaTema() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? temaSalvo = pref.getBool('isDark');

    setState(() {
      isDark = temaSalvo ?? false;
    });
  }

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(onToggleChanged: toggleTheme, isDarkMode: isDark),
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
    );
  }
}
