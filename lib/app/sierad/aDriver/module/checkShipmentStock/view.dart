import 'package:enerren/app/sierad/util/WordingUtil.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: System.data.colorUtil.scaffoldBackgroundColor),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: BottonComponent.customAppBar1(
              actionText: "",
              context: context,
              title: "${System.data.resource.checkingGoods}",
              titleStyle: System.data.textStyleUtil.mainTitle(),
              actionTextStyle: System.data.textStyleUtil.mainTitle(),
              backgroundColor: System.data.colorUtil.primaryColor,
              backButtonColor: System.data.colorUtil.lightTextColor,
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 30,
                right: 30,
              ),
              child: BottonComponent.roundedButton(
                  colorBackground: System.data.colorUtil.primaryColor,
                  text: '${System.data.resource.next}',
                  textstyle: System.data.textStyleUtil.mainTitle(),
                  onPressed: () {
                    submit();
                  }),
            ),
            body: Container(
              height: height(),
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              decoration:
                  BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ]),
              child: Center(
                child: ListView(
                  children: listCComponent(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: circularProgressIndicatorDecoration(),
          ),
        ],
      ),
    );
  }

  double height() {
    return 450;
  }

  List<Widget> listCComponent() {
    return <Widget>[
      inputNumberOfBox(),
      inputNumberOfDoc(),
      inputNumberOfDocBonus(),
      inputNumberOfDocDead(),
    ];
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }

  Widget inputNumberOfDoc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${System.data.resource.numberOf} ${widget.shipment.shipmentTypeName}",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: InputComponent.inputTextWithCorner(
            controller: numberOfDocController,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.number,
            fontSize: System.data.fontUtil.xl,
            focusnode: numberOfDocNode,
            numberOnly: true,
            onSubmited: (val) {
              FocusScope.of(context).requestFocus(numberOfDocBonusNode);
            },
            contentPadding: EdgeInsets.only(bottom: 10, left: 10),
          ),
        )
      ],
    );
  }

  Widget inputNumberOfDocDead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Text(
          "${System.data.resource.numberOf} ${widget.shipment.shipmentTypeName} ${WordingUtil.brokenWordingByShipmentType(widget.shipment.shipmentTypeName)}",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: InputComponent.inputTextWithCorner(
            controller: numberOfDocDeadController,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.number,
            fontSize: System.data.fontUtil.xl,
            focusnode: numberOfDocDeadNode,
            numberOnly: true,
            onSubmited: (val) {},
            contentPadding: EdgeInsets.only(bottom: 10, left: 10),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget inputNumberOfDocBonus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Text(
          "${System.data.resource.numberOf} ${widget.shipment.shipmentTypeName} ${System.data.resource.bonus} ${System.data.resource.received} ",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: InputComponent.inputTextWithCorner(
            controller: numberOfDocBonusController,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.number,
            fontSize: System.data.fontUtil.xl,
            focusnode: numberOfDocBonusNode,
            numberOnly: true,
            onSubmited: (val) {
              FocusScope.of(context).requestFocus(numberOfDocDeadNode);
            },
            contentPadding: EdgeInsets.only(bottom: 10, left: 10),
          ),
        ),
      ],
    );
  }

  Widget inputNumberOfBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${System.data.resource.numberOfBoxReceived}",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: InputComponent.inputTextWithCorner(
            controller: numberOfBoxController,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.number,
            fontSize: System.data.fontUtil.xl,
            focusnode: numberOfBoxFocuseNode,
            numberOnly: true,
            onSubmited: (str) {
              FocusScope.of(context).requestFocus(numberOfDocNode);
            },
            contentPadding: EdgeInsets.only(bottom: 10, left: 10),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
