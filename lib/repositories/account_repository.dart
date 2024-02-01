import 'package:firebase_sms/models/models.dart';

class AccountRepository {
  AccountInfo? _accountInfo;

  void loadData() => _accountInfo = AccountInfo.empty().copyWith(email: 'test@test.com');

  AccountInfo getData() => _accountInfo ?? AccountInfo.empty();

  void updateData(AccountInfo value) => _accountInfo = value;
}
