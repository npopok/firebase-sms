part of 'phone_auth_bloc.dart';

class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthCodeSending extends PhoneAuthState {}

class PhoneAuthCodeSent extends PhoneAuthState {
  final String verificationId;
  PhoneAuthCodeSent(this.verificationId);
}

class PhoneAuthCodeTicker extends PhoneAuthState {
  final int secondsLeft;
  PhoneAuthCodeTicker(this.secondsLeft);
}

class PhoneAuthInvalidPhone extends PhoneAuthState {}

class PhoneAuthInvalidCode extends PhoneAuthState {}

class PhoneAuthSucceeded extends PhoneAuthState {}

class PhoneAuthError extends PhoneAuthState {
  final Object? error;
  PhoneAuthError(this.error);
}
