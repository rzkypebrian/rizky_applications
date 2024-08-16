import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/DateTimeUtil.dart';
// import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'viewModel.dart';
import 'package:enerren/util/StringExtention.dart';
// import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/inovatrackDecorationComponent.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (context) => super.model,
        child: Scaffold(
          appBar: appbar(),
          body: Stack(
            children: <Widget>[
              body(),
              circularProgressIndicatorDecoration(),
            ],
          ),
        ));
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: super.loadingController,
    );
  }

  Widget appbar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.vehicles}",
      backgroundColor: System.data.colorUtil.primaryColor,
      actionTextColor: System.data.colorUtil.lightTextColor,
      titleColor: System.data.colorUtil.lightTextColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: 40,
              margin: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ],
              ),
              width: double.infinity,
              child: Consumer<ViewModel>(
                builder: (vContext, vm, child) {
                  return InputComponent.dropDownWithCorner(
                    onChangeds: (val) {
                      changeFleet(val);
                    },
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    hint: "Fleet",
                    value: model.selectedFleet?.fleetId,
                    items: List.generate(model.fleets.length, (index) {
                      return DropdownMenuItem<int>(
                        value: model.fleets[index].fleetId,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: System.data.colorUtil.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                "${model.vehicles.where((i) => model.fleets[index].vehicles.cast<int>().contains(i.vehicleId)).toList().length}",
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.lightTextColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${model.fleets[index].fleetName}",
                              style: System.data.textStyleUtil.mainLabel(),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                },
              )),
          Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                 BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
              ],
            ),
            child: InputComponent.inputTextWithCorner(
                hintText: "${System.data.resource.search}",
                prefixIcon: Container(
                  margin: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/inovatrack/icon_search.svg"),
                ),
                controller: searchController,
                fontSize: System.data.fontUtil.xl,
                borderInputGray: Colors.white,
                contentPadding: EdgeInsets.all(5),
                onChanged: (val) {
                  filterVehicle();
                }),
          ),
          Consumer<ViewModel>(
            builder: (vContext, vm, child) {
              return Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  children: List.generate(
                    model.filteredVehicles.length,
                    (i) {
                      return vehicleItemView(super.model.filteredVehicles[i]);
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget vehicleItemView(VtsPositionModel data) {
    return GestureDetector(
      onTap: (){
        onTapListItem(data);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: System.data.colorUtil.secondaryColor,
            boxShadow: <BoxShadow>[
               BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
            ]),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: SvgPicture.asset(
                          data.engine == 1 && data.speed > 0
                              ? "assets/inovatrack/icon_list_moving.svg"
                              : data.engine == 1
                                  ? "assets/inovatrack/icon_list_pause.svg"
                                  : "assets/inovatrack/icon_p.svg",
                        ),
                      ),
                      DateTimeUtil.dateDiffWithNow(data.dateTime).inSeconds > 60
                          ? Container(
                              margin: EdgeInsets.only(right: 3),
                              child: SvgPicture.asset(
                                  "assets/inovatrack/not_update.svg"),
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: SvgPicture.asset(data.mainPower
                            ? "assets/inovatrack/icon_battery_green.svg"
                            : "assets/inovatrack/icon_battery_yellow.svg"),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "${DateTimeUtil.getStringDateDiff(data.dateTime)}",
                    style: System.data.textStyleUtil.mainLabel(),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "${data.vehicleName}",
                style: System.data.textStyleUtil.mainLabel(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "${data.driverName.isNullOrEmpty() ? "-" : data.driverName}",
                style: System.data.textStyleUtil.mainLabel(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text(
                "${data.streetName} ${data.kabupaten} ${data.kecamatan}",
                style: System.data.textStyleUtil.mainLabel(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
