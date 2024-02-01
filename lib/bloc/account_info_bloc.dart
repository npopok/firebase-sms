import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_sms/models/models.dart';
import 'package:firebase_sms/repositories/repositories.dart';

part 'account_info_event.dart';
part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  final AccountRepository repository;

  AccountInfoBloc(this.repository) : super(AccountInfoInitial()) {
    on<AccountInfoGet>((event, emit) {
      emit(AccountInfoGot(repository.getData()));
    });
    on<AccountInfoUpdate>((event, emit) {
      repository.updateData(event.accountInfo);
      emit(AccountInfoUpdated(event.accountInfo));
    });
  }
}
