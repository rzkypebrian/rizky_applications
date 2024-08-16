import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../../util/SystemUtil.dart';
import 'view.dart';

mixin InputProfile on View {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar(),
            body: GestureDetector(
              onTap: () {
                closeKeyboard(context);
              },
              child: SingleChildScrollView(
                child: home(),
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(),
          ),
          circularProgressIndicatorDecoration()
        ],
      ),
    );
  }

  @override
  Widget imageProfileContainer() {
    return imageProfile();
  }

  Widget home() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            inputName(),
            inputEmail(),
            inputAddress(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "${System.data.resource.back}",
      title: "${System.data.resource.profile}",
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.scaffoldBackgroundColor,
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: BottonComponent.roundedButton(
              text: "${System.data.resource.send}",
              colorBackground: System.data.colorUtil.primaryColor,
              textstyle: System.data.textStyleUtil.mainTitle(),
              onPressed: () {
                submit();
              }),
        ),
      ),
    );
  }

  Widget progressIndicatorContainer() {
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: progressIndicator(),
        ),
      ),
    );
  }

  Widget progressIndicator() {
    return Container(
      height: 100,
      child: FlareActor(
        "assets/flares/loading_beton.flr",
        animation: "loading2",
        callback: (snimate) {
          // loadData();
        },
      ),
    );
  }

  Widget inputPhone({
    bool readOnly = false,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              System.data.resource.phone,
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.primaryColor,
                fontSize: System.data.fontUtil.m,
              ),
            ),
          ),
          Container(
            child: InputComponent.inputTextWithCorner(
                backgroundColor: System.data.colorUtil.inputTextBackground,
                hintText: '',
                autoFocus: true,
                borderInputGray: System.data.colorUtil.borderInputColor,
                controller: phoneController,
                textInputAction: TextInputAction.done,
                focusnode: phoneFocus,
                onSubmited: (val) {
                  // FocusScope.of(context).requestFocus(dateFocus);
                },
                corner: 5,
                readOnly: readOnly,
                keyboardType: TextInputType.phone),
          ),
        ],
      ),
    );
  }

  Widget inputEmail({
    bool readOnly = false,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              System.data.resource.email,
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
          Container(
            child: InputComponent.inputTextWithCorner(
              backgroundColor: System.data.colorUtil.inputTextBackground,
              hintText: '',
              autoFocus: true,
              borderInputGray: System.data.colorUtil.borderInputColor,
              controller: emailController,
              textInputAction: TextInputAction.done,
              focusnode: emailFocus,
              corner: 5,
              readOnly: readOnly,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget inputName({
    bool readOnly = false,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              System.data.resource.name,
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
          Container(
            child: InputComponent.inputTextWithCorner(
                backgroundColor: System.data.colorUtil.inputTextBackground,
                hintText: '',
                autoFocus: true,
                readOnly: readOnly,
                borderInputGray: System.data.colorUtil.borderInputColor,
                controller: nameController,
                textInputAction: TextInputAction.done,
                focusnode: nameFocus,
                corner: 5,
                keyboardType: TextInputType.emailAddress),
          ),
        ],
      ),
    );
  }

  Widget inputAddress({
    bool readOnly,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              System.data.resource.address,
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
          Container(
            child: InputComponent.inputTextWithCorner(
              backgroundColor: System.data.colorUtil.inputTextBackground,
              hintText: '',
              autoFocus: true,
              borderInputGray: System.data.colorUtil.borderInputColor,
              controller: addressController,
              textInputAction: TextInputAction.done,
              focusnode: addressFocus,
              corner: 5,
              readOnly: readOnly,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
