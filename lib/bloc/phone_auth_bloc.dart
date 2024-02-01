import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1).take(ticks);
  }
}

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final int codeTimeout;
  final Ticker ticker;
  StreamSubscription<int>? tickerSubscription;

  PhoneAuthBloc({
    required this.codeTimeout,
    required this.ticker,
  }) : super(PhoneAuthInitial()) {
    on<PhoneAuthReset>((event, emit) {
      _stopTicker();
      emit(PhoneAuthInitial());
    });
    on<PhoneAuthTicker>((event, emit) {
      emit(PhoneAuthCodeTicker(event.duration));
    });
    on<PhoneAuthSendCode>((event, emit) async {
      try {
        emit(PhoneAuthCodeSending());
        Completer<PhoneAuthState> c = Completer<PhoneAuthState>();

        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          timeout: Duration(seconds: codeTimeout),
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            c.complete(PhoneAuthInvalidPhone());
          },
          codeSent: (String verificationId, int? resendToken) async {
            _startTicker(codeTimeout);
            c.complete(PhoneAuthCodeSent(verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        emit(await c.future);
      } catch (e) {
        emit(PhoneAuthError(e));
      }
    });
    on<PhoneAuthSignIn>((event, emit) async {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        _stopTicker();
        emit(PhoneAuthSucceeded());
      } catch (e) {
        emit(PhoneAuthInvalidCode());
      }
    });
  }

  @override
  Future<void> close() {
    tickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker(int duration) {
    tickerSubscription?.cancel();
    tickerSubscription = ticker.tick(ticks: duration).listen(
          (left) => add(PhoneAuthTicker(left)),
        );
    add(PhoneAuthTicker(codeTimeout));
  }

  void _stopTicker() {
    tickerSubscription?.cancel();
  }
}
