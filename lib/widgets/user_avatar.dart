import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatar extends StatefulWidget {
  static const backgroundColor = Color(0xFFE3E3E3);
  static const iconColor = Color(0xFF0098EE);
  static const bottomTextColor = Color(0XFF0098EE);

  final String initialValue;
  final Function(String) onSaved;

  const UserAvatar({
    required this.initialValue,
    required this.onSaved,
    super.key,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  String? imageFile;

  @override
  void initState() {
    imageFile = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 90,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: UserAvatar.backgroundColor,
              radius: 38,
              foregroundImage:
                  imageFile == null ? null : Image.file(File(imageFile!), fit: BoxFit.cover).image,
              child: const Icon(
                Icons.person,
                size: 60,
                color: UserAvatar.iconColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 32,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: const CircleBorder(),
                  side: BorderSide.none,
                ),
                onPressed: () => _selectImageHandler(context),
                child: const Icon(
                  Icons.more_horiz,
                  size: 32,
                  color: UserAvatar.iconColor,
                ),
              ),
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
            SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'AccountScreen.SelectPhoto'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(
                'AccountScreen.Camera'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: UserAvatar.bottomTextColor,
                    ),
              ),
              onTap: () => _pickImage(context, ImageSource.camera),
            ),
            const Divider(),
            ListTile(
              title: Text(
                'AccountScreen.Gallery'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: UserAvatar.bottomTextColor,
                    ),
              ),
              onTap: () => _pickImage(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }

  void _pickImage(BuildContext context, ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      setState(() => imageFile = file.path);
      if (context.mounted) context.pop();
      widget.onSaved(imageFile!);
    }
  }
}
