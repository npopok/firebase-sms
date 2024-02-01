import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'step_indicator.dart';
import 'pincode_field.dart';

class RegistrationSecondStep extends StatelessWidget {
  final String phoneNumber;
  final bool isWaiting;
  final int secondsLeft;
  final String errorMessage;
  final Function(String) onPinCompleted;
  final Function() onSendAgain;

  const RegistrationSecondStep({
    required this.phoneNumber,
    required this.isWaiting,
    required this.secondsLeft,
    required this.errorMessage,
    required this.onPinCompleted,
    required this.onSendAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(height: 4),
          const StepIndicator(maxSteps: 3, currentStep: 1),
          const SizedBox(height: 24),
          Text(
            'RegistrationScreen.Title2'.tr(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          Text(
            'RegistrationScreen.CodeHint'.tr(args: [phoneNumber]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PincodeField(
            length: 6,
            onCompleted: (value) => onPinCompleted(value),
          ),
          const SizedBox(height: 44),
          Visibility(
            visible: isWaiting && secondsLeft > 0,
            child: Text(
              'RegistrationScreen.SecondsLeft'.tr(args: [secondsLeft.toString()]),
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
            visible: isWaiting && secondsLeft == 0,
            child: InkWell(
              onTap: onSendAgain,
              child: Text(
                'RegistrationScreen.SendAgain'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFFFB800)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
