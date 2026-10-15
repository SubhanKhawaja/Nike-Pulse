import 'package:flutter/material.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';
import 'state/app_state.dart';

class NikePulseApp extends StatefulWidget {
  const NikePulseApp({super.key});

  @override
  State<NikePulseApp> createState() => _NikePulseAppState();
}

class _NikePulseAppState extends State<NikePulseApp> {
  final AppState _appState = AppState();

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      appState: _appState,
      child: ListenableBuilder(
        listenable: _appState.themeController,
        builder: (context, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            themeMode: _appState.themeController.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const MainNavigationScreen(),
          );
        },
      ),
    );
  }
}
