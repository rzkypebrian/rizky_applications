import 'package:component_icons/font_awesome.dart';
import 'package:enerren/model/TripAllowanceModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'main.dart';
import 'presenter.dart';
import 'viewModel.dart';
import 'package:enerren/component/HeroComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (BuildContext context) => data,
        child: Consumer<ViewModel>(builder: (ctx, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(),
            body: body(dt),
            // bottomNavigationBar:
          );
        }));
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.travelingExpenses}",
      titleStyle: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.xl,
      ),
      backgroundColor: System.data.colorUtil.primaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Widget body(ViewModel vm) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                saldo(vm),
                detail(vm),
              ],
            ),
          ),
        ),
        angkutDecorationComponent(vm),
      ],
    );
  }

  Widget angkutDecorationComponent(ViewModel vm) {
    return DecorationComponent.circularProgressDecoration(
      controller: vm.loadingController,
    );
  }

  Widget saldo(ViewModel vm) {
    return DecorationComponent.saldo(
      saldo: vm.exspensesListView.endingBalance,
    );
  }

  Widget detail(ViewModel vm) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: new BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: System.data.colorUtil.shadowColor.withOpacity(0.2),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ]),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                vm.exspensesListView.status == 0
                    ? listInputComponent(vm)
                    : SizedBox(),
                listInput(vm),
                vm.exspensesListView.status == 0
                    ? bottomNavBar(vm)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listInput(ViewModel vm) {
    var _uangJalanDetailExpense = vm.exspensesListView.uangJalanDetailExpense;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              _uangJalanDetailExpense.length,
              (i) {
                return Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Text(
                            "${_uangJalanDetailExpense[i].expenseDescription}",
                            style: System.data.textStyleUtil.mainLabel(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            "${NumberFormat("#,###", System.data.resource.locale).format(_uangJalanDetailExpense[i].expenseValue)}",
                            style: System.data.textStyleUtil.mainLabel(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_uangJalanDetailExpense[i].expenseFile != null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return HeroComponent(
                                pathImage:
                                    '${_uangJalanDetailExpense[i].expenseFile}',
                                tagImage: "belajraHero",
                              );
                            }));
                          } else {
                            ModeUtil.debugPrint("kosong");
                          }
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Image.network(
                            "${_uangJalanDetailExpense[i].expenseFile}",
                            width: 30,
                          ),
                        ),
                      ),
                      vm.exspensesListView.status == 0
                          ? IconButton(
                              icon: Icon(
                                  FontAwesomeLight(FontAwesomeId.fa_trash_alt)),
                              onPressed: () => deleteItem(
                                  _uangJalanDetailExpense[i].walletId),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${System.data.resource.total}",
                      style: System.data.textStyleUtil
                          .mainLabel(color: System.data.colorUtil.primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      "${NumberFormat("#,###", System.data.resource.locale).format(vm.exspensesListView.totalExpense)}",
                      style: System.data.textStyleUtil
                          .mainLabel(color: System.data.colorUtil.redColor),
                    ),
                  ),
                ),
                Container(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavBar(ViewModel vm) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
      height: 80,
      child: BottonComponent.roundedButton(
        onPressed: finishItem,
        text: System.data.resource.submit,
        textstyle: System.data.textStyleUtil.mainLabel(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.lightTextColor,
        ),
        colorBackground: System.data.colorUtil.primaryColor,
      ),
    );
  }

  Widget listInputComponent(ViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: Text(
            "${System.data.resource.exspansesType}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.primaryColor,
            ),
          ),
        ),
        InputComponent.inputTextWithCorner(
          controller: typeExpanseController,
          corner: 5,
          borderWidth: 1,
          fontSize: System.data.fontUtil.xl,
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "${System.data.resource.price}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.primaryColor,
            ),
          ),
        ),
        InputComponent.inputTextWithCorner(
          corner: 5,
          borderWidth: 1,
          controller: priceController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 15),
        Container(
          //margin: EdgeInsets.only(bottom:10),
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "${System.data.resource.image}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.primaryColor,
            ),
          ),
        ),
        ImagePickerComponent(
          controller: imagePickerController,
          containerHeight: 60,
          containerWidth: 60,
          galery: false,
          container: ((child, value) {
            return Container(
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              margin: EdgeInsets.only(top: 10, bottom: 20),
              height: 60,
              decoration: BoxDecoration(
                  color: System.data.colorUtil.inputTextBackground,
                  border: Border.all(
                    color: value.state == ImagePickerComponentState.Disable
                        ? System.data.colorUtil.disableColor
                        : value.state == ImagePickerComponentState.Enable
                            ? System.data.colorUtil.borderInputColor
                            : System.data.colorUtil.errorColor,
                    style: BorderStyle.solid,
                    width: 2,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Text("${imagePickerController.getFileName()}"),
                  ),
                  Center(
                    child: Icon(FontAwesomeLight(FontAwesomeId.fa_camera_alt)),
                  ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 10),
        vm.exspensesListView.status == 0
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10, bottom: 30),
                child: GestureDetector(
                  onTap: submit,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/plus.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              )
            : Container(),
        Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "${System.data.resource.type}",
                    style: TextStyle(
                      fontSize: System.data.fontUtil.xl,
                      color: Colors.blue[600],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "${System.data.resource.price}",
                    style: TextStyle(
                      fontSize: System.data.fontUtil.xl,
                      color: Colors.blue[600],
                    ),
                  ),
                ),
                Container(
                    child: Text(
                  "${System.data.resource.image}",
                  style: TextStyle(
                    fontSize: System.data.fontUtil.xl,
                    color: Colors.blue[600],
                  ),
                )),
              ],
            )),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Divider(
            color: Colors.grey[600],
            thickness: 1.0,
            indent: 0,
            endIndent: 0,
          ),
        ),
      ],
    );
  }

  Widget listTravelingExpense(TripAllowanceSummaryModel id) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: 120,
              margin: EdgeInsets.only(right: 10),
              child: Text(
                "${id.expenseDescription}",
                style: TextStyle(
                  color: System.data.colorUtil.inputTextColor,
                  fontSize: System.data.fontUtil.l,
                ),
              )),
          Container(
              margin: EdgeInsets.only(right: 35),
              width: 100,
              child: Text(
                "Rp. ${NumberFormat("#,##0", "en_US").format(id.expenseValue)}",
                style: TextStyle(
                  color: System.data.colorUtil.inputTextColor,
                  fontSize: System.data.fontUtil.l,
                ),
              )),
          Container(
              child: IconButton(
                  icon: SvgPicture.network(
                    "${id.expenseFile}",
                    width: 18,
                    height: 18,
                  ),
                  onPressed: () {
                    if (id.expenseFile != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return HeroComponent(
                          pathImage: '${id.expenseFile}',
                          tagImage: "belajraHero",
                        );
                      }));
                    }
                  })),
        ],
      ),
    );
  }
}
