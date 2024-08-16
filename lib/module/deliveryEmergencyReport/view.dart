import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../component/InputComponent.dart';
import '../../component/BottonComponent.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';
import '../../util/SystemUtil.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(),
        body: GestureDetector(
            onTap: () {
              closeKeyboard(context);
            },
            child: Stack(
              children: <Widget>[
                home(),
                circularProgressIndicatorDecoration(
                  controller: loadingController,
                )
              ],
            )),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration(
      {CircularProgressIndicatorController controller}) {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: BottonComponent.roundedButton(
              colorBackground: System.data.colorUtil.primaryColor,
              text: "${System.data.resource.emergency}",
              textstyle: System.data.textStyleUtil.mainTitle(),
              onPressed: () {
                submitEmergency();
              }),
        ),
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: Colors.white,
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
        context: context,
        title: toBeginningOfSentenceCase(
            widget.titleLabel ?? System.data.resource.emergency),
        backgroundColor: System.data.colorUtil.primaryColor,
        titleColor: System.data.colorUtil.secondaryColor,
        backButtonColor: System.data.colorUtil.lightTextColor,
        actionText: toBeginningOfSentenceCase(System.data.resource.back));
  }

  Widget inputPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.fotoLabel ?? System.data.resource.photo,
          style: System.data.textStyleUtil.mainLabel(),
        ),
        ImagePickerComponent(
          containerHeight: 60,
          containerWidth: 60,
          controller: super.photoController,
          galery: false,
          container: ((child, value) {
            return Container(
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              margin: EdgeInsets.only(top: 10, bottom: 20),
              height: 60,
              decoration: BoxDecoration(
                  color: System.data.colorUtil.inputTextBackground,
                  border: Border.all(
                    color: value.state == ImagePickerComponentState.Disable
                        ? System.data.colorUtil.disableColor
                        : value.state == ImagePickerComponentState.Enable
                            ? System.data.colorUtil.borderInputColor
                            : System.data.colorUtil.errorColor,
                    style: BorderStyle.solid,
                    width: 2,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Text("${photoController.getFileName()}"),
                  ),
                  Center(
                    child: Icon(FontAwesomeLight(FontAwesomeId.fa_camera_alt)),
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  Widget inputNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          System.data.resource.note,
          style: System.data.textStyleUtil.mainLabel(),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: InputComponent.inputTextWithCorner(
              backgroundColor: System.data.colorUtil.inputTextBackground,
              autoFocus: true,
              keyboardType: TextInputType.text,
              focusnode: noteFocus,
              stateInput: noteState,
              borderInputGray: System.data.colorUtil.borderInputColor,
              controller: notedController,
              textInputAction: TextInputAction.done,
              corner: 5,
              maxLines: 5),
        ),
      ],
    );
  }

  Widget confirmationCannotContinue() {
    return Row(
      children: <Widget>[
        Checkbox(
            checkColor: System.data.colorUtil.primaryColor,
            activeColor: System.data.colorUtil.primaryColor,
            focusColor: System.data.colorUtil.primaryColor,
            onChanged: (bool val) {
              setState(() {
                isCannotContinue = val;
              });
            },
            value: isCannotContinue),
        Expanded(
          child: Text(
            System.data.resource.youCanotContinueTheJourney,
            style: System.data.textStyleUtil.mainLabel(),
          ),
        )
      ],
    );
  }

  Widget info() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${System.data.resource.customerName}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${widget.customerName ?? "-"}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget shipmentInfo() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${System.data.resource.shipmentNumber}",
              style: System.data.textStyleUtil.linkLabel(),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "${widget.shipmentNumber ?? "-"}",
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
        ],
      ),
    );
  }

  Widget home() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listComponent(),
        ),
      ),
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      shipmentInfo(),
      info(),
      inputPhotos(),
      inputNote(),
      confirmationCannotContinue(),
    ];
  }
}
