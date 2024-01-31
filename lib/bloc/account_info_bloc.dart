import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_sms/models/models.dart';

part 'account_info_event.dart';
part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  AccountInfo accountInfo = AccountInfo.empty();

  AccountInfoBloc() : super(AccountInfoInitial()) {
    on<AccountInfoLoad>((event, emit) {
      emit(AccountInfoLoaded(accountInfo));
    });
    on<AccountInfoUpdate>((event, emit) {
      accountInfo = event.accountInfo;
      emit(AccountInfoUpdated(accountInfo));
    });
  }
}
