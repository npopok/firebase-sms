import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_sms/common/common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('ru')],
    path: 'assets/translations',
    fallbackLocale: const Locale('ru'),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: AppRouter.instance,
    );
  }
}
