import 'package:go_router/go_router.dart';

import 'package:firebase_sms/screens/screens.dart';

class AppRouter {
  static GoRouter instance = GoRouter(
    initialLocation: '/registration',
    routes: [
      GoRoute(
        path: '/registration',
        builder: (_, __) => const RegistrationScreen(),
        routes: [
          GoRoute(path: 'projects', builder: (_, __) => const ProjectsScreen()),
          GoRoute(path: 'account', builder: (_, __) => const AccountScreen()),
        ],
      ),
    ],
  );
}
