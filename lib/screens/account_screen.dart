import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_sms/bloc/bloc.dart';
import 'package:firebase_sms/models/models.dart';
import 'package:firebase_sms/widgets/widgets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountInfoBloc getBloc(BuildContext context) => BlocProvider.of<AccountInfoBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('AccountScreen.Title'.tr()),
        ),
      ),
      body: BlocBuilder<AccountInfoBloc, AccountInfoState>(
        bloc: getBloc(context),
        builder: (context, state) {
          if (state is AccountInfoInitial) {
            getBloc(context).add(AccountInfoGet());
          }
          if (state is AccountInfoGot) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          UserAvatar(
            initialValue: accountInfo.imageFile,
            onSaved: (value) => getBloc(context).add(
              AccountInfoUpdate(accountInfo.copyWith(imageFile: value)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            accountInfo.email,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 24),
          UserInfoCard(
            firstName: accountInfo.firstName,
            lastName: accountInfo.lastName,
            onSavedFirstName: (value) => getBloc(context).add(
              AccountInfoUpdate(accountInfo.copyWith(firstName: value)),
            ),
            onSavedLastName: (value) => getBloc(context).add(
              AccountInfoUpdate(accountInfo.copyWith(lastName: value)),
            ),
          ),
        ],
      ),
    );
  }
}
