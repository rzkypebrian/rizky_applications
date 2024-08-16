class ProfileModel {
  String name;
  String phone;
  String email;
  String urlImmage;
  DateTime registeredDate;
  String address;

  ProfileModel({
    this.name,
    this.email,
    this.phone,
    this.urlImmage =
        "http://www.stickpng.com/assets/images/585e4bcdcb11b227491c3396.png",
    this.registeredDate,
    this.address,
  });

  Map<String, dynamic> toJson() => {
        "name": "$name",
        "email": "$email",
        "phone": "$phone",
        "urlImmage": "$urlImmage",
        "registeredDate": "$registeredDate",
        "address" : "$address",
      };

  static ProfileModel dummy() {
    return ProfileModel(
      name: "Nandang Hermawan",
      phone: "087724538083",
      email: "nandanghermawan@gmail.com",
      urlImmage:
          "http://www.stickpng.com/assets/images/585e4bcdcb11b227491c3396.png",
      registeredDate: DateTime(2018, 10, 12),
    );
  }
}
