import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String mask;

  final void Function(String?)? onSaved;

  const PhoneTextField({
    required this.label,
    required this.hint,
    required this.mask,
    this.onSaved,
    super.key,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  String? validateText(String value) {
    return RegExp(r'^\+7\s\(\d\d\d\)\s\d\d\d\s\d\d\s\d\d$').hasMatch(value) ? null : '';
  }

  @override
  void initState() {
    // focusNode.addListener(() {
    //   if (!focusNode.hasFocus) {
    //     validateText();
    //     setState(() {});
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //  controller: controller,
      focusNode: focusNode,
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
    );
  }
}
