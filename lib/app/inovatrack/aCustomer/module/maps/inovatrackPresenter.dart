import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/module/maps/presenter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin InovatrackPresenter on PresenterState {
  VtsPositionModel selected;

  @override
  void onFirstDraw() {
    if (selected != null) {
      super.model.selected = selected;
      super.model.commit();
      super.model.mapsControllers.newCameraPosition(
            latLng: LatLng(super.model.selected.lat, super.model.selected.lon),
            zoom: 22,
          );
    }
  }

  @override
  String onCreatePositionMarkerIcon(VtsPositionModel vtsPositionModel) {
    if(vtsPositionModel.engine == 1 && vtsPositionModel.speed > 4){
      return "assets/inovatrack/icon_map_vehicle_driving.png";
    }else if(vtsPositionModel.engine == 1){
      return "assets/inovatrack/icon_map_vehicle_pause.png";
    }else{
      return "assets/inovatrack/icon_map_vehicle_parking.png";
    }
  }
}
