import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TextStyleUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class DetailInpunBill extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ViewModel>(builder: (ctx, vm, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.greyColor,
            appBar: appBar(),
            body: body(vm),
          );
        }));
  }

  PreferredSizeWidget appBar({ViewModel vm}) {
    return BottonComponent.customAppBar1(
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      context: context,
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.bill,
      titleStyle: System.data.textStyleUtil.mainTitle(),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          resultInput(vm),
        ],
      ),
    );
  }

  Widget saveButton() {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, bottom: 34),
      child: BottonComponent.roundedButton(
        onPressed: saveData,
        colorBackground: System.data.colorUtil.primaryColor,
        radius: 5,
        text: "${System.data.resource.send}",
        textColor: Colors.red,
        textstyle: System.data.textStyleUtil
            .mainTitle(color: System.data.colorUtil.lightTextColor),
      ),
    );
  }

  Widget resultInput(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(top: 18, bottom: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: System.data.colorUtil.greyColor,
          ),
          color: System.data.colorUtil.lightTextColor),
      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 7, top: 7),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "No Tagihan",
                      style: TextStyleUtil().mainLabel(
                          color: System.data.colorUtil.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: System.data.colorUtil.greyColor,
            thickness: 2,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7, top: 7),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${System.data.resource.bankName}",
                      style: TextStyleUtil().mainLabel(
                          color: System.data.colorUtil.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(child: Container(child: Text('${vm.bank}'))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7, top: 7),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${System.data.resource.accountNumber}",
                      style: TextStyleUtil().mainLabel(
                          color: System.data.colorUtil.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Text('${vm.angkutBill.accountNumber}'))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7, top: 7),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${System.data.resource.accountHolderName}",
                      style: TextStyleUtil().mainLabel(
                          color: System.data.colorUtil.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Text('${vm.angkutBill.accounHolderName}'))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7, top: 7),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${System.data.resource.datePay}",
                      style: TextStyleUtil().mainLabel(
                          color: System.data.colorUtil.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(child: Text('${vm.angkutBill.datePay}'))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 7, top: 7),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${System.data.resource.totalPay}",
                      style: TextStyleUtil().mainLabel(
                          color: System.data.colorUtil.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child:
                        Container(child: Text('${vm.angkutBill.debtTotal}'))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputImage() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Text(
            System.data.resource.uploadStruck,
            textAlign: TextAlign.left,
            style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        MultipleImagePickerComponent(
          galery: false,
          controller: imagePickerControllers,
          imagePickerBuilder: (id, controller) {
            return ImagePickerComponent(
              containerHeight: 100,
              containerWidth: 100,
              controller: controller,
              container: (context, value) {
                return Container(
                  width: 100,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(bottom: 10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: System.data.colorUtil.primaryColor,
                            ),
                            image: controller.value.fileImage == null
                                ? null
                                : DecorationImage(
                                    image:
                                        FileImage(controller.value.fileImage),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          child: controller.value.fileImage == null
                              ? Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            imagePickerControllers.remove(id);
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: Icon(
                                FontAwesomeRegular(
                                    FontAwesomeId.fa_times_circle),
                                size: 20,
                                color: controller.value.fileImage == null
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          builder: (children) {
            return Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              padding: EdgeInsets.only(left: 5, right: 0, top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isValidImagePicker == false
                          ? Colors.red
                          : Colors.transparent,
                      style: BorderStyle.solid,
                      width: 2)),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: children,
                crossAxisAlignment: WrapCrossAlignment.end,
              ),
            );
          },
          onTap: (_) {},
        ),
      ],
    );
  }
}
