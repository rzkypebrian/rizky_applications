import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/component/spinnerComponent.dart';
import 'package:enerren/model/AttendanceItemModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'viewModel.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: super.model,
      child: Scaffold(
        backgroundColor: System.data.colorUtil.secondaryColor,
        appBar: appBar(),
        body: Container(
          child: Stack(
            children: [
              body(model),
              circularProgressIndicator(),
            ],
          ),
        ),
        bottomNavigationBar: submitButton(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.color009789,
      title: System.data.resource.attendance,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.lPlus,
      ),
    );
  }

  Widget circularProgressIndicator() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  Widget body(ViewModel model) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 17,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: itemList(),
        ),
      ),
    );
  }

  List<Widget> itemList() {
    return [
      attendanceItemForm(),
    ];
  }

  Widget attendanceItemForm({
    bool readOnly = false,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          intructionLabel(),
          Container(
            child: Consumer<ViewModel>(
              builder: (c, d, h) {
                return Column(
                  children: List.generate(
                    model.attendanceModel.listItemAttendance.length,
                    (index) => switchInput(
                        model.attendanceModel.listItemAttendance[index],
                        readOnly),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget intructionLabel() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        toBeginningOfSentenceCase(
            "${System.data.resource.pleaseCheckYourVehicleCondition}"),
        style: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.color009789,
          fontSize: System.data.fontUtil.m,
          fontFamily: System.data.fontUtil.primary,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget labelItem({
    String label,
  }) {
    return Container(
      width: 170,
      child: Text(
        toBeginningOfSentenceCase("$label"),
        style: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.darkTextColor,
            fontSize: System.data.fontUtil.m),
      ),
    );
  }

  Widget spinnerInput({
    String label,
    String typeCode,
    bool readOnly = false,
  }) {
    try {
      double.parse(super
              .model
              .attendanceModel
              .listItemAttendance
              .where((e) => e.typeCode == typeCode)
              .first
              .value ??
          "0");
    } catch (e) {
      super
          .model
          .attendanceModel
          .listItemAttendance
          .where((e) => e.typeCode == typeCode)
          .first
          .value = "0";
    }
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          labelItem(
            label: label,
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: readOnly == false
                  ? SpinnerInput(
                      spinnerValue: double.parse(super
                                  .model
                                  .attendanceModel
                                  .listItemAttendance
                                  .where((e) => e.typeCode == typeCode)
                                  .first
                                  .value ??
                              "0") ??
                          0,
                      middleNumberStyle: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.color009789,
                        textDecoration: TextDecoration.underline,
                        fontSize: System.data.fontUtil.l,
                      ),
                      minusButton: SpinnerButtonStyle(
                          height: 25,
                          width: 25,
                          color: System.data.colorUtil.lightTextColor,
                          textColor: System.data.colorUtil.color009789),
                      plusButton: SpinnerButtonStyle(
                          color: System.data.colorUtil.lightTextColor,
                          height: 25,
                          width: 25,
                          textColor: System.data.colorUtil.color009789),
                      onChange: (val) {
                        super
                            .model
                            .attendanceModel
                            .listItemAttendance
                            .where((e) => e.typeCode == typeCode)
                            .first
                            .value = val.toString();
                        model.commit();
                      },
                      minValue: 0,
                      maxValue: 100,
                    )
                  : Text(
                      "${double.parse(super.model.attendanceModel.listItemAttendance.where((e) => e.typeCode == typeCode).first.value).toInt()}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget checkboxInput({
    String label,
    String typeCode,
    bool readOnly = false,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 30,
      child: Row(
        children: [
          labelItem(
            label: label,
          ),
          readOnly == false
              ? Container(
                  child: Checkbox(
                    value: super
                                .model
                                .attendanceModel
                                .listItemAttendance
                                .where((e) => e.typeCode == typeCode)
                                .first
                                .value ==
                            "true"
                        ? true
                        : false,
                    onChanged: (val) {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .value = val.toString();
                      super.model.commit();
                    },
                    checkColor: System.data.colorUtil.color009789,
                    activeColor: Colors.white,
                  ),
                )
              : Icon(
                  FontAwesomeRegular(
                    super
                                .model
                                .attendanceModel
                                .listItemAttendance
                                .where((e) => e.typeCode == typeCode)
                                .first
                                .value ==
                            "true"
                        ? FontAwesomeId.fa_check
                        : FontAwesomeId.fa_times,
                  ),
                  size: 15,
                  color: super
                              .model
                              .attendanceModel
                              .listItemAttendance
                              .where((e) => e.typeCode == typeCode)
                              .first
                              .value ==
                          "true"
                      ? System.data.colorUtil.primaryColor
                      : System.data.colorUtil.redColor,
                ),
        ],
      ),
    );
  }

  Widget textareaInput({
    String label,
    String typeCode,
    bool readOnly = false,
  }) {
    InputComponentTextEditingController _controller =
        new InputComponentTextEditingController();
    _controller.text = super
        .model
        .attendanceModel
        .listItemAttendance
        .where((e) => e.typeCode == typeCode)
        .first
        .value;
    return Container(
      // margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 20, top: 5, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelItem(
            label: label,
          ),
          readOnly == false
              ? Container(
                  color: Colors.green,
                  height: 100,
                  margin: EdgeInsets.only(top: 15),
                  child: InputComponent.inputTextWithCorner(
                    readOnly: readOnly,
                    controller: _controller,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    backgroundColor: Colors.white,
                    borderInputGray: System.data.colorUtil.primaryColor,
                    hintText: System.data.resource.description,
                    corner: 5,
                    maxLines: 5,
                    expands: true,
                    borderWidth: 1,
                    contentPadding: EdgeInsets.only(
                      top: 10,
                      bottom: 5,
                      right: 15,
                      left: 15,
                    ),
                    textAlign: TextAlign.start,
                    onChanged: (val) {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .value = val;
                    },
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    // left: 20,
                    bottom: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(super
                        .model
                        .attendanceModel
                        .listItemAttendance
                        .where((e) => e.typeCode == typeCode)
                        .first
                        .value),
                  ),
                ),
        ],
      ),
    );
  }

  Widget filesInput({
    String label,
    String typeCode,
    bool readOnly,
  }) {
    MultipleImagePickerController _controller =
        new MultipleImagePickerController();
    super.addValueToImmagePicker(
      typeCode: typeCode,
      controller: _controller,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelItem(
            label: label,
          ),
          Container(
            child: MultipleImagePickerComponent(
              addButtonBuilder: readOnly == true ? (_) => SizedBox() : null,
              size: 75,
              galery: false,
              controller: _controller,
              imagePickerBuilder: (id, controller) {
                return ImagePickerComponent(
                  containerHeight: 72,
                  containerWidth: 67,
                  galery: false,
                  camera: !readOnly,
                  controller: controller,
                  container: (context, value) {
                    return Container(
                      width: 67,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(bottom: 10),
                              height: 72,
                              width: 67,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                  color: System.data.colorUtil.colorBorderImage,
                                ),
                                image: value.valueUri == null &&
                                        value.uploadedUrl == null
                                    ? null
                                    : value.uploadedUrl != null
                                        ? DecorationImage(
                                            image:
                                                NetworkImage(value.uploadedUrl),
                                          )
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(
                                              value.valueUri.contentAsBytes(),
                                            ),
                                          ),
                              ),
                              child: value.valueUri == null &&
                                      value.uploadedUrl == null
                                  ? Center(
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          readOnly == false
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.remove(id);
                                      print("onImageLoaded on remove");
                                      super.updateValueFromMultiplePicker(
                                        typeCode: typeCode,
                                        controller: _controller,
                                      );
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeRegular(
                                              FontAwesomeId.fa_times_circle),
                                          size: 20,
                                          color:
                                              controller.value.fileImage == null
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    );
                  },
                  onImageLoaded: (file) {
                    print("onImageLoaded fire");
                    super.updateValueFromMultiplePicker(
                      typeCode: typeCode,
                      controller: _controller,
                    );
                  },
                );
              },
              builder: (children) {
                return Container(
                  padding: EdgeInsets.only(right: 0, top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: model.isValidImagePicker == false
                            ? Colors.red
                            : Colors.transparent,
                        style: BorderStyle.solid,
                        width: 2),
                  ),
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 3.0,
                    children: children,
                    crossAxisAlignment: WrapCrossAlignment.end,
                  ),
                );
              },
              onTap: (_) {},
              onImageLoaded: (file) {
                print("onImageLoaded add file");
                super.updateValueFromMultiplePicker(
                  typeCode: typeCode,
                  controller: _controller,
                );
              },
              onImageDeleted: () {
                print("onImageLoaded delete file");
                super.updateValueFromMultiplePicker(
                  typeCode: typeCode,
                  controller: _controller,
                );
                return true;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget switchInput(AttendanceItemModel item, [bool readonly = false]) {
    switch (item.kindOfType) {
      case ItemType.number:
        return spinnerInput(
          label: item.typeName,
          typeCode: item.typeCode,
          readOnly: readonly,
        );
        break;
      case ItemType.boolean:
        return checkboxInput(
          label: item.typeName,
          typeCode: item.typeCode,
          readOnly: readonly,
        );
        break;
      case ItemType.textArea:
        return textareaInput(
          label: item.typeName,
          typeCode: item.typeCode,
          readOnly: readonly,
        );
        break;
      case ItemType.file:
        return filesInput(
          label: item.typeName,
          typeCode: item.typeCode,
          readOnly: readonly,
        );
        break;
      default:
        return Container();
    }
  }

  Widget confirmationCheck() {
    return Container(
      margin: EdgeInsets.only(left: 45, right: 45, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            child: Align(
              alignment: Alignment.topLeft,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: System.data.colorUtil.color009789,
                ),
                child: Consumer<ViewModel>(
                  builder: (c, d, h) {
                    return Checkbox(
                        value: model.isAccept,
                        onChanged: (val) {
                          model.isAccept = val;
                          model.commit();
                        },
                        checkColor: System.data.colorUtil.color009789,
                        activeColor: Colors.white);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 10, left: 5),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "${System.data.resource.iAmResponsibleForTheAccuracyOfTheAboveData}",
                    style: System.data.textStyleUtil.mainLabel(
                      fontSize: System.data.fontUtil.m,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget submitButton({String label}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 28, right: 27),
      height: confirmationCheck() != null ? 115 : 60,
      child: Column(
        children: [
          confirmationCheck() ?? SizedBox(),
          BottonComponent.roundedButton(
            onPressed: () {
              submit();
            },
            colorBackground: System.data.colorUtil.color009789,
            text: label ?? System.data.resource.send,
            textstyle: System.data.textStyleUtil.mainLabel(
                fontWeight: FontWeight.bold,
                fontSize: System.data.fontUtil.l,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
