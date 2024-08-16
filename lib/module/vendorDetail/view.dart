import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: bottonNavigationBar(),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        child: ListView(
          children: listItem(),
        ),
      ),
    );
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
        context: context,
        actionText: "",
        title: "${System.data.resource.vendorDetail}",
        backButtonColor: System.data.colorUtil.lightTextColor,
        titleStyle: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.lightTextColor,
          fontSize: System.data.fontUtil.xl,
        ),
        backgroundColor: System.data.colorUtil.primaryColor);
  }

  List<Widget> listItem() {
    return [
      item(
        label: System.data.resource.vendorName,
        value: widget.vendorModel.name,
      ),
      item(
        label: System.data.resource.address,
        value: widget.vendorModel.address,
      ),
      item(
        label: System.data.resource.phoneNumber,
        value: widget.vendorModel.phoneNumber,
      ),
      item(
        label: System.data.resource.email,
        value: widget.vendorModel.email,
      ),
      item(
        label: System.data.resource.officeHour,
        value: widget.vendorModel.workerDay,
      ),
      item(
        label: "",
        value: widget.vendorModel.workerTime,
      ),
    ];
  }

  Widget item({
    String label,
    String value,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label ?? "Label",
              style: System.data.textStyleUtil.mainLabel(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: System.data.textStyleUtil.mainLabel(),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottonNavigationBar() {
    return Container(
      height: widget.listAction.length * 50.0,
      child: Column(
        children: List.generate(
          widget.listAction.length,
          (index) {
            switch (widget.listAction[index]) {
              case ActionButton.Edit:
                return buttonEdit();
                break;
              case ActionButton.Delete:
                return buttonDelete();
                break;
              case ActionButton.Confirm:
                return buttonConfirm();
                break;
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget buttonDelete() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      height: 45,
      child: BottonComponent.roundedButton(
        onPressed: () {
          widget.onTapDelete();
        },
        colorBackground: System.data.colorUtil.primaryColor,
        text: System.data.resource.remove,
        textstyle: System.data.textStyleUtil.mainLabel(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  Widget buttonEdit() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      height: 45,
      child: BottonComponent.roundedButton(
        onPressed: () {
          widget.onTapEdit();
        },
        colorBackground: System.data.colorUtil.primaryColor,
        text: System.data.resource.edit,
        textstyle: System.data.textStyleUtil.mainLabel(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  Widget buttonConfirm() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      height: 45,
      child: BottonComponent.roundedButton(
        onPressed: () {
          widget.onTapConfirm();
        },
        colorBackground: System.data.colorUtil.primaryColor,
        text: System.data.resource.confirmation,
        textstyle: System.data.textStyleUtil.mainLabel(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }
}
