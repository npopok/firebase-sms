part of 'account_info_bloc.dart';

class AccountInfoState {}

class AccountInfoInitial extends AccountInfoState {}

class AccountInfoLoaded extends AccountInfoState {
  AccountInfo accountInfo;
  AccountInfoLoaded(this.accountInfo);
}

class AccountInfoUpdated extends AccountInfoState {
  AccountInfo accountInfo;
  AccountInfoUpdated(this.accountInfo);
}
