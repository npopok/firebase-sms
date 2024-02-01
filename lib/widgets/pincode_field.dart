import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PincodeField extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;

  const PincodeField({
    required this.length,
    required this.onCompleted,
    super.key,
  });

  @override
  State<PincodeField> createState() => _PincodeFieldState();
}

class _PincodeFieldState extends State<PincodeField> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      focusNode: focusNode,
      length: widget.length,
      showCursor: false,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      onCompleted: (value) => widget.onCompleted(value),
      defaultPinTheme: const PinTheme(
        width: 40,
        height: 46,
        textStyle: TextStyle(
          fontSize: 28,
          color: Color(0xFF4F4F4F),
          fontWeight: FontWeight.w400,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2, color: Color(0xFFA7A7A7)),
          ),
        ),
      ),
    );
  }
}
