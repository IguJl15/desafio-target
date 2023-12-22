import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/stores/login_store.dart';
import 'auth/ui/login_page.dart';
import 'home/ui/home_page.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'shared/theme/color_schemes.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: ListenableBuilder(
        listenable: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            restorationScopeId: 'app',
            theme: ThemeData(colorScheme: lightColorScheme, fontFamily: "Ubuntu"),
            darkTheme: ThemeData(colorScheme: darkColorScheme, fontFamily: "Ubuntu"),
            themeMode: settingsController.themeMode,
            initialRoute: HomePage.routeName,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case HomePage.routeName:
                      return const HomePage();
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case LoginPage.routeName:
                    default:
                      return const LoginPage();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
