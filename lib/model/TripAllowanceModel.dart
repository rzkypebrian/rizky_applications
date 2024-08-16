import 'package:json_annotation/json_annotation.dart';
part 'TripAllowanceModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TripAllowanceSummaryModel {
  int walletId;
  int summaryId;
  DateTime recordDatetime;
  double expenseValue;
  String expenseDescription;
  String expenseFileGuid;
  String expenseFile;
  int fileStorageOption;
  String remarks;

  TripAllowanceSummaryModel({
    this.walletId,
    this.summaryId,
    this.recordDatetime,
    this.expenseValue,
    this.expenseDescription,
    this.expenseFileGuid,
    this.expenseFile,
    this.fileStorageOption,
    this.remarks,
  });

  factory TripAllowanceSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$TripAllowanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$TripAllowanceModelToJson(this);
}
