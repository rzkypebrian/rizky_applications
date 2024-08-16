import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/model/AttendanceItemModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'confirmAttendacePresenter.dart';

class ConfirmAttendaceView extends View with ConfirmAttendacePresenter {
  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.color009789,
      title: System.data.resource.detailAttendance,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.lPlus,
      ),
    );
  }

  @override
  Widget intructionLabel() {
    return SizedBox();
  }

  @override
  Widget switchInput(AttendanceItemModel item, [bool readonly = false]) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      padding: EdgeInsets.only(bottom: 5, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          offset: Offset(0, 3),
          blurRadius: 3,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: super.switchInput(
                      item,
                      true,
                    ),
                  ),
                ),
                switchConfirm(item),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 35, right: 70),
            width: double.infinity,
            child: item.checkerReason != null
                ? Text(
                    "${item.checkerReason}",
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }

  Widget checkConfirmInput({String typeCode}) {
    return Container(
      width: 100,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 30,
            child: GestureDetector(
              onTap: () {
                onpenModalReason(
                    reasonValue: super
                        .model
                        .attendanceModel
                        .listItemAttendance
                        .where((e) => e.typeCode == typeCode)
                        .first
                        .checkerReason,
                    onChangeReason: (val) {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .checkerReason = val;
                    },
                    onBack: () {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .checkerReason = "";
                      Navigator.of(context).pop();
                    },
                    onOk: () {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .checkerValue = "true";
                      Navigator.of(context).pop();
                      super.model.commit();
                    });
              },
              child: Icon(
                FontAwesomeSolid(FontAwesomeId.fa_check_circle),
                color: super
                            .model
                            .attendanceModel
                            .listItemAttendance
                            .where((e) => e.typeCode == typeCode)
                            .first
                            .checkerValue ==
                        "true"
                    ? System.data.colorUtil.primaryColor
                    : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 30,
            child: GestureDetector(
              onTap: () {
                onpenModalReason(
                    reasonValue: super
                        .model
                        .attendanceModel
                        .listItemAttendance
                        .where((e) => e.typeCode == typeCode)
                        .first
                        .checkerReason,
                    onChangeReason: (val) {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .checkerReason = val;
                    },
                    onBack: () {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .checkerReason = "";
                      Navigator.of(context).pop();
                    },
                    onOk: () {
                      super
                          .model
                          .attendanceModel
                          .listItemAttendance
                          .where((e) => e.typeCode == typeCode)
                          .first
                          .checkerValue = "false";
                      Navigator.of(context).pop();
                      super.model.commit();
                    });
              },
              child: Icon(
                FontAwesomeSolid(FontAwesomeId.fa_times_circle),
                color: super
                            .model
                            .attendanceModel
                            .listItemAttendance
                            .where((e) => e.typeCode == typeCode)
                            .first
                            .checkerValue ==
                        "false"
                    ? System.data.colorUtil.redColor
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget switchConfirm(AttendanceItemModel item) {
    return checkConfirmInput(
      typeCode: item.typeCode,
    );
  }

  @override
  Widget confirmationCheck() {
    return SizedBox();
  }

  void onpenModalReason({
    String reasonValue,
    ValueChanged<String> onChangeReason,
    VoidCallback onOk,
    VoidCallback onBack,
  }) {
    InputComponentTextEditingController _controller =
        new InputComponentTextEditingController();
    _controller.text = reasonValue ?? "";
    ModalComponent.bottomModalWithCorner(context,
        height: 200,
        child: Container(
          height: 200 - 16.0,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Text(
                  System.data.resource.reason,
                  style: System.data.textStyleUtil.mainLabel(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: InputComponent.inputTextWithCorner(
                    controller: _controller,
                    textAlignVertical: TextAlignVertical.top,
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    maxLines: 5,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    corner: 5,
                    onChanged: onChangeReason,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
                width: double.infinity,
                color: Colors.yellow,
                child: Row(
                  children: [
                    Expanded(
                      child: BottonComponent.roundedButton(
                        radius: 0,
                        onPressed: onOk,
                        colorBackground: System.data.colorUtil.primaryColor,
                        text: System.data.resource.ok,
                        textstyle: System.data.textStyleUtil.mainLabel(
                            fontWeight: FontWeight.bold,
                            fontSize: System.data.fontUtil.l,
                            color: System.data.colorUtil.lightTextColor),
                      ),
                    ),
                    Expanded(
                      child: BottonComponent.roundedButton(
                        radius: 0,
                        onPressed: onBack,
                        colorBackground: System.data.colorUtil.greyColor,
                        text: System.data.resource.back,
                        textstyle: System.data.textStyleUtil.mainLabel(
                            fontWeight: FontWeight.bold,
                            fontSize: System.data.fontUtil.l,
                            color: System.data.colorUtil.darkTextColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget submitButton({String label}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 28, right: 27),
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: BottonComponent.roundedButton(
              onPressed: () {
                super.model.attendanceModel.isPassed = true;
                super.submit();
              },
              colorBackground: System.data.colorUtil.primaryColor,
              text: System.data.resource.feasible,
              border: Border.all(
                color: Colors.grey,
              ),
              textstyle: System.data.textStyleUtil.mainLabel(
                fontWeight: FontWeight.bold,
                fontSize: System.data.fontUtil.l,
                color: System.data.colorUtil.lightTextColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: BottonComponent.roundedButton(
              onPressed: () {
                onpenModalReason(onBack: () {
                  Navigator.of(context).pop();
                }, onOk: () {
                  Navigator.of(context).pop();
                  super.model.attendanceModel.isPassed = false;
                  super.submit();
                }, onChangeReason: (value) {
                  super.model.attendanceModel.reason = value;
                });
              },
              colorBackground: System.data.colorUtil.greyColor,
              text: System.data.resource.unfeasible,
              border: Border.all(
                color: Colors.grey,
              ),
              textstyle: System.data.textStyleUtil.mainLabel(
                fontWeight: FontWeight.bold,
                fontSize: System.data.fontUtil.l,
                color: System.data.colorUtil.darkTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
