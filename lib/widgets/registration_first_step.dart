import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'step_indicator.dart';
import 'phone_text_field.dart';

class RegistrationFirstStep extends StatelessWidget {
  final GlobalKey formKey;
  final String errorMessage;
  final bool isSending;
  final Function(String) onSavePhone;
  final Function() onSendButton;

  const RegistrationFirstStep({
    required this.formKey,
    required this.errorMessage,
    required this.isSending,
    required this.onSavePhone,
    required this.onSendButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 4),
          const StepIndicator(maxSteps: 3, currentStep: 0),
          const SizedBox(height: 24),
          Text(
            'RegistrationScreen.Title1'.tr(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            child: Text(
              'RegistrationScreen.PhonePrompt'.tr(),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 38),
          SizedBox(
            height: 24,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'RegistrationScreen.PhoneLabel'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
          Form(
            key: formKey,
            child: PhoneTextField(
              label: 'RegistrationScreen.PhoneHint'.tr(),
              hint: 'RegistrationScreen.PhoneHint'.tr(),
              mask: 'RegistrationScreen.PhoneMask'.tr(),
              errorText: 'RegistrationScreen.PhoneError'.tr(),
              onSaved: (value) => onSavePhone(value!),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 20,
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 53,
                  width: 285,
                  child: ElevatedButton(
                    onPressed: onSendButton,
                    child: Text('RegistrationScreen.SendButton'.tr()),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'RegistrationScreen.ConsentText1'.tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                            text: 'RegistrationScreen.ConsentText2'.tr(),
                            style: const TextStyle(color: Color(0xFFFFB800)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse('https://flutter.dev'));
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Visibility(
            visible: isSending,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
