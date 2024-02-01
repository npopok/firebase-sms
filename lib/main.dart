import 'package:firebase_sms/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_sms/common/common.dart';
import 'package:firebase_sms/repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountInfoBloc>(
          create: (context) => AccountInfoBloc(AccountRepository()..loadData()),
        ),
        BlocProvider<PhoneAuthBloc>(
          create: (context) => PhoneAuthBloc(codeTimeout: 60, ticker: const Ticker()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: AppRouter.instance,
        theme: Styles.theme(),
      ),
    );
  }
}
