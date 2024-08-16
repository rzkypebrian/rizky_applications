import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'viewModel.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        body: Stack(
          children: [
            listItem(),
            circularProgressIndicatorDecoration(loadingController)
          ],
        ),
        bottomNavigationBar: bottonNavigationBar(),
      ),
    );
  }

  Widget listItem() {
    return Container(
      child: Consumer<ViewModel>(
        builder: (crx, dt, child) {
          return ListView(
            children: List.generate(dt.shipmentItemDescriptions.length, (i) {
              return item(dt.shipmentItemDescriptions[i]);
            }),
          );
        },
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.loadingDetail,
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

  Widget item(ShipmentItemDescriptionViewModel data) {
    return Container(
      color: System.data.colorUtil.secondaryColor,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 13),
            child: SvgPicture.asset(
              widget.iconItemAssets ?? 'assets/boxs.svg',
              height: 38,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text("${data.item}"),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              widget.showQtyField
                                  ? Container(
                                      child: Text("${data.qty}"),
                                    )
                                  : SizedBox(),
                              widget.showUnitField
                                  ? Container(
                                      margin: EdgeInsets.only(right: 36),
                                      child: Text("${data.uomName}"),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child:
                            Container(child: Text("${data.itemDescription}")),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget circularProgressIndicatorDecoration(
      CircularProgressIndicatorController controller) {
    if (widget.loadingDecoration != null) {
      return widget.loadingDecoration(controller);
    } else {
      return DecorationComponent.circularProgressDecoration(
        aligment: Alignment.topCenter,
        controller: controller,
      );
    }
  }

  Widget bottonNavigationBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          onTapViewPOD();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              System.data.resource.viewPOD,
              style: System.data.textStyleUtil.linkLabel(),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              FontAwesomeRegular(FontAwesomeId.fa_arrow_right),
              size: 18,
              color: System.data.colorUtil.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
