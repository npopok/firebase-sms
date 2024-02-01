part of 'account_info_bloc.dart';

class AccountInfoState {}

class AccountInfoInitial extends AccountInfoState {}

class AccountInfoGot extends AccountInfoState {
  AccountInfo accountInfo;
  AccountInfoGot(this.accountInfo);
}

class AccountInfoUpdated extends AccountInfoState {
  AccountInfo accountInfo;
  AccountInfoUpdated(this.accountInfo);
}
