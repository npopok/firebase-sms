import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatar extends StatefulWidget {
  final String initialValue;

  const UserAvatar({required this.initialValue, super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  String? imageFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 38,
            child: imageFile == null
                ? const Icon(Icons.person, size: 48)
                : Image.file(File(imageFile!)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              onPressed: () => _selectImageHandler(context),
              child: const Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
    );
  }

  void _selectImageHandler(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(
                'AccountScreen.SelectPhoto'.tr(),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(
                'AccountScreen.Camera'.tr(),
                textAlign: TextAlign.center,
              ),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            const Divider(),
            ListTile(
              title: Text(
                'AccountScreen.Gallery'.tr(),
                textAlign: TextAlign.center,
              ),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }

  void _pickImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      setState(() => imageFile = file.path);
    }
  }
}
