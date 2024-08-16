import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:flutter/material.dart';
import 'package:enerren/model/UomModel.dart';
import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';

import 'package:enerren/component/InputComponent.dart';

class DoHomeViewer extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  List<ShipmentItemDescriptionViewModel> doModelList = [];
  bool checkAll = false;
  bool choise = false;
  ShipmentItemDescriptionViewModel selectedDoModel;
  int selectedId = 0;
  bool update = true;
  int idDestination;

  List<ShipmentItemDescriptionViewModel> doModelListUpdateSelected = [];

  // List<ShipmentItemDescriptionViewModel> get doModelListisChecked => doModelList.where((f)=>!f.isChecked).toList();

  ScrollController scrollController;

  void changeSelected(int i) {
    doModelList[i].isChecked = !doModelList[i].isChecked;

    if (getTotalCheck == doModelList.length) {
      checkAll = true;
    } else {
      checkAll = false;
    }

    if (getTotalCheck == 1) {
      var a = doModelList.firstWhere((f) => f.isChecked == true);
      selectedDoModel = a;
    } else {
      removeSelectedDoModel();
    }
    commit();
  }

  List<ShipmentItemDescriptionViewModel> get getAllUpdate {
    doModelListUpdateSelected = [];
    doModelList.where((ff) => ff.isChecked).forEach((f) {
      doModelListUpdateSelected.add(
        ShipmentItemDescriptionViewModel(
          tmsShipmentId: f.tmsShipmentId,
          detailshipmentId: f.detailshipmentId,
          podDetailshipmentId: f.podDetailshipmentId,
          itemId: f.itemId,
          item: f.item,
          itemDescription: f.itemDescription,
          qty: f.qty,
          remarks: f.remarks,
          uomCode: f.uomCode,
          uomName: f.uomName,
          isChecked: f.isChecked,
          insertedBy: f.insertedBy,
          modifiedBy: f.modifiedBy,
        ),
      );
    });
    return doModelListUpdateSelected;
  }

  void removeSelectedDoModel() {
    selectedDoModel = ShipmentItemDescriptionViewModel();
    commit();
  }

  void checkAlls() {
    checkAll = !checkAll;
    doModelList.forEach((f) {
      f.isChecked = checkAll;
    });
    commit();
  }

  void choises() {
    if (doModelList.length == 0) {
      checkAll = false;
      choise = false;
      removeSelectedDoModel();
    } else {
      choise = !choise;
      if (choise == false) {
        doModelList.forEach((f) {
          f.isChecked = choise;
        });
        removeSelectedDoModel();
      }
    }

    commit();
  }

  int get getTotalCheck =>
      doModelList.where((t) => t.isChecked == true).toList().length;

  void commit() {
    notifyListeners();
  }

  List<int> get getListIdDeleted {
    List<int> a = [];
    doModelList.where((t) => t.isChecked == true).forEach((f) {
      a.add(f.itemId);
    });
    return a;
  }

  void delete() {
    // List<int> itemId = [];
    // if (getTotalCheck == doModelList.length) {
    //   doModelList.forEach((f) {
    //     itemId.add(f.itemId);
    //   });
    //   doModelList.clear();
    // } else {

    // doModelList.where((w) => w.isChecked).forEach((f) {
    //   itemId.add(f.itemId);
    //   // doModelList.removeWhere((ff) => ff.itemId == f.itemId);
    // });
    // doModelList.removeWhere((f) => f.isChecked);
    // }

    if (doModelList.length == 0) {
      checkAll = false;
      choise = false;
    }
    commit();
  }
}

class DoModelController
    extends ValueNotifier<ShipmentItemDescriptionViewModel> {
  DoModelController({ShipmentItemDescriptionViewModel value})
      : super(value == null ? ShipmentItemDescriptionViewModel() : value);
  bool valid = false;
  List<UomModel> units = [];
  List<TmsShipmentDestinationModel> destinations = [];
  UomModel selectedUomModel = UomModel();
  TmsShipmentDestinationModel selectedDestination =
      TmsShipmentDestinationModel();

  void changeTotal(bool increase) {
    if (increase) {
      value.qty++;
    } else {
      value.qty--;
      value.qty = value.qty <= 0 ? 0 : value.qty;
    }
    commit();
  }

  UomModel getDefaultUomModel({String uomCode}) {
    if (uomCode != null)
      return units.where((f) => f.uomCode == uomCode).first;
    else
      return units.first;
  }

  void changeUnit(UomModel s) {
    selectedUomModel = s;
    value.uomCode = s.uomCode;
    value.uomName = s.uomName;
    commit();
  }

  void setDoModel(ShipmentItemDescriptionViewModel doModel) {
    value = doModel;
    commit();
  }

  void empty() {
    value = ShipmentItemDescriptionViewModel();
    commit();
  }

  String get defaulfValue {
    return value.qty ?? units.first;
  }

  int get getTotal => value.qty ?? 0;

  void commit() {
    notifyListeners();
  }

  bool validName() {
    print("validatename name error");
    if (value.item.isEmpty) {
      value.itemNameContoller.setStateInput = StateInput.Error;
      return false;
    } else {
      return null;
    }
  }

  bool validDesc() {
    if (value.itemDescription.isEmpty) {
      value.itemDescController.setStateInput = StateInput.Error;
      return false;
    } else {
      return null;
    }
  }

  bool validTotal() {
    if (value.qty == 0) {
      value.qtyItemCOntroller.setStateInput = StateInput.Error;
      return false;
    } else {
      return null;
    }
  }

  bool validUnit() {
    if (value.uomCode == null) {
      value.uomCode = units.first.uomCode;
      value.uomName = units.first.uomName;
      return null;
    } else {
      return null;
    }
  }

  bool checkAll({
    bool validateQty = true,
    bool validateUnit = true,
  }) {
    bool isValid = true;

    isValid = validName() ?? isValid;
    isValid = validDesc() ?? isValid;
    if (validateUnit) isValid = validUnit() ?? isValid;
    if (validateQty) isValid = validTotal() ?? isValid;

    notifyListeners();
    return isValid;
  }

  ShipmentItemDescriptionViewModel get getAll => value;

  void clear() {
    value = ShipmentItemDescriptionViewModel();
    empty();
    value.itemNameContoller.text = "";
    value.itemDescController.text = "";
  }

  void setTotal(int i) => value.qty = i;

  TmsShipmentDestinationModel getDefaultDestinationModel({int destinationid}) {
    // if (destinationid == null) return null;

    // print("detaildestinationid $destinationid");

    if (destinationid != null) {
      TmsShipmentDestinationModel a =
          destinations.where((f) => f.detailshipmentId == destinationid)?.first;
      value.podDetailshipmentId = a.detailshipmentId;
      return a;
    } else
      value.podDetailshipmentId = destinations?.first?.detailshipmentId;
    return destinations?.first;
    // return null;
  }

  void changeDestination(TmsShipmentDestinationModel s) {
    selectedDestination = s;
    value.podDetailshipmentId = s.detailshipmentId;
    commit();
  }
}
