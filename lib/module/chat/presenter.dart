import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/ItemContextModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';
import 'view.dart';
import 'viewModel.dart';
import 'package:enerren/model/chatModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int senderId;
  final int senderTypeId;
  final String senderName;
  final int tmsShipmentId;
  final String title;
  final String subTitle;
  final String avatarUrl;
  final String avatarAssets;
  final String getListFlareAnimationAsset;
  final String getListFlareAnimationName;
  final String senderFlareAnimationAsset;
  final String senderFlareAnimationName;

  const Presenter({
    Key key,
    this.view,
    this.senderId,
    this.senderTypeId,
    this.tmsShipmentId,
    this.title,
    this.subTitle,
    this.avatarUrl,
    this.avatarAssets,
    this.senderName,
    this.getListFlareAnimationAsset,
    this.getListFlareAnimationName,
    this.senderFlareAnimationAsset,
    this.senderFlareAnimationName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  InputComponentTextEditingController chatContentController =
      new InputComponentTextEditingController();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  BehaviorSubject<ScrollNotification> streamController;
  Set<ItemContextModel> itemsChatsContext;
  Set<ItemContextModel> itemsDateSeparatorContext;
  CircularProgressIndicatorController senderLoadingController =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    System.data.global.chatsViewModel[widget.tmsShipmentId] =
        System.data.global.chatsViewModel[widget.tmsShipmentId] ??
            new ViewModel();
    itemsChatsContext = Set<ItemContextModel>();
    itemsDateSeparatorContext = Set<ItemContextModel>();
    // Initialize a stream controller
    streamController = BehaviorSubject<ScrollNotification>();
    //
    // When a scroll notification is emitted, simply bufferize a bit
    // so that we do not compute too much
    //
    streamController.listen((event) {
      onScroll(event);
    });
    senderLoadingController.stopLoading();
    super.initState();
    getChatList();
  }

  void onScroll(ScrollNotification notifications) {
    // Iterate through each item to check
    // whether it is in the viewport

    itemsDateSeparatorContext.forEach((ItemContextModel item) {
      // Retrieve the RenderObject, linked to a specific item
      final RenderObject object = item.context.findRenderObject();

      // If none was to be found, or if not attached, leave by now
      // As we are dealing with Slivers, items no longer part of the
      // viewport will be detached
      if (object == null || !object.attached) {
        return;
      }

      // Retrieve the viewport related to the scroll area
      final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);
      final double vpHeight = viewport.paintBounds.height;
      final ScrollableState scrollableState = Scrollable.of(item.context);
      final ScrollPosition scrollPosition = scrollableState.position;
      final RevealedOffset vpOffset = viewport.getOffsetToReveal(object, 0.0);

      // Retrieve the dimensions of the item
      final Size size = object?.semanticBounds?.size;

      // Check if the item is in the viewport
      final double deltaTop = vpOffset.offset - scrollPosition.pixels;
      final double deltaBottom = deltaTop + size.height;

      bool hideOnTopViewPort = !(deltaTop >= 0.0 && deltaTop < vpHeight);
      bool hideOnBottomViewPort =
          !(deltaBottom > 0.0 && deltaBottom < vpHeight);
      bool isInViewport = false;

      isInViewport = (!hideOnTopViewPort && !hideOnBottomViewPort);

      if (isInViewport) {
        if (System.data.global.chatsViewModel[widget.tmsShipmentId].dates
            .isNotEmpty) {
          if (System.data.global.chatsViewModel[widget.tmsShipmentId].dates
                  .last ==
              ((item.data) as DateTime)) {
            System.data.global.chatsViewModel[widget.tmsShipmentId].dates
                .removeLast();
            System.data.global.chatsViewModel[widget.tmsShipmentId].commit();
          }
        }
      }

      if (hideOnTopViewPort && !hideOnBottomViewPort) {
        if (System.data.global.chatsViewModel[widget.tmsShipmentId].dates
            .isNotEmpty) {
          if (System.data.global.chatsViewModel[widget.tmsShipmentId].dates
                  .last !=
              ((item.data) as DateTime)) {
            System.data.global.chatsViewModel[widget.tmsShipmentId].dates
                .add(((item.data) as DateTime));
          }
        } else {
          System.data.global.chatsViewModel[widget.tmsShipmentId].dates
              .add(((item.data) as DateTime));
        }
        System.data.global.chatsViewModel[widget.tmsShipmentId].commit();
      }
      // print(
      //     '${item.id} --> name : ${item.name} --> HOT : $hideOnTopViewPort --> HOB : $hideOnBottomViewPort -->   VP?: $isInViewport dates : ${System.data.global.chatsViewModel[widget.tmsShipmentId].dates.length}');
    });
  }

  bool validateChatTextContent() {
    if (chatContentController.text.isEmpty) {
      chatContentController.setStateInput = StateInput.Error;
      return false;
    } else {
      chatContentController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  void sendTextMessage() {
    if (senderLoadingController.onLoading) return;
    senderLoadingController.startLoading();
    System.data.global.chatsViewModel[widget.tmsShipmentId].commit();
    ChatModel chat = new ChatModel();
    if (validateChatTextContent() == null) {
      chat.messageContent = chatContentController.text;
      chat.tmsShipmentId = widget.tmsShipmentId;
      chat.insertedDate = DateTime.now();
      chat.modifiedDate = DateTime.now();
      ChatModel.send(
        token: System.data.global.token,
        chatModel: chat,
      ).then((value) {
        senderLoadingController.stopLoading();
        print("result : ${value.toJson()}");
        chatContentController.text = "";
        System.data.global.chatsViewModel[widget.tmsShipmentId].chats
            .add(value);
        System.data.global.chatsViewModel[widget.tmsShipmentId].commit();
        System.data.global.chatsViewModel[widget.tmsShipmentId].scrollToDown(
          force: true,
        );
      }).catchError((onError) {
        senderLoadingController.stopLoading();
        errorHandling(onError);
      });
    }
  }

  void getChatList() {
    loadingController.startLoading();
    ChatModel.get(
      token: System.data.global.token,
      tmsShipmentId: widget.tmsShipmentId,
    ).then((value) {
      loadingController.stopLoading();
      System.data.global.chatsViewModel[widget.tmsShipmentId].chats = value;
      System.data.global.chatsViewModel[widget.tmsShipmentId].commit();
      System.data.global.chatsViewModel[widget.tmsShipmentId].scrollToDown();
    }).catchError(
      (onError) {
        errorHandling(onError);
      },
    );
  }

  void errorHandling(dynamic onError) {
    loadingController.stopLoading(
      messageAlign: Alignment.topCenter,
      isError: true,
      message: ErrorHandlingUtil.handleApiError(onError),
      messageWidget: DecorationComponent.topMessageDecoration(
        message: ErrorHandlingUtil.handleApiError(onError),
      ),
    );
  }
}
