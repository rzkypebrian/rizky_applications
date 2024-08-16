import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'presenter.dart';

class AngkutDecorationView extends State<Presenter>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  // DateTime registerDate = new DateTime(2010, DateTime.september, 20);
  DateTime listDate = DateTime.now();

  int radioGroup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
      body: ListView(
        children: <Widget>[
          driverTab(),
          driverItem(),
          vehicleItem(),
        ],
      ),
    );
  }

  Widget appBar() {
    {
      return BottonComponent.customAppBar1(
          context: context,
          elevetion: 0,
          backgroundColor: System.data.colorUtil.blueColor,
          titleColor: System.data.colorUtil.lightTextColor,
          title: System.data.resource.vehicleList,
          actionText: System.data.resource.back);
    }
  }

  Widget driverTab() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: TabBar(
              controller: tabController,
              unselectedLabelColor: System.data.colorUtil.greyColor,
              unselectedLabelStyle: System.data.textStyleUtil.mainLabel(
                  fontWeight: FontWeight.bold,
                  fontSize: System.data.fontUtil.xl),
              labelColor: System.data.colorUtil.lightTextColor,
              labelStyle: System.data.textStyleUtil.mainLabel(
                  fontWeight: FontWeight.bold,
                  fontSize: System.data.fontUtil.xl),
              indicator: BoxDecoration(
                  border: Border.all(
                      width: 60, color: System.data.colorUtil.blueColor)),
              labelPadding: EdgeInsets.only(top: 5),
              tabs: <Widget>[
                Tab(
                  child: Container(
                    //color:System.data.colorUtil.primaryColor,
                    child: Text("Kendaraan"),
                  ),
                ),
                Tab(text: "Pengemudi")
              ],
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: System.data.colorUtil.scafoldColor,
                boxShadow: [
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ]),
            padding: EdgeInsets.only(left: 15, right: 10),
            child: TabBarView(controller: tabController, children: <Widget>[
              Container(
                //color: Colors.white,
                child: Row(
                  children: <Widget>[
                    allDriverStatus(),
                    orderDriverStatus(),
                    siagaDriverStatus(),
                    restDriverStatus(),
                  ],
                ),
              ),
              Container(
                // color: Colors.yellow,
                child: Row(
                  children: <Widget>[
                    allDriverStatus(),
                    orderDriverStatus(),
                    siagaDriverStatus(),
                    restDriverStatus(),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget allDriverStatus() {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            child: Radio(
                activeColor: Colors.blue,
                value: 1,
                groupValue: radioGroup,
                onChanged: (T) {
                  setState(() {
                    print(T);
                    radioGroup = T;
                  });
                }),
          ),
          Text(
            "Semua",
            style: TextStyle(
                color: System.data.colorUtil.blueColor,
                fontSize: System.data.fontUtil.l),
          )
        ],
      ),
    );
  }

  Widget orderDriverStatus() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            child: Radio(
                activeColor: Colors.orange,
                hoverColor: Colors.grey,
                value: 2,
                groupValue: radioGroup,
                onChanged: (T) {
                  setState(() {
                    print(T);
                    radioGroup = T;
                  });
                }),
          ),
          Text(
            "Order",
            style: TextStyle(
                color: System.data.colorUtil.statusColor,
                fontSize: System.data.fontUtil.l),
          )
        ],
      ),
    );
  }

  Widget siagaDriverStatus() {
    return Container(
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              child: Radio(
                  activeColor: Colors.green,
                  value: 3,
                  groupValue: radioGroup,
                  onChanged: (T) {
                    setState(() {
                      print(T);
                      radioGroup = T;
                    });
                  }),
            ),
            Text(
              "Siaga",
              style: TextStyle(
                  color: System.data.colorUtil.greenColor,
                  fontSize: System.data.fontUtil.l),
            )
          ],
        ));
  }

  Widget restDriverStatus() {
    return Container(
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(),
        child: Row(
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              child: Radio(
                  activeColor: Colors.red,
                  value: 4,
                  groupValue: radioGroup,
                  onChanged: (T) {
                    setState(() {
                      print(T);
                      radioGroup = T;
                    });
                  }),
            ),
            Text(
              "Istirahat",
              style: TextStyle(
                  color: System.data.colorUtil.redColor,
                  fontSize: System.data.fontUtil.l),
            )
          ],
        ));
  }

  Widget driverItem(
      {String noReg = "3178876658",
      String driverName = "Mardigu",
      String driverSim = "SIM A",
      String driverRate,
      Color colorCircular = Colors.red}) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      height: 113,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: System.data.colorUtil.lightTextColor,
        boxShadow: [
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(15),
              bottomLeft: const Radius.circular(15),
            )),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgImageVehicle.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: System.data.colorUtil.lightTextColor,
                        width: 2,
                      ),
                      image: new DecorationImage(
                        image: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-1.15, -1.15),
                  child: circularIcon(primaryColor: colorCircular),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                child: Stack(
              children: <Widget>[
                Align(
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgscafold.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "$noReg",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: System.data.fontUtil.m,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  // registerDate.toString(),
                                  DateFormat(System.data.resource.dateFormat,
                                          System.data.resource.locale)
                                      .format(listDate),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: System.data.fontUtil.m,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            color: Colors.blue[600],
                            // thickness: 1.0,
                            // indent: 110,
                            // endIndent: 10,
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 10, top: 0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        "$driverName",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize:
                                                System.data.fontUtil.lPlus,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "$driverSim", //untuk get data dari data dummy
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: System.data.fontUtil.l,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: RatingComponent(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  Widget vehicleItem(
      {String noReg = "XXXXXX",
      String desc = "Pick Up Box",
      String vehiclePlat = "B 6745 TB",
      Color colorCircular = Colors.orange}) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      height: 113,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: System.data.colorUtil.lightTextColor,
        boxShadow: [
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(15),
              bottomLeft: const Radius.circular(15),
            )),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgImageVehicle.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: System.data.colorUtil.lightTextColor,
                        width: 2,
                      ),
                      image: new DecorationImage(
                        image: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-1.15, -1.15),
                  child: circularIcon(primaryColor: colorCircular),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                child: Stack(
              children: <Widget>[
                Align(
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgscafold.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "No_Reg  $noReg",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: System.data.fontUtil.m,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  DateFormat(System.data.resource.dateFormat,
                                          System.data.resource.locale)
                                      .format(listDate),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: System.data.fontUtil.m,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            color: Colors.blue[600],
                            // thickness: 1.0,
                            // indent: 110,
                            // endIndent: 10,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "$desc",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize:
                                                System.data.fontUtil.lPlus,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "$vehiclePlat", //untuk get data dari data dummy
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: System.data.fontUtil.l,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  Widget circularIcon({
    Color primaryColor = Colors.red,
    Color secondaryColor = Colors.white,
  }) {
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        color: secondaryColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: secondaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
