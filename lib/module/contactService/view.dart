import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ChatModel.dart';
import 'presenter.dart';
import 'package:component_icons/font_awesome.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        appBar: appBar(),
        body: home(),
        bottomSheet: bottomNavigationBar());
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
        context: context,
        elevetion: 0,
        backgroundColor: System.data.colorUtil.primaryColor,
        titleColor: System.data.colorUtil.secondaryColor,
        title: System.data.resource.contactCenter,
        actionTextColor: System.data.colorUtil.secondaryColor,
        backButtonColor: System.data.colorUtil.secondaryColor,
        actionText: System.data.resource.back);
  }

  Widget bottomNavigationBar() {
    return Container(
        color: System.data.colorUtil.secondaryColor,
        margin: EdgeInsets.only(top: 0, bottom: 0),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => addIcons(),
              icon: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                child: Icon(
                  iconAddFile,
                  color: System.data.colorUtil.primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: InputComponent.inputTextWithCorner(
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
                    controller: inputMessage,
                    corner: 24,
                    backgroundColor: System.data.colorUtil.greyColor,
                    borderInputGray: System.data.colorUtil.secondaryColor,
                    onSubmited: (a) => addChat()),
              ),
            ),
            IconButton(
              onPressed: () => addChat(),
              icon: Icon(
                FontAwesomeLight(FontAwesomeId.fa_chevron_right),
                color: System.data.colorUtil.primaryColor,
              ),
            ),
          ],
        ));
  }

  Widget home() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            "assets/bgContactCenter.svg",
            color: System.data.colorUtil.borderInputColor,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 50),
            child: ListView.builder(
              controller: scrollController,
              itemCount: message.length,
              itemBuilder: (BuildContext context, i) {
                return chatData(chat: message[i], i: i);
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment(-0.9, 0.77),
          child: AnimatedContainer(
            child: Container(
              height: 160,
              width: 200,
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              decoration: BoxDecoration(
                  color: System.data.colorUtil.secondaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    onTap: () => sendFiles(camera: false),
                    leading: Icon(FontAwesomeLight(FontAwesomeId.fa_paperclip)),
                    title: Text(
                      "${System.data.resource.sendFile}",
                      style: System.data.textStyleUtil.linkLabel(
                          color: System.data.colorUtil.darkTextColor, fontSize: System.data.fontUtil.l),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    onTap: () => transcripts(),
                    leading: Icon(FontAwesomeLight(FontAwesomeId.fa_file_alt)),
                    title: Text(
                      "${System.data.resource.transcript}",
                      style: System.data.textStyleUtil.linkLabel(
                          color: System.data.colorUtil.darkTextColor, fontSize: System.data.fontUtil.l),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    onTap: () => ratings(),
                    leading: Icon(FontAwesomeLight(FontAwesomeId.fa_star)),
                    title: Text(
                      "${System.data.resource.rating}",
                      style: System.data.textStyleUtil.linkLabel(
                          color: System.data.colorUtil.darkTextColor, fontSize: System.data.fontUtil.l),
                    ),
                  ),
                ],
              ),
            ),
            duration: Duration(milliseconds: 500),
            alignment: alignmentAddIcon,
          ),
        )
      ],
    );
  }

  Widget chatData({ChatModel chat, int i}) {
    try {
      image = Uri.parse(chat.value).data;
    } catch (e) {
      image = null;
    }
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 14),
      child: Row(
        children: <Widget>[
          chat.sender
              ? CircleAvatar(
                  backgroundColor: System.data.colorUtil.secondaryColor,
                  child: SvgPicture.asset(
                    "assets/iconUserContactService.svg",
                    fit: BoxFit.fill,
                    width: 24,
                    height: 24,
                  ),
                )
              : Container(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(
                right: chat.sender ? 40 : 0,
                left: chat.sender ? 0 : 60,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ],
                color: chat.sender
                    ? System.data.colorUtil.greenColorBackGround
                    : System.data.colorUtil.secondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: chat.images
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(
                            image.contentAsBytes(),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      "${chat.value}",
                      textAlign: chat.sender ? TextAlign.start : TextAlign.end,
                      style: System.data.textStyleUtil.linkLabel(
                          color: chat.sender
                              ? System.data.colorUtil.secondaryColor
                              : System.data.colorUtil.darkTextColor),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
