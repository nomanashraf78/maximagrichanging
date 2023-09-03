import 'package:json_annotation/json_annotation.dart';
part 'dealer_credit_model.g.dart';

@JsonSerializable()
class DealersCredit {
  String dealerUID;
  double creditLimit;
  double availableCredit;
  DealersCredit({
    required this.dealerUID,
    required this.creditLimit,
    required this.availableCredit,
  });

  factory DealersCredit.fromJson(Map<String, dynamic> json) =>
      _$DealersCreditFromJson(json);
  Map<String, dynamic> toJson() => _$DealersCreditToJson(this);
}
