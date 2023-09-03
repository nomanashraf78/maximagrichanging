import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfile {
  String userUID;
  String userName;
  String userCNIC;
  UserType userType;
  String userMobile;
  bool userStatus;
  String province;
  String district;
  String tehsil;
  double creditLimit;
  double availableCredit;
  bool isFiler;
  String ntn;
  String franchiseeUID;
  String operationsUID;
  String zonalManagerUID;
  String salesManagerUID;
  String salesOfficerUID;
  UserProfile({
    required this.userUID,
    required this.userName,
    required this.userCNIC,
    required this.userType,
    required this.userMobile,
    required this.userStatus,
    required this.province,
    required this.tehsil,
    required this.district,
    required this.operationsUID,
    required this.zonalManagerUID,
    required this.salesManagerUID,
    required this.salesOfficerUID,
    required this.creditLimit,
    required this.franchiseeUID,
    required this.ntn,
    required this.isFiler,
    required this.availableCredit
  });

  updateUserProfile({
    required String newUserName,
    required String newUserCNIC,
  }) {
    userName = newUserName;
    userCNIC = newUserCNIC;
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

 enum UserType {
   salesManager,
   zonalManager,
   dealer,
   salesOfficer,
   operations,
   franchisee,
 }
