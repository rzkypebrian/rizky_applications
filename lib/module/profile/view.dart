import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar(),
            body: SingleChildScrollView(
              child: body(
                profileIteem: profileItems(),
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: circularProgressIndicatorDecoration(),
          )
        ],
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      padding: EdgeInsets.only(bottom: 80),
      controller: loadingController,
    );
  }

  Widget bottomNavigationBar() {
    return null;
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.profile,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      rightWidget: widget.onChangeProfile != null
          // ignore: deprecated_member_use
          ? FlatButton(
              child: Text(
                "${System.data.resource.changeProfile}",
                style: System.data.textStyleUtil.mainTitle(
                  fontSize: System.data.fontUtil.m,
                ),
              ),
              onPressed: () {
                changeProfile();
              },
            )
          : Container(
              height: 0,
              width: 0,
            ),
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.scaffoldBackgroundColor,
    );
  }

  Widget body({List<Widget> profileIteem}) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Column(
        children: <Widget>[
          imageProfileContainer(),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 5),
            child: Text("${profileModel.name}",
                style: System.data.textStyleUtil.linkLabel(
                  fontWeight: FontWeight.bold,
                  fontSize: System.data.fontUtil.l,
                )),
          ),
          SizedBox(
            height: 50,
          ),
          Column(children: profileIteem)
        ],
      ),
    );
  }

  Widget imageProfileContainer() {
    return Container(
      child: Stack(
        children: <Widget>[
          imageProfile(),
          Container(
            margin: EdgeInsets.only(
              top: 30,
            ),
            height: 100,
            width: 100,
            color: Colors.white.withOpacity(0.01),
          )
        ],
      ),
    );
  }

  Widget imageProfile({
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    double width,
    double height,
    bool readOnly,
  }) {
    return Container(
      padding: padding ??
          EdgeInsets.only(
            top: 30,
          ),
      child: ImagePickerComponent(
        containerHeight: height ?? 100,
        containerWidth: width ?? 100,
        controller: imagePickerController,
        readOnly: readOnly,
        minimumMemoryRequirement: 0,
        container: (child, value) {
          return Container(
            height: height ?? 100,
            width: width ?? 100,
            margin: margin,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: value.valueUri != null
                      ? MemoryImage(value.valueUri.contentAsBytes())
                      : !profileModel.urlImmage.isNullOrEmpty()
                          ? NetworkImage(profileModel.urlImmage)
                          : AssetImage("assets/default_avatar.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(
                  color: System.data.colorUtil.borderInputColor,
                  style: BorderStyle.solid,
                  width: 5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ]),
          );
        },
      ),
    );
  }

  Widget profileItem(String label, String value) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "$label",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "$value",
                    style: System.data.textStyleUtil.mainLabel(),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 20,
          color: Colors.black,
        ),
      ],
    );
  }

  List<Widget> profileItems() {
    return <Widget>[
      profileItem(System.data.resource.name, profileModel.name),
      profileItem(System.data.resource.email, profileModel.email),
      profileItem(System.data.resource.phone, profileModel.phone),
      profileItem(System.data.resource.address, profileModel.address),
    ];
  }
}
