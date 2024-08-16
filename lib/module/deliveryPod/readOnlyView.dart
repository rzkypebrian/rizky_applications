import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/component/HeroComponent.dart';
import 'package:intl/intl.dart';
import 'view.dart';
import 'package:flutter/material.dart';
import 'readOnlyPresenter.dart';

class ReadOnlyView extends View with ReadOnlyPresenter {
  TmsDeliveryPodModel deliveryPodModel;

  ReadOnlyView({
    this.deliveryPodModel,
  }) {
    print("token ${System.data.global.token}");
    super.deliveryPodModel = this.deliveryPodModel;
  }

  @override
  List<Widget> listComponent() {
    return [
      receiverName(),
      SizedBox(
        height: 15,
      ),
      pictureOfGoods(),
      SizedBox(
        height: 15,
      ),
      signature(),
      SizedBox(
        height: 15,
      ),
      barcode(),
    ];
  }

  @override
  Widget topOutherCard() {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5, top: 15, right: 25),
        child: Text(
          "${super.deliveryPodModel.podTime != null ? DateFormat(System.data.resource.longDateFormat, System.data.resource.dateLocalFormat).format(super.deliveryPodModel.podTime) : "-"}",
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget receiverName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                receiverLabel(
                  textStyle: System.data.textStyleUtil.linkLabel(),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("${super.deliveryPodModel.receiverName}"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  System.data.resource.address,
                  style: System.data.textStyleUtil.linkLabel(),
                ),
                SizedBox(
                  height: 5,
                ),
                // Container(
                //   child: Text(
                //       "${super.deliveryPodModel.podLat} ${super.deliveryPodModel.podLon}"),
                // ),
                super.deliveryPodModel.podLat != null &&
                        super.deliveryPodModel.podLon != null
                    ? FutureBuilder(
                        future: GeolocatorUtil.getAddress(
                          super.deliveryPodModel.podLat,
                          super.deliveryPodModel.podLon,
                        ),
                        initialData: "${System.data.resource.loading}",
                        builder: (context, snapshoot) {
                          return Text("${snapshoot.data}");
                        },
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return HeroComponent(
                pathImage: '${super.deliveryPodModel.receiverPhoto ?? ""}',
                tagImage: "",
                backgroundColor: Colors.black,
              );
            }));
          },
          child: Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: System.data.colorUtil.primaryColor,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    super.deliveryPodModel.receiverPhoto ?? "",
                  ),
                  fit: BoxFit.fill,
                )),
          ),
        )
      ],
    );
  }

  Widget pictureOfGoods() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${System.data.resource.photo}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children:
                List.generate(super.deliveryPodModel.productPhoto?.length, (i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return HeroComponent(
                      pathImage:
                          '${super.deliveryPodModel.productPhoto[i] ?? ""}',
                      tagImage: "",
                      backgroundColor: Colors.black,
                    );
                  }));
                },
                child: Container(
                  // margin: EdgeInsets.only(
                  //     left: i == 0 ? 0 : 10,
                  //     right: i == super.deliveryPodModel.productPhoto.length - 1
                  //         ? 0
                  //         : 10),
                  margin: EdgeInsets.all(2),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(
                      color: System.data.colorUtil.primaryColor,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        super.deliveryPodModel.productPhoto[i] ?? "",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget signature() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${System.data.resource.signature}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return HeroComponent(
                  pathImage: '${super.deliveryPodModel.ePODSign ?? ""}',
                  tagImage: "",
                  backgroundColor: Colors.white,
                );
              }));
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: System.data.colorUtil.primaryColor,
                ),
                image: DecorationImage(
                    image: NetworkImage(
                      super.deliveryPodModel.ePODSign ?? "",
                    ),
                    fit: BoxFit.fill),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget barcode() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${System.data.resource.barcode}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          SizedBox(
            height: 10,
          ),
          Text("${super.deliveryPodModel.barcode ?? "-"}")
        ],
      ),
    );
  }

  @override
  Widget bottomNavigationBar() {
    return Container(
      height: 0,
      width: 0,
    );
  }
}
