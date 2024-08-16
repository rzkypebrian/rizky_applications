import 'package:enerren/app/angkut/model/AngkutDestination.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
// import 'package:enerren/app/angkut/aCustomer/module/detailLocation/main.dart'
//     as detailLocation;

List<AngkutDestination> readDestinationModel(
    List<ObjectData<dynamic>> listPoint) {
  List<AngkutDestination> _detailDestinationList = <AngkutDestination>[];

  //collect destination
  _detailDestinationList = [];
  for (var i = 0; i < listPoint.length; i++) {
    var _data = listPoint[i];
    if (i == 0) {
      addDestination(_detailDestinationList, _data);
    } else if (i == 1) {
      editDestination(_detailDestinationList, _data, 0);
    } else {
      addDestination(_detailDestinationList, listPoint[i - 1]);
      editDestination(
          _detailDestinationList, _data, (_detailDestinationList.length - 1));
    }
  }

  return _detailDestinationList;
}

List<AngkutDestination> addDestination(
    List<AngkutDestination> source, ObjectData<dynamic> destination) {
  source.add(
    new AngkutDestination(
      originLat: destination.latLng.latitude,
      originLon: destination.latLng.longitude,
      originAddress: (destination.data).address,
      originPropinsi: (destination.data).provinsi,
      originKabupaten: (destination.data).kabupaten,
      originKecamatan: (destination.data).kecamatan,
      originAdditionalInfo: (destination.data).detailAdress,
      originContactPerson: (destination.data).name,
      originContactNumber: (destination.data).phoneNumber,
      originNoteForDriver: (destination.data).noteForDriver,
    ),
  );
  return source;
}

List<AngkutDestination> editDestination(
    List<AngkutDestination> source, ObjectData<dynamic> destination, int id) {
  source[id].destinationLat = destination.latLng.latitude;
  source[id].destinationLon = destination.latLng.longitude;
  source[id].destinationAddress = (destination.data).address;
  source[id].destinationPropinsi = (destination.data).provinsi;
  source[id].destinationKabupaten = (destination.data).kabupaten;
  source[id].destinationKecamatan = (destination.data).kecamatan;
  source[id].destinationAdditionalInfo = (destination.data).detailAdress;
  source[id].destinationContactPerson = (destination.data).name;
  source[id].destinationContactNumber = (destination.data).phoneNumber;
  source[id].destinationNoteForDriver = (destination.data).noteForDriver;
  return source;
}
