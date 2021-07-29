class Userprofile {
  String phonenumber;
  String username;
  final String profileImage;
  final String lastAccessTime;
  final String followers;
  final String following;
  final bool isNewUser;

  Userprofile({
    this.phonenumber,
    this.username,
    this.profileImage,
    this.followers,
    this.following,
    this.lastAccessTime,
    this.isNewUser,
  });

  factory Userprofile.fromJson(json) {
    return Userprofile(
      phonenumber: json['name'],
      username: json['username'],
      profileImage: json['profileImage'],
      lastAccessTime: json['lastAccessTime'],
      followers: json['followers'],
      following: json['following'],
      isNewUser: json['isNewUser'],
    );
  }
}
