part of 'phone_auth_bloc.dart';

class PhoneAuthEvent {}

class PhoneAuthReset extends PhoneAuthEvent {}

class PhoneAuthSendCode extends PhoneAuthEvent {
  final String phoneNumber;
  PhoneAuthSendCode(this.phoneNumber);
}

class PhoneAuthTicker extends PhoneAuthEvent {
  final int duration;
  PhoneAuthTicker(this.duration);
}

class PhoneAuthSignIn extends PhoneAuthEvent {
  String verificationId;
  String smsCode;
  PhoneAuthSignIn(this.smsCode, this.verificationId);
}
