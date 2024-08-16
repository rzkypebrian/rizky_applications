import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/module/deliveryPod/ViewModel.dart';
import 'package:enerren/module/deliveryPod/productOnlyPresenter.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOnlyView extends ProductOnlyPresenterState {
  @override
  Widget build(Object context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (ctx) => super.model,
      child: Scaffold(
        appBar: appBar(),
        body: body(),
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        bottomNavigationBar: buttonNavigationBar(),
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2,
                      offset: Offset(2, 4))
                ]),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "${System.data.resource.photoOfGoods}",
                        style: System.data.textStyleUtil.linkLabel(),
                      ),
                      Consumer<ViewModel>(
                        builder: (ctx, data, child) {
                          return Container(
                            // height: 320,
                            margin: EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: model.isValidImagePicker
                                    ? Colors.transparent
                                    : System.data.colorUtil.redColor,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: MultipleImagePickerComponent(
                                controller: super.model.imagePickerControllers,
                                size: (MediaQuery.of(context).size.width - 80) /
                                    3,
                                imageQuality: widget.imageQuality,
                                token: "bearer ${System.data.global.token}",
                                uploadUrl: widget.destinationId != null
                                    ? System.data.apiEndPointUtil
                                        .getPODUploadProductImage(
                                        destinationId: widget.destinationId,
                                        isPod: widget.isPod,
                                      )
                                    : null,
                                onUploadFailed: (error) {
                                  ModeUtil.debugPrint("ipload gagal $error");
                                },
                                onDeleteImage: onDeleteImage,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        circularProgressIndicatorDecoration(),
      ],
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${widget.title ?? System.data.resource.pod}",
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
      ),
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget buttonNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: BottonComponent.mainBotton(
        text: "${System.data.resource.next}",
        backgroundColor: System.data.colorUtil.primaryColor,
        onTap: () {
          submit();
        },
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: super.model.loadingController,
    );
  }
}
