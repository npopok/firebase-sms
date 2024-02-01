import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String mask;
  final String errorText;

  final void Function(String?)? onSaved;

  const PhoneTextField({
    required this.label,
    required this.hint,
    required this.mask,
    required this.errorText,
    this.onSaved,
    super.key,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  FocusNode focusNode = FocusNode();

  String? validateText(String value) {
    return RegExp(r'^\+7\s\(\d\d\d\)\s\d\d\d\s\d\d\s\d\d$').hasMatch(value)
        ? null
        : widget.errorText;
  }

  @override
  void initState() {
    focusNode.addListener(() {
      // Call validation on losing focus
      if (!focusNode.hasFocus) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters: [
        MaskTextInputFormatter(
          mask: widget.mask,
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        )
      ],
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
      ),
      validator: (value) => validateText(value!),
      onSaved: widget.onSaved,
      onChanged: (value) {
        if (value.length == widget.mask.length) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
    );
  }
}
