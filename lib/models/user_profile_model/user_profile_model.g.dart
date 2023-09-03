// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      userUID: json['userUID'] as String,
      userName: json['userName'] as String,
      userCNIC: json['userCNIC'] as String,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      userMobile: json['userMobile'] as String,
      userStatus: json['userStatus'] as bool,
      province: json['province'] as String,
      tehsil: json['tehsil'] as String,
      district: json['district'] as String,
      operationsUID: json['operationsUID'] as String,
      zonalManagerUID: json['zonalManagerUID'] as String,
      salesManagerUID: json['salesManagerUID'] as String,
      salesOfficerUID: json['salesOfficerUID'] as String,
      creditLimit: (json['creditLimit'] as num).toDouble(),
      franchiseeUID: json['franchiseeUID'] as String,
      ntn: json['ntn'] as String,
      isFiler: json['isFiler'] as bool,
      availableCredit: (json['availableCredit'] as num).toDouble(),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'userUID': instance.userUID,
      'userName': instance.userName,
      'userCNIC': instance.userCNIC,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'userMobile': instance.userMobile,
      'userStatus': instance.userStatus,
      'province': instance.province,
      'district': instance.district,
      'tehsil': instance.tehsil,
      'creditLimit': instance.creditLimit,
      'availableCredit': instance.availableCredit,
      'isFiler': instance.isFiler,
      'ntn': instance.ntn,
      'franchiseeUID': instance.franchiseeUID,
      'operationsUID': instance.operationsUID,
      'zonalManagerUID': instance.zonalManagerUID,
      'salesManagerUID': instance.salesManagerUID,
      'salesOfficerUID': instance.salesOfficerUID,
    };

const _$UserTypeEnumMap = {
  UserType.salesManager: 'salesManager',
  UserType.zonalManager: 'zonalManager',
  UserType.dealer: 'dealer',
  UserType.salesOfficer: 'salesOfficer',
  UserType.operations: 'operations',
  UserType.franchisee: 'franchisee',
};
