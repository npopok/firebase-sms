import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import 'package:firebase_sms/bloc/bloc.dart';
import 'package:firebase_sms/widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  static const int codeTimeout = 60;

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final authBloc = PhoneAuthBloc(
    codeTimeout: RegistrationScreen.codeTimeout,
    ticker: const Ticker(),
  );
  final formKey = GlobalKey<FormState>();
  String? phoneNumber;
  String? verificationId;
  bool isSending = false;
  bool isWaiting = false;
  int currentStep = 0;
  String errorMessage = '';
  int secondsLeft = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => authBloc.add(PhoneAuthReset()),
        ),
      ),
      body: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        bloc: authBloc,
        builder: (context, state) {
          if (state is PhoneAuthInitial ||
              state is PhoneAuthCodeSending ||
              state is PhoneAuthInvalidPhone) {
            currentStep = 0;
            if (state is PhoneAuthInvalidPhone) {
              isSending = false;
              errorMessage = 'RegistrationScreen.InvalidPhone'.tr();
            }
            return _buildFirstStepBody(context);
          }
          if (state is PhoneAuthCodeSent ||
              state is PhoneAuthCodeTicker ||
              state is PhoneAuthInvalidCode) {
            currentStep = 1;
            isSending = false;
            if (state is PhoneAuthCodeSent) {
              isWaiting = true;
              secondsLeft = RegistrationScreen.codeTimeout;
              verificationId = state.verificationId;
            }
            if (state is PhoneAuthCodeTicker) {
              isWaiting = true;
              secondsLeft = state.secondsLeft;
            }
            if (state is PhoneAuthInvalidCode) {
              isWaiting = false;
              errorMessage = 'RegistrationScreen.InvalidCode'.tr();
            }
            return _buildSecondStepBody(context);
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

  Widget _buildFirstStepBody(BuildContext context) {
    return Column(
      children: [
        Text(
          'RegistrationScreen.Title1'.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text('RegistrationScreen.PhonePrompt'.tr()),
        Form(
          key: formKey,
          child: PhoneTextField(
            label: 'RegistrationScreen.PhoneLabel'.tr(),
            hint: 'RegistrationScreen.PhoneHint'.tr(),
            mask: 'RegistrationScreen.PhoneMask'.tr(),
            onSaved: (value) => phoneNumber = value!,
          ),
        ),
        ElevatedButton(
          child: Text('RegistrationScreen.SendButton'.tr()),
          onPressed: () => _handleSendSmsButton(context),
        ),
        RichText(
          text: TextSpan(
            text: 'RegistrationScreen.ConsentText1'.tr(),
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              TextSpan(
                text: 'RegistrationScreen.ConsentText2'.tr(),
                style: const TextStyle(color: Color(0xFFFFB800)),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isSending,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        Visibility(
          visible: errorMessage.isNotEmpty,
          child: Text(errorMessage),
        ),
      ],
    );
  }

  Widget _buildSecondStepBody(BuildContext context) {
    return Column(
      children: [
        Text(
          'RegistrationScreen.Title2'.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text('RegistrationScreen.CodeHint'.tr(args: [phoneNumber!])),
        Pinput(
          length: 6, // Has to be 6 due to Firebase constraints in test mode
          onCompleted: (value) => _signInWithCode(value),
        ),
        Visibility(
          visible: isWaiting && secondsLeft > 0,
          child: Text('RegistrationScreen.SecondsLeft'.tr(args: [secondsLeft.toString()])),
        ),
        Visibility(
          visible: isWaiting && secondsLeft == 0,
          child: InkWell(
            child: Text('RegistrationScreen.SendAgain'.tr()),
            onTap: () => _handleSendAgainButton(),
          ),
        ),
        Visibility(
          visible: errorMessage.isNotEmpty,
          child: Text(errorMessage),
        ),
      ],
    );
  }

  void _handleSendSmsButton(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();

      isSending = true;
      errorMessage = '';
      authBloc.add(PhoneAuthSendCode(phoneNumber!));
    }
  }

  void _handleSendAgainButton() {
    isWaiting = false;
    authBloc.add(PhoneAuthSendCode(phoneNumber!));
  }

  void _signInWithCode(String code) {
    authBloc.add(PhoneAuthSignIn(code, verificationId!));
  }
}
