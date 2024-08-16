import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/module/deliveryPod/ViewModel.dart';
import 'package:enerren/module/deliveryPod/receiverOnlyPresenter.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiverOnlyView extends ReceiverOnlyPresenterState {
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
    return Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 400,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(30),
              decoration:
                  BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ]),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "${widget.senderLabel ?? System.data.resource.receiver}",
                          style: System.data.textStyleUtil.linkLabel(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ImagePickerComponent(
                            controller:
                                super.model.receiverImagePickerControllers,
                            galery: false,
                            containerHeight: 200,
                            containerWidth: 200,
                            imageQuality: widget.imageQuality,
                            minimumMemoryRequirement:
                                widget.minimumMemoryRequirement,
                            uploadUrl: widget.destinationId != null
                                ? System.data.apiEndPointUtil
                                    .getPODUploadReceicerImage(
                                    destinationId: widget.destinationId,
                                    isPod: widget.isPod,
                                  )
                                : null,
                            token: "bearer ${System.data.global.token}",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.senderNameLabel ?? System.data.resource.receiverName}",
                          style: System.data.textStyleUtil.linkLabel(),
                        ),
                        Consumer<ViewModel>(
                          builder: (ctx, data, child) {
                            return Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: InputComponent.inputTextWithUnderLine(
                                  controller: super.model.receiverController,
                                  underLineColor: super
                                              .model
                                              .receiverController
                                              .stateInput ==
                                          StateInput.Error
                                      ? System.data.colorUtil.redColor
                                      : System.data.colorUtil.primaryColor,
                                  contentPadding: EdgeInsets.only(bottom: 15)),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          circularProgressIndicatorDecoration(),
        ],
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      aligment: Alignment.bottomCenter,
      width: 50,
      controller: super.model.loadingController,
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
}
