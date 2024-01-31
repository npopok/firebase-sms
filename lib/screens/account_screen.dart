import 'package:firebase_sms/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:firebase_sms/bloc/bloc.dart';
import 'package:firebase_sms/models/models.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final accountBloc = AccountInfoBloc();

  @override
  void initState() {
    accountBloc.add(AccountInfoLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccountScreen.Title'.tr()),
      ),
      body: BlocBuilder<AccountInfoBloc, AccountInfoState>(
        bloc: accountBloc,
        builder: (context, state) {
          if (state is AccountInfoLoaded) {
            return _buildBody(context, state.accountInfo);
          }
          if (state is AccountInfoUpdated) {
            return _buildBody(context, state.accountInfo);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AccountInfo accountInfo) {
    return Column(
      children: [
        UserAvatar(initialValue: accountInfo.imageFile),
        const SizedBox(height: 12),
        Text(accountInfo.email),
        ListView(
          shrinkWrap: true,
          children: [
            UserInfoTile(
              leading: 'AccountScreen.FirstName'.tr(),
              title: accountInfo.firstName,
              onTap: () => _editFieldHandler(
                context,
                'AccountScreen.FirstName'.tr(),
                accountInfo.firstName,
                (value) => accountBloc.add(
                  AccountInfoUpdate(accountInfo.copyWith(firstName: value)),
                ),
              ),
            ),
            UserInfoTile(
              leading: 'AccountScreen.LastName'.tr(),
              title: accountInfo.lastName,
              onTap: () => _editFieldHandler(
                context,
                'AccountScreen.LastName'.tr(),
                accountInfo.lastName,
                (value) => accountBloc.add(
                  AccountInfoUpdate(accountInfo.copyWith(lastName: value)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _editFieldHandler(
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
