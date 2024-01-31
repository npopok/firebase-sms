import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UserInfoTile extends StatelessWidget {
  static const arrowColor = Color(0xFFC6C6C8);

  final String leading;
  final String title;
  final VoidCallback? onTap;

  const UserInfoTile({
    required this.leading,
    required this.title,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      title: title.isNotEmpty
          ? Text(
              title,
              textAlign: TextAlign.right,
            )
          : Text(
              'AccountScreen.EditField'.tr(),
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.labelLarge,
            ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: arrowColor,
      ),
      onTap: onTap,
    );
  }
}
