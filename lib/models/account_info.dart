class AccountInfo {
  final String imageFile;
  final String email;
  final String firstName;
  final String lastName;

  AccountInfo({
    required this.imageFile,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  AccountInfo.empty()
      : imageFile = '',
        email = 'test@test.com',
        firstName = '',
        lastName = '';

  AccountInfo copyWith({
    String? imageFile,
    String? email,
    String? firstName,
    String? lastName,
  }) =>
      AccountInfo(
        imageFile: imageFile ?? this.imageFile,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );
}
