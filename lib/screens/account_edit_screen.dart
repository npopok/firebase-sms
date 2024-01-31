import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountEditScreen extends StatefulWidget {
  final String title;
  final String value;

  const AccountEditScreen({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final FocusNode focusNode = FocusNode();

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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: TextFormField(
          focusNode: focusNode,
          initialValue: widget.value,
          onFieldSubmitted: (value) => context.pop(value),
        ),
      ),
    );
  }
}
