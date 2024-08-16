import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/liveCameraComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/util/SizeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/signatureComponent.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
      appBar: appBar(),
      body: home(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.pod,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.secondaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget home() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              topOutherCard(),
              Container(
                color: System.data.colorUtil.secondaryColor,
                margin: EdgeInsets.only(top: 0, bottom: 28),
                padding:
                    EdgeInsets.only(left: 28, right: 28, top: 17, bottom: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listComponent(),
                ),
              ),
            ],
          ),
        ),
        circularProgressIndicatorDecoration(),
      ],
    );
  }

  Widget topOutherCard() {
    return SizedBox(
      height: 20,
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      inputReceiverName(),
      inputPod(),
      inputImage(),
      inputBarcode(),
    ];
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: super.model.loadingController,
    );
  }

  Widget inputPod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "e-POD",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SignatureComponent(
          controller: super.model.signatureComponentController,
          onSign: onSign,
          builder: (context, value, component) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: super.model.isSignatureValid == true
                          ? System.data.colorUtil.borderInputColor
                          : Colors.red,
                      style: BorderStyle.solid)),
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  component,
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              super.model.signatureComponentController.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                  FontAwesomeLight(FontAwesomeId.fa_eraser)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget inputReceiverName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                receiverLabel(),
                Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Container(
                      width: SizeUtil.w1(context) - 110,
                      child: InputComponent.inputTextWithCorner(
                          backgroundColor: System.data.colorUtil.secondaryColor,
                          hintText: '',
                          borderInputGray:
                              System.data.colorUtil.borderInputColor,
                          controller: super.model.receiverController,
                          textInputAction: TextInputAction.done,
                          corner: 5,
                          keyboardType: TextInputType.text),
                    )),
              ],
            ),
          ),
        ),
        cameraOnline(),
      ],
    );
  }

  Widget receiverLabel({TextStyle textStyle}) {
    return Text(
      "${widget.receiverNameLabel ?? System.data.resource.receiverName}",
      style: textStyle ?? System.data.textStyleUtil.mainLabel(),
    );
  }

  Widget inputImage() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Text(
            System.data.resource.takeItemImage,
            textAlign: TextAlign.left,
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ),
        MultipleImagePickerComponent(
          galery: false,
          controller: super.model.imagePickerControllers,
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
                            super.model.imagePickerControllers.remove(id);
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
                      color: super.model.isValidImagePicker == false
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

  Widget inputBarcode() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${System.data.resource.barcode}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Container(
                child: Container(
              child: InputComponent.inputTextWithCorner(
                  backgroundColor: System.data.colorUtil.secondaryColor,
                  hintText: '',
                  borderInputGray: System.data.colorUtil.borderInputColor,
                  controller: super.model.barcodeController,
                  stateInput: super.model.barcodeStateInput,
                  textInputAction: TextInputAction.done,
                  onSubmited: (val) {},
                  corner: 5,
                  fontSize: System.data.fontUtil.l,
                  textAlign: TextAlign.start,
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
                      onPressed: () => super
                          .model
                          .barcodeReaderComponentController
                          .startBarcodeScanStream(onResult: (str) {
                        super.model.barcodeController.text = str;
                      }),
                      icon: Icon(
                        FontAwesomeLight(FontAwesomeId.fa_barcode_read),
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                  onChanged: (string) {
                    super.model.barcodeReaderComponentController.result =
                        string;
                  },
                  keyboardType: TextInputType.text),
            )),
          ),
        ],
      ),
    );
  }

  Widget cameraOnline() {
    return LiveCameraComponent(
      controller: super.model.liveCameraComponentController,
      builder: (context, value, child) {
        return Container(
          height: 100,
          width: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(
            color: super.model.isValidPhoto == false
                ? Colors.red
                : System.data.colorUtil.borderInputColor,
          )),
          child: child,
        );
      },
    );
  }

  Widget bottomNavigationBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottonComponent.roundedButton(
            onPressed: () => submit(),
            text: System.data.resource.finish,
            fontSize: System.data.fontUtil.m,
            colorBackground: System.data.colorUtil.primaryColor),
      ),
    );
  }
}
