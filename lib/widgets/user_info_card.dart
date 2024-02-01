import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'user_info_tile.dart';

class UserInfoCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final Function(String) onSavedFirstName;
  final Function(String) onSavedLastName;

  const UserInfoCard({
    required this.firstName,
    required this.lastName,
    required this.onSavedFirstName,
    required this.onSavedLastName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        children: [
          UserInfoTile(
            leading: 'AccountScreen.FirstName'.tr(),
            title: firstName,
            onTap: () => _editNameHandler(
              context,
              'AccountScreen.FirstName'.tr(),
              firstName,
              (value) => onSavedFirstName(value),
            ),
          ),
          const Divider(),
          UserInfoTile(
            leading: 'AccountScreen.LastName'.tr(),
            title: lastName,
            onTap: () => _editNameHandler(
              context,
              'AccountScreen.LastName'.tr(),
              lastName,
              (value) => onSavedLastName(value),
            ),
          ),
        ],
      ),
    );
  }

  void _editNameHandler(
    BuildContext context,
    String title,
    String value,
    Function(String) onSaved,
  ) {
    context
        .push('/account/account_edit?title=$title&value=$value')
        .then((value) => value != null ? onSaved(value as String) : 0);
  }
}
