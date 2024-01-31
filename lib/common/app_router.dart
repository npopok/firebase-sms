import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:firebase_sms/screens/screens.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter instance = GoRouter(
    initialLocation: '/projects',
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/registration',
        builder: (_, __) => const RegistrationScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (_, __, child) => NoTransitionPage(
          child: NavbarScreen(child: child),
        ),
        routes: [
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: '/projects',
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ProjectsScreen(),
            ),
          ),
          GoRoute(
              parentNavigatorKey: shellNavigatorKey,
              path: '/account',
              pageBuilder: (_, __) => const NoTransitionPage(
                    child: AccountScreen(),
                  ),
              routes: [
                GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: 'account_edit',
                  builder: (_, state) => AccountEditScreen(
                    title: state.uri.queryParameters['title']!,
                    value: state.uri.queryParameters['value']!,
                  ),
                ),
              ]),
        ],
      )
    ],
  );
}
