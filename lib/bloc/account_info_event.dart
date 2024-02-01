part of 'account_info_bloc.dart';

class AccountInfoEvent {}

class AccountInfoGet extends AccountInfoEvent {}

class AccountInfoUpdate extends AccountInfoEvent {
  AccountInfo accountInfo;
  AccountInfoUpdate(this.accountInfo);
}
