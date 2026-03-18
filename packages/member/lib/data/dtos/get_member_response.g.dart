// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMemberResponse _$GetMemberResponseFromJson(Map<String, dynamic> json) =>
    GetMemberResponse(
      items:
          (json['items'] as List<dynamic>?)?.map(
            (e) =>
                const GetMemberConverter().fromJson(e as Map<String, dynamic>),
          ) ??
          const [],
    );

Map<String, dynamic> _$GetMemberResponseToJson(GetMemberResponse instance) =>
    <String, dynamic>{
      'items': instance.items.map(const GetMemberConverter().toJson).toList(),
    };
