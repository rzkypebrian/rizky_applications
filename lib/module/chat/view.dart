import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/custom/circle_avatar_custom.dart';
import 'package:enerren/model/ItemContextModel.dart';
import 'package:enerren/model/chatModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'viewModel.dart';
import 'package:enerren/util/StringExtention.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: System.data.global.chatsViewModel[widget.tmsShipmentId],
      child: scafold(),
    );
  }

  Widget scafold() {
    return Scaffold(
      backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar(),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Consumer<ViewModel>(
                  builder: (ctx, data, child) {
                    return Expanded(
                      child: Stack(
                        children: [
                          listChat(data),
                          data.autoScrollToButton
                              ? SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            // ignore: deprecated_member_use
                                            child: RaisedButton(
                                              onPressed: () {
                                                data.scrollToDown(
                                                  force: true,
                                                );
                                              },
                                              shape: CircleBorder(),
                                              color: Colors.white,
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeRegular(FontAwesomeId
                                                      .fa_chevron_double_down),
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          data.unread == 0
                                              ? SizedBox()
                                              : Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 2,
                                                        bottom: 2,
                                                        left: 5,
                                                        right: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50))),
                                                    child: Text(
                                                      "${data.unread}",
                                                      style: System
                                                          .data.textStyleUtil
                                                          .mainLabel(
                                                        color: System
                                                            .data
                                                            .colorUtil
                                                            .lightTextColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: InputComponent.inputTextWithCorner(
                              controller: super.chatContentController,
                              maxLines: 1,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              corner: 50,
                              fontSize: System.data.fontUtil.l,
                              textAlign: TextAlign.left,
                              contentPadding: EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                            ),
                          ),
                        ),
                        Consumer<ViewModel>(
                          builder: (c, d, h) {
                            return Container(
                              width: 70,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  onPressed: super.sendTextMessage,
                                  shape: CircleBorder(),
                                  color: System.data.colorUtil.primaryColor,
                                  child: senderLoadingController.onLoading
                                      ? CircularProgressIndicatorComponent(
                                          controller: senderLoadingController,
                                          coverScreen: false,
                                          flareAnimation:
                                              widget.senderFlareAnimationName,
                                          flareAssets:
                                              widget.senderFlareAnimationAsset,
                                        )
                                      : Center(
                                          child: Icon(
                                            (Icons.send),
                                            size: 30,
                                            color: System
                                                .data.colorUtil.lightTextColor,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Consumer<ViewModel>(
              builder: (c, d, h) {
                if (d.dates.isNotEmpty) {
                  return dateDecoration(d.dates.last);
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
          circularProgressIndicatorDecoration()
        ],
      ),
    );
  }

  Widget circularProgressIndicatorDecoration(
      {CircularProgressIndicatorController controller}) {
    return CircularProgressIndicatorComponent(
      aligment: Alignment.center,
      controller: loadingController,
      flareAssets: widget.getListFlareAnimationAsset,
      flareAnimation: widget.getListFlareAnimationName,
      width: 50,
      height: 50,
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: System.data.colorUtil.primaryColor,
      leading: SizedBox(),
      flexibleSpace: SafeArea(
          child: Container(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Navigator.of(context).canPop()
                ? Container(
                    padding: EdgeInsets.only(left: 8, right: 0),
                    child: GestureDetector(
                      onTap: () {
                        System.data.routes.pop(context);
                      },
                      child: Icon(
                        FontAwesomeRegular(
                          FontAwesomeId.fa_arrow_left,
                        ),
                        size: 20,
                        color: System.data.colorUtil.lightTextColor,
                      ),
                    ),
                  )
                : SizedBox(),
            Container(
              margin:
                  EdgeInsets.only(left: Navigator.of(context).canPop() ? 0 : 0),
              width: 50,
              child: CircleAvatarCustom(
                backgroundImage: !widget.avatarUrl.isNullOrEmpty()
                    ? NetworkImage(widget.avatarUrl)
                    : !widget.avatarAssets.isNullOrEmpty()
                        ? AssetImage(widget.avatarAssets)
                        : AssetImage("assets/default_avatar.png"),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "${widget.title ?? System.data.resource.title}",
                        style:
                            System.data.textStyleUtil.mainTitle(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.topLeft,
                      child: Consumer<ViewModel>(
                        builder: (ctx, data, child) {
                          return Text(
                            "${!System.data.global.chatsViewModel[widget.tmsShipmentId].statusChat.isNullOrEmpty() ? System.data.global.chatsViewModel[widget.tmsShipmentId].statusChat : !widget.subTitle.isNullOrEmpty() ? widget.subTitle : "-"}",
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.lightTextColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget listChat(ViewModel vm) {
    return Container(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          // Make sure the page is not in an unstable state
          streamController.add(scroll);
          return true;
        },
        child: ListView(
          controller: vm.listChatsScrollController,
          children: listCbatItem(vm.chats),
        ),
      ),
    );
  }

  List<Widget> listCbatItem(List<ChatModel> m) {
    DateTime _currentDate;
    itemsDateSeparatorContext.clear();
    List<Widget> items = [];
    for (var i = 0; i < m.length; i++) {
      DateTime _newDate = DateTime(m[i].insertedDate.year,
          m[i].insertedDate.month, m[i].insertedDate.day);
      if (_currentDate == null || _currentDate != _newDate) {
        _currentDate = _newDate;
        items.add(dateSeparator(_newDate, itemsDateSeparatorContext.length));
      }
      items.add(
        content(m[i], itemsDateSeparatorContext.length),
      );
    }
    return items;
  }

  Widget content(ChatModel m, int index) {
    return LayoutBuilder(
      builder: (ctx, box) {
        return contentText(
          content: m.messageContent,
          senderId: m.userId,
          senderTypeId: m.userTypeId,
          senderName: m.userName,
          receivedDate: m.insertedDate,
        );
      },
    );
  }

  Widget dateSeparator(DateTime date, int index) {
    return LayoutBuilder(
      builder: (ctx, box) {
        itemsDateSeparatorContext.add(ItemContextModel(
          id: index,
          context: ctx,
          name: DateFormat(System.data.resource.dateFormat).format(date),
          data: date,
        ));
        return dateDecoration(date);
      },
    );
  }

  Widget dateDecoration(DateTime date) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              color: System.data.colorUtil.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              DateFormat(System.data.resource.dateFormat).format(date),
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.lightTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget contentText({
    int senderId,
    int senderTypeId,
    String senderName,
    String content,
    DateTime receivedDate,
  }) {
    bool isSender =
        senderId == widget.senderId && senderTypeId == widget.senderTypeId
            ? true
            : false;
    senderName =
        isSender ? widget.senderName : senderName ?? "Undefined Sender Name";
    double width = senderName.width > content.width
        ? senderName.width.toDouble()
        : content.width.toDouble();
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      child: Row(
        children: [
          !isSender ? SizedBox() : Expanded(child: Container()),
          Container(
            width: width > 100
                ? MediaQuery.of(context).size.width - 80
                : ((width + 28) * 4) > (MediaQuery.of(context).size.width - 80)
                    ? (MediaQuery.of(context).size.width - 80)
                    : ((width + 28) * 4),
            margin: isSender
                ? EdgeInsets.only(left: 70)
                : EdgeInsets.only(right: 70),
            decoration: BoxDecoration(
                color: isSender
                    ? System.data.colorUtil.primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    blurRadius: 2,
                  )
                ]),
            child: Column(
              mainAxisAlignment:
                  isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: senderId == widget.senderId &&
                      senderTypeId == widget.senderTypeId
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$senderName",
                        textAlign: TextAlign.left,
                        style: System.data.textStyleUtil.mainLabel(
                          fontSize: System.data.fontUtil.s,
                          color: senderId == widget.senderId &&
                                  senderTypeId == widget.senderTypeId
                              ? System.data.colorUtil.lightTextColor
                              : System.data.colorUtil.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${DateFormat("HH:mm").format(receivedDate)}",
                        style: System.data.textStyleUtil.mainLabel(
                          fontSize: System.data.fontUtil.s,
                          color: senderId == widget.senderId &&
                                  senderTypeId == widget.senderTypeId
                              ? System.data.colorUtil.lightTextColor
                              : System.data.colorUtil.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 5),
                  child: Text(
                    "${content ?? ""}",
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
          isSender ? SizedBox() : Expanded(child: Container()),
        ],
      ),
    );
  }
}
