import 'package:advicer/3_application/pages/advice/advice_page.dart';
import 'package:advicer/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '3_application/core/services/theme_service.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        // TEMA CON COLORES CUSTOMIZADOS EN ARCHIVO theme.dart
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,

        // TEMA POR DEFECTO DE MATERIAL
        // theme: ThemeData(
        //   appBarTheme: const AppBarTheme(
        //     backgroundColor: Colors.amber,
        //   ),

        home: const AdvicerPageWrapperProvider(),
      );
    });
  }
}
