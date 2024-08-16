import 'dart:io';

import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:component_icons/font_awesome.dart';

class MultipleImagePickerComponent extends StatelessWidget {
  final MultipleImagePickerController controller;
  final Widget addIcon;
  final bool camera;
  final bool galery;
  final Alignment popUpAlign;
  final WidgetFromDataBuilder<List<Widget>> builder;
  final WidgetFromDataBuilder2<int, ImagePickerController> imagePickerBuilder;
  final WidgetFromDataBuilder<BuildContext> addButtonBuilder;
  final WidgetFromDataBuilder2<VoidCallback, VoidCallback> popUpChild;
  final WidgetFromDataBuilder<VoidCallback> buttonCamera;
  final WidgetFromDataBuilder<VoidCallback> buttonGalery;
  final BoxDecoration popUpDecoration;
  final EdgeInsets popUpMargin;
  final EdgeInsets popUpPadding;
  final double popUpHeight;
  final double popUpWidth;
  final int imageQuality;
  final ValueChanged<ImagePickerController> onTap;
  final String uploadUrl;
  final String deleteUrl;
  final String token;
  final ValueChanged<File> onImageLoaded;
  final ValueChanged<String> onUploaded;
  final ValueChanged<dynamic> onUploadFailed;
  final ObjectBuilderWithParam<Future<bool>, ImagePickerController>
      onDeleteImage;
  final VoidCallback onImageDeleted;
  final double size;
  final bool showButtonDelete;

  const MultipleImagePickerComponent({
    Key key,
    this.controller,
    this.addIcon,
    this.camera = true,
    this.galery = true,
    this.popUpAlign,
    this.popUpDecoration,
    this.popUpMargin,
    this.popUpPadding,
    this.popUpHeight,
    this.popUpWidth,
    this.popUpChild,
    this.buttonCamera,
    this.buttonGalery,
    this.imagePickerBuilder,
    this.addButtonBuilder,
    this.onTap,
    this.builder,
    this.imageQuality,
    this.uploadUrl,
    this.deleteUrl,
    this.token,
    this.onUploaded,
    this.onUploadFailed,
    this.onDeleteImage,
    this.size,
    this.onImageLoaded,
    this.onImageDeleted,
    this.showButtonDelete = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MultipleImagePickerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return inputImage(context, value.imagePickerControllers);
      },
    );
  }

  Widget inputImage(BuildContext context,
      List<ImagePickerController> imagePickerControllers) {
    return builder != null
        ? builder(inputImageBuilder(context, imagePickerControllers))
        : Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: inputImageBuilder(context, imagePickerControllers),
              crossAxisAlignment: WrapCrossAlignment.end,
            ));
  }

  Widget imgPickerBuilder(
      int index, ImagePickerController imagePickerController) {
    return Container(
      height: size != null ? size + 5 : 115,
      width: size ?? 110,
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: <Widget>[
          showButtonDelete
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: GestureDetector(
                      onTap: () {
                        if (onDeleteImage != null) {
                          onDeleteImage(imagePickerController).then(
                            (value) {
                              if (value == true) {
                                controller.remove(index);
                                if (onImageDeleted != null) {
                                  onImageDeleted();
                                }
                              }
                            },
                          );
                        } else {
                          controller.remove(index);
                          if (onImageDeleted != null) {
                            onImageDeleted();
                          }
                        }
                      },
                      child: IconButton(
                        icon: Icon(
                            FontAwesomeRegular(FontAwesomeId.fa_times_circle)),
                        onPressed: () {
                          if (onDeleteImage != null) {
                            onDeleteImage(imagePickerController).then(
                              (value) {
                                if (value == true) {
                                  controller.remove(index);
                                  if (onImageDeleted != null) {
                                    onImageDeleted();
                                  }
                                }
                              },
                            );
                          } else {
                            controller.remove(index);
                            if (onImageDeleted != null) {
                              onImageDeleted();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: size != null ? size - 5 : 100,
              width: size != null ? size - 5 : 100,
              child: ImagePickerComponent(
                containerHeight: size != null ? size - 5 : 100,
                containerWidth: size != null ? size - 5 : 100,
                camera: camera,
                galery: galery,
                controller: imagePickerController,
                onTap: onTap,
                imageQuality: imageQuality,
                uploadUrl: uploadUrl,
                deleteUrl: deleteUrl,
                token: token,
                onUploaded: onUploaded,
                onUploadFailed: onUploadFailed,
                onImageLoaded: onImageLoaded,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Ada perubahan  pada icon , borderColor decorationBox, width dan height Container  untuk kebutuhan ImagePicker di module Absen

  Widget addBtnBuilder(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: System.data.colorUtil.colorBorderImage,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        // child: Icon(
        //   //Icons.add,
        //   size: 50,
        //   color: Colors.grey,
        // ),
        child: Icon(
          Icons.camera_alt,
          size: 30,
          color: Colors.grey,
        ),
        // child: SvgPicture.asset(
        //   "assets/add_rounded.svg",
        //   color: System.data.colorUtil.color009789,
        //   width: 25,
        //   height: 25,
        // ),
      ),
    );
  }

  List<Widget> inputImageBuilder(BuildContext context,
      List<ImagePickerController> imagePickerControllers) {
    List<Widget> widget = [];
    List.generate(imagePickerControllers.length, (i) {
      widget.add(imagePickerBuilder != null
          ? imagePickerBuilder(i, imagePickerControllers[i])
          : imgPickerBuilder(i, imagePickerControllers[i]));
    });
    widget.add(GestureDetector(
      onTap: () {
        if (camera == true && galery == true) {
          openModal(context);
        } else {
          controller.add(
            camera: camera,
            onImageLoaded: onImageLoaded,
          );
        }
      },
      child: addButtonBuilder != null
          ? addButtonBuilder(context)
          : addBtnBuilder(context),
    ));
    return widget;
  }

  void openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 1,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.red.withOpacity(0),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop("modal");
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.0),
            child: Align(
              alignment: popUpAlign ?? Alignment.bottomCenter,
              child: Container(
                height: popUpHeight ?? 170,
                width: popUpWidth ?? double.infinity,
                margin: popUpMargin ?? popUpAlign == Alignment.center
                    ? EdgeInsets.only(left: 10, right: 20)
                    : null,
                padding: popUpPadding ?? EdgeInsets.all(20),
                decoration: popUpDecoration ??
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: popUpAlign == Alignment.center
                            ? Radius.circular(20)
                            : Radius.zero,
                        bottomRight: popUpAlign == Alignment.center
                            ? Radius.circular(20)
                            : Radius.zero,
                      ),
                    ),
                child: popUpChild != null
                    ? popUpChild(() {
                        openCamera(context);
                      }, () {
                        openGalery(context);
                      })
                    : Column(
                        children: <Widget>[
                          Text(
                            System.data.resource.selectPhoto,
                            style: System.data.textStyleUtil.linkLabel(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          buttonCamera != null
                              ? buttonGalery(() {
                                  openGalery(context);
                                })
                              : Container(
                                  height: 35,
                                  width: 200,
                                  child: BottonComponent.roundedButton(
                                    onPressed: () {
                                      openCamera(context);
                                    },
                                    colorBackground:
                                        System.data.colorUtil.primaryColor,
                                    text: System.data.resource.camera,
                                    textstyle: System.data.textStyleUtil
                                        .mainLabel(
                                            color: System
                                                .data.colorUtil.secondaryColor),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          buttonGalery != null
                              ? buttonGalery(() {
                                  openGalery(context);
                                })
                              : Container(
                                  height: 35,
                                  width: 200,
                                  child: BottonComponent.roundedButton(
                                    onPressed: () {
                                      openGalery(context);
                                    },
                                    colorBackground:
                                        System.data.colorUtil.primaryColor,
                                    text: System.data.resource.galery,
                                    textstyle: System.data.textStyleUtil
                                        .mainLabel(
                                            color: System
                                                .data.colorUtil.secondaryColor),
                                  ),
                                ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void openGalery(BuildContext context) {
    Navigator.of(context).pop();
    controller.add(
      camera: false,
      onImageLoaded: onImageLoaded,
    );
  }

  void openCamera(BuildContext context) {
    Navigator.of(context).pop();
    controller.add(
      camera: true,
      onImageLoaded: onImageLoaded,
    );
  }
}

class MultipleImagePickerController
    extends ValueNotifier<MultipleImagePickerValue> {
  MultipleImagePickerController({MultipleImagePickerValue value})
      : super(value == null ? MultipleImagePickerValue() : value);

  bool isValid;

  void add({bool camera = true, ValueChanged<File> onImageLoaded}) {
    value.imagePickerControllers.add(new ImagePickerController());
    value.imagePickerControllers.last.getImages(
      camera: camera,
      onImageLoaded: onImageLoaded,
    );
    notifyListeners();
  }

  void remove(int index) {
    value.imagePickerControllers.removeAt(index);
    notifyListeners();
  }

  void clear() {
    value.imagePickerControllers.clear();
    notifyListeners();
  }

  List<String> getBase64() {
    List<String> result = [];
    for (ImagePickerController controller in value.imagePickerControllers) {
      result.add(controller.getBase64());
    }
    return result;
  }

  List<String> getBase64Compress() {
    List<String> result = [];
    for (ImagePickerController controller in value.imagePickerControllers) {
      result.add(controller.getBase64Compress());
    }
    return result;
  }

  List<dynamic> getUploadedImageId() {
    List<dynamic> result = [];
    for (ImagePickerController controller in value.imagePickerControllers) {
      if (controller.value.uploadedId != null)
        result.add(controller.value.uploadedId);
    }
    return result;
  }

  List<File> getFile() {
    List<File> result = [];
    for (ImagePickerController controller in value.imagePickerControllers) {
      result.add(controller.getFile());
    }
    return result;
  }

  bool validate() {
    bool result = true;
    for (ImagePickerController controller in value.imagePickerControllers) {
      // result = controller.getBase64().isNullOrEmpty() ? false : null;
      result = controller.validate();
      if (result == false) {
        return false;
      }
    }
    return result ?? true;
  }

  int length() {
    return value.imagePickerControllers.length;
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }
}

class MultipleImagePickerValue {
  List<ImagePickerController> imagePickerControllers;

  MultipleImagePickerValue({this.imagePickerControllers}) {
    if (imagePickerControllers == null) {
      imagePickerControllers = [];
    }
  }
}
