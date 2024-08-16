import 'package:component_icons/font_awesome.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/module/maps/main.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'inovatrackPresenter.dart';

class InovatrackView extends View with InovatrackPresenter {
  final ValueChanged<VtsPositionModel> onTapinfo;
  final VoidCallback onTapHistory;
  final VtsPositionModel selectedVehicle;

  InovatrackView({
    this.onTapinfo,
    this.onTapHistory,
    this.selectedVehicle,
  }) {
    super.selected = this.selectedVehicle;
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            bottomBarButton(
                fontAwesomeId: FontAwesomeId.fa_plus,
                onTap: () {
                  super.model.mapsControllers.zoom();
                }),
            bottomBarButton(
                fontAwesomeId: FontAwesomeId.fa_minus,
                onTap: () {
                  super.model.mapsControllers.zoom(
                        zoom: false,
                      );
                }),
            bottomBarButton(
              fontAwesomeId: FontAwesomeId.fa_info,
              onTap: () {
                onTapinfo(model.selected);
              },
            ),
            bottomBarButton(
              fontAwesomeId: FontAwesomeId.fa_history,
              onTap: onTapHistory,
            ),
            bottomBarButton(
              fontAwesomeId: FontAwesomeId.fa_location,
              onTap: () {
                super.model.mapsControllers.newCameraPosition(
                      latLng: LatLng(model.selected.lat, model.selected.lon),
                      zoom: 14,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  List<Widget> listComponent() {
    return [
      map(),
      bottomBar(),
    ];
  }

  Widget bottomBarButton({
    @required int fontAwesomeId,
    @required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: System.data.colorUtil.primaryColor,
          border: Border.all(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
          boxShadow: [
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Icon(
          FontAwesomeSolid(fontAwesomeId),
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }
}
