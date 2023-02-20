class UserModel{

  String? uid;
  String? email;
  // String? firstName;
  String? phoneNumber;
  String? muncipleArea;

  UserModel({
    this.uid, this.email, this.phoneNumber,this.muncipleArea,
  });


  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      // firstName: map['firstName'],
      phoneNumber: map['phoneNumber'],
      muncipleArea: map['muncipleArea'],
    );

  }


 Map<String,dynamic> toMap()
  {
    return {
      'uid': uid,
      'email': email,
      // 'firstName': firstName,
      'phoneNumber': phoneNumber,
      'muncipleArea': muncipleArea,
    };

  }



}