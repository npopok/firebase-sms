import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:firebase_sms/bloc/bloc.dart';
import 'package:firebase_sms/widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  static const int codeTimeout = 60;

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  String? phoneNumber;
  String? verificationId;
  bool isSending = false;
  bool isWaiting = false;
  int currentStep = 0;
  String errorMessage = '';
  int secondsLeft = -1;

  PhoneAuthBloc getBloc(BuildContext context) => BlocProvider.of<PhoneAuthBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => getBloc(context).add(PhoneAuthReset()),
        ),
      ),
      body: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        bloc: getBloc(context),
        builder: (context, state) {
          currentStep = stateToStep(state);
          if (currentStep == 0) {
            errorMessage = '';
            if (state is PhoneAuthInvalidPhone) {
              isSending = false;
              errorMessage = 'RegistrationScreen.InvalidPhone'.tr();
            }
            return RegistrationFirstStep(
              formKey: formKey,
              errorMessage: errorMessage,
              isSending: isSending,
              onSavePhone: (value) => phoneNumber = value,
              onSendButton: () => _sendSmsHandler(context),
            );
          }
          if (currentStep == 1) {
            isSending = false;
            isWaiting = true;
            if (state is PhoneAuthCodeSent) {
              secondsLeft = RegistrationScreen.codeTimeout;
              verificationId = state.verificationId;
            }
            if (state is PhoneAuthCodeTicker) {
              secondsLeft = state.secondsLeft;
              if (secondsLeft == 0) errorMessage = '';
            }
            if (state is PhoneAuthInvalidCode) {
              errorMessage = 'RegistrationScreen.InvalidCode'.tr();
            }
            return RegistrationSecondStep(
              phoneNumber: phoneNumber!,
              isWaiting: isWaiting,
              secondsLeft: secondsLeft,
              errorMessage: errorMessage,
              onPinCompleted: (value) => _signInWithCode(context, value),
              onSendAgain: () => _sendAgainHandler(context),
            );
          }
          if (state is PhoneAuthSucceeded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/projects');
            });
          }
          if (state is PhoneAuthError) {
            return Center(child: Text('ServerError'.tr()));
          }
          return Container();
        },
      ),
    );
  }

  int stateToStep(PhoneAuthState state) {
    if (state is PhoneAuthCodeSending && currentStep == 1) {
      return 1;
    }

    if (state is PhoneAuthInitial ||
        state is PhoneAuthCodeSending ||
        state is PhoneAuthInvalidPhone) {
      return 0;
    }
    if (state is PhoneAuthCodeSent ||
        state is PhoneAuthCodeTicker ||
        state is PhoneAuthInvalidCode) {
      return 1;
    }
    return -1;
  }

  void _sendSmsHandler(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();

      isSending = true;
      errorMessage = '';
      getBloc(context).add(PhoneAuthSendCode(phoneNumber!));
    }
  }

  void _sendAgainHandler(BuildContext context) {
    isWaiting = false;
    getBloc(context).add(PhoneAuthSendCode(phoneNumber!));
  }

  void _signInWithCode(BuildContext context, String code) {
    getBloc(context).add(PhoneAuthSignIn(code, verificationId!));
  }
}
