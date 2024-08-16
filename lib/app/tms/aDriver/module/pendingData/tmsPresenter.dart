// import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
// import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/pendingData/main.dart';
import 'package:enerren/model/PendingDataModel.dart';
import 'package:enerren/app/sierad/util/ConstanUtil.dart' as constant;
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/StringExtention.dart';
// import 'package:enerren/util/DateTimeExtention.dart';
// import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';

mixin TmsPresenter on PresenterState {
  @override
  void sendItem(
    PendingDataModel pendingDataModel,
    CircularProgressIndicatorController itemController,
  ) {
    if (widget.onSnedItem != null) {
      widget.onSnedItem(pendingDataModel, itemController);
    } else {
      itemController.startLoading();
      super.model.commit();
      //read all data
      //#1 data shipment
      // TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipmentModel =
      //     TmsShipmentModel.fromJson<SieradShipmentDetailHatcheryModel>(
      //   (pendingDataModel.rawData
      //           .decode()[constant.SubPandingDataType.shipmentData] as String)
      //       .decode(),
      //   childReader: (data) {
      //     return SieradShipmentDetailHatcheryModel.fromJson(data);
      //   },
      // );
      //#2 data pod
      TmsDeliveryPodModel podData = TmsDeliveryPodModel.fromJson(
        (pendingDataModel.rawData.decode()[constant.SubPandingDataType.podData]
                as String)
            .decode(),
      );
      //#3 data stock
      // SieradDeliverStock stockData = SieradDeliverStock.fromJson(
      //   (pendingDataModel.rawData
      //           .decode()[constant.SubPandingDataType.stockData] as String)
      //       .decode(),
      // );
      //send data
      //#1 send data pod
      TmsDeliveryPodModel.set(
        token: System.data.global.token,
        param: podData,
      ).then((value) {
        pendingDataModel.status = PendingDataStatus.sent;
        model.messageStatus[pendingDataModel.id] = "";
        pendingDataModel.save(System.data.database);
        itemController.stopLoading();
        super.model.commit();
      }).catchError((onError) {
        pendingDataModel.status = PendingDataStatus.failed;
        super.model.messageStatus[pendingDataModel.id] =
            ErrorHandlingUtil.handleApiError(onError);
        itemController.stopLoading();
        super.model.commit();
      });
    }
  }
}
