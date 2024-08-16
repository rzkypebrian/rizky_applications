import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  EnumType enumType;
  set setEnumType(EnumType enumType) {
    this.enumType = enumType;
    commit();
  }

  String maintenaceId = "m0001";

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  MaintenanceItemModel maintenancesModel = MaintenanceItemModel();
  set setmaintenancesModel(MaintenanceItemModel mm) {
    this.maintenancesModel = mm;
    this.maintenaceId = mm.maintenanceId;
    this.activitesController.text = mm.activity;
    this.priorityModel = mm.priority;
    this.threshHoldModel = mm.threshHoldModel;
    this.thresholdController.text = mm.threshHoldModel.maintenanceItemId == 1
        ? "${DateFormat('yyyy-MM-dd').format(mm.thresholdDate)}"
        : "${mm.threshold}";
    this.repeat = mm.repeat;
    listShowbefore.forEach((e) {
      if (e == mm.showBeforeModel) {
        this.selectedShowBeforeModel = mm.showBeforeModel;
      }
    });
    this.assetModel = mm.asset;
    this.assetsModel = mm.assetsModel;
    this.categoryModel = mm.catergory;
    var i = 0;
    if (mm.instructionModels != null) {
      mm.instructionModels.forEach((e) {
        this.intructionController.add(InputComponentTextEditingController());
        intructionController[i].text = "${e.name}";
        i++;
      });
    }
    commit();
  }

  List<InputComponentTextEditingController> intructionController =
      <InputComponentTextEditingController>[
    InputComponentTextEditingController(),
  ];

  void addInstruction() {
    this.intructionController.add(InputComponentTextEditingController());
    commit();
  }

  void removeInstruction(InputComponentTextEditingController ic) {
    this.intructionController.remove(ic);
    commit();
  }

  bool get statusAddInstruction {
    if (intructionController.length > 1)
      return true;
    else
      return false;
  }

  InputComponentTextEditingController activitesController =
      InputComponentTextEditingController();
  InputComponentTextEditingController thresholdController =
      InputComponentTextEditingController();

  List<PriorityModel> listPriority = PriorityModel.dummy;
  List<ThreshHoldModel> listThreshHold = ThreshHoldModel.dummy;

  PriorityModel priorityModel = PriorityModel.dummy.first;
  void onChangedPriority(PriorityModel pm) {
    this.priorityModel = pm;
    commit();
  }

  ThreshHoldModel threshHoldModel = ThreshHoldModel.dummy.first;
  void onChangedThreshHold(ThreshHoldModel thm) {
    this.threshHoldModel = thm;
    thresholdController.text = "";
    selectedShowBeforeModel = null;
    commit();
  }

  ThreshHoldModel get getThreshHoldModel => this.threshHoldModel;

  bool repeat = false;
  void changeRepaet(bool status) {
    this.repeat = status;
    commit();
  }

  List<ShowBeforeModel> get listShowbefore => ShowBeforeModel.dummy
      .where((e) => e.typeThreshold == getThreshHoldModel.maintenanceItemId)
      .toList();

  ShowBeforeModel selectedShowBeforeModel;
  void onChangedShowBeforeModel(ShowBeforeModel sbm) {
    this.selectedShowBeforeModel = sbm;
    commit();
  }

  List<AssetModel> assetModels = AssetModel.dummy;
  AssetModel assetModel;
  void changedassetModel(AssetModel am) {
    this.assetModel = am;
    commit();
  }

  List<AssetsModel> assetsModels = AssetsModel.dummy;
  AssetsModel assetsModel;
  void changedAssetModel(AssetsModel am) {
    this.assetsModel = am;
    commit();
  }

  List<CategoryModel> listCategoryModel = CategoryModel.dummy;
  CategoryModel categoryModel;
  void changedCategoryModel(CategoryModel cm) {
    this.categoryModel = cm;
    commit();
  }

  void saveMaintenance({VoidCallback onFinisLoading}) {
    List<InstructionModel> listInstructionModel = [];
    intructionController.forEach((e) {
      if (e.text.isNotEmpty) {
        var aa = InstructionModel(name: "${e.text}");
        listInstructionModel.add(aa);
      }
    });
    this.maintenancesModel = MaintenanceItemModel(
      maintenanceId: maintenaceId,
      activity: activitesController.text,
      priority: priorityModel,
      threshHoldModel: getThreshHoldModel,
      thresholdDate: getThreshHoldModel.maintenanceItemId == 1
          ? DateTime.parse(thresholdController.text)
          : null,
      threshold: getThreshHoldModel.maintenanceItemId != 1
          ? int.parse(thresholdController.text)
          : null,
      repeat: repeat,
      showBeforeModel: selectedShowBeforeModel,
      asset: assetModel,
      assetsModel: assetsModel,
      catergory: categoryModel,
      instructionModels: listInstructionModel,
      dateTime: DateTime.now(),
    );
    commit();
    this.controller.stopLoading(
          isError: false,
          duration: Duration(seconds: 3),
          messageAlign: Alignment.topCenter,
          onFinishCallback: onFinisLoading,
          messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.greenColor,
              message: enumType == EnumType.EditData
                  ? "${System.data.resource.dataUpdatedSuccessfully}"
                  : "${System.data.resource.dataSentSuccessfully}"),
        );
  }
}
