import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/app/sierad/module/liveMap/SieradViewModel.dart';
import 'package:enerren/component/driverInfoDecoration.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'sieradView.dart';

class TransporterView extends SieradView {
  final SieradViewModel sieradViewModel;
  final ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      onTapDetailOrder;

  TransporterView({
    this.sieradViewModel,
    this.onTapDetailOrder,
  }) {
    super.viewModel = this.sieradViewModel;
  }

  @override
  Widget contentPage1() {
    return DriverInfoDecoration.popupMapDriverInfo(
      driverImageUrl: viewModel.driverImageUrl,
      driverName: viewModel.driverName,
      nik: viewModel.nik,
      phoneNumber: viewModel.customerPhoneNumber,
      email: viewModel.email,
      birdDate: viewModel.birdDate,
      address: viewModel.address,
      topRightWidget: viewModel.selectedShipment != null
          ? GestureDetector(
              onTap: () {
                if (onTapDetailOrder != null) {
                  onTapDetailOrder(viewModel.selectedShipment);
                }
              },
              child: Text(
                "${System.data.resource.orderDetail}",
                style: System.data.textStyleUtil
                    .linkLabel(textDecoration: TextDecoration.underline),
              ),
            )
          : Container(
              width: 0,
              height: 0,
            ),
    );
  }
}
