import 'dart:async';
import 'dart:io';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/module/contactService/main.dart';
import 'package:enerren/util/ImageUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'ChatModel.dart';
import 'view.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:image_picker/image_picker.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapGotoHome;

  const Presenter({
    Key key,
    this.view,
    this.onTapGotoHome,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter>
    with TickerProviderStateMixin {
  ScrollController scrollController = new ScrollController();
  InputComponentTextEditingController inputMessage =
      InputComponentTextEditingController();
  bool addIcon = false;
  Alignment alignmentAddIcon = Alignment(-0.9, 2);
  AnimationController rotationController;
  IconData iconAddFile = FontAwesomeLight(FontAwesomeId.fa_plus);
  File imageSendFile;
  UriData image;

  List<ChatModel> message = [
    ChatModel(
      sender: false,
      value: "penerima",
      dateTime: DateTime.now(),
      receiverIcon: Icon(Icons.account_balance_wallet),
      senderIcon: Icon(Icons.account_box),
    ),
    // ChatModel(
    //   value: "pengirim",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   value: "pengirim",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   value: "pengirim",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   value: "pengirim",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   value: "pengirim",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   value: "pengirim",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   value: "pengirim",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    // ChatModel(
    //   sender: false,
    //   value: "penerima",
    //   dateTime: DateTime.now(),
    //   receiverIcon: Icon(Icons.account_balance_wallet),
    //   senderIcon: Icon(Icons.account_box),
    // ),
    ChatModel(
      value: "pengirim",
      dateTime: DateTime.now(),
      receiverIcon: Icon(Icons.account_balance_wallet),
      senderIcon: Icon(Icons.account_box),
    ),
    ChatModel(
      sender: false,
      value: "penerima",
      dateTime: DateTime.now(),
      receiverIcon: Icon(Icons.account_balance_wallet),
      senderIcon: Icon(Icons.account_box),
    ),
  ];

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      upperBound: 1,
    );

    Timer(Duration(milliseconds: 1000), () {
      scrollController
        ..jumpTo(
          // ..animateTo(
          scrollController.position.maxScrollExtent + 50,
          // curve: Curves.easeOut,
          // duration: const Duration(milliseconds: 1000
          // ),
        );
      ModeUtil.debugPrint(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  void addChat() {
    if (inputMessage.text.isNotEmpty) {
      setState(() {
        message.insert(
          (message.length),
          ChatModel(
            sender: false,
            value: inputMessage.text,
            dateTime: DateTime.now(),
            receiverIcon: Icon(Icons.account_balance_wallet),
            senderIcon: Icon(Icons.account_box),
          ),
        );
        inputMessage.text = "";
      });
      scrollController
        ..jumpTo(
          scrollController.position.maxScrollExtent + 50,
          // curve: Curves.easeOut,
          // duration: const Duration(milliseconds: 1000
          // ),
        );
    }
  }

  void addIcons() {
    setState(() {
      if (addIcon) {
        alignmentAddIcon = Alignment(-0.9, 2);
        addIcon = false;
        iconAddFile = FontAwesomeLight(FontAwesomeId.fa_plus);
      } else {
        iconAddFile = FontAwesomeLight(FontAwesomeId.fa_minus);
        addIcon = true;
        alignmentAddIcon = Alignment(-0.9, 0.77);
      }
    });
    rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      upperBound: 1,
    );
    rotationController.forward();
  }

  void transcripts() {}

  void ratings() {}

  Future sendFiles({bool camera = true}) async {
    ModeUtil.debugPrint(camera);
    var image = camera
        ? await ImagePicker().pickImage(
            source: ImageSource.camera) //getImage(source: ImageSource.camera)
        : await ImagePicker().pickImage(
            source:
                ImageSource.gallery); //getImage(source: ImageSource.gallery);
    ImageUtil.compressFile(
      file: File(image.path),
      quality: 80,
    ).then((a) {
      setState(() {
        message.insert(
          (message.length),
          ChatModel(
            images: true,
            sender: false,
            value: a,
            dateTime: DateTime.now(),
            receiverIcon: Icon(Icons.account_balance_wallet),
            senderIcon: Icon(Icons.account_box),
          ),
        );
      });
      addIcons();
    }).catchError((e) {
      ModeUtil.debugPrint(e);
    });
  }
}
