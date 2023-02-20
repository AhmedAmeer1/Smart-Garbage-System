class UserModel {
  String? uid;
  String? email;
  String? password;
  String? phoneNumber;
  String? routeName;

  UserModel({
    this.uid,
    this.email,
    this.password,
    this.phoneNumber,
    this.routeName,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      // firstName: map['firstName'],
      phoneNumber: map['phoneNumber'],
      routeName: map['routeName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'routeName': routeName,
    };
  }
}
