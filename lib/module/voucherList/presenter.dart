import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<TmsVoucherModel> onSelected;

  const Presenter({
    Key key,
    this.view,
    this.onSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();

  void initState() {
    getVouchers();
    super.initState();
  }

  void getVouchers() {
    model.loadingController.startLoading();
    print("lang : ${System.data.resource.lang}");
    print("token : ${System.data.global.token}");
    TmsVoucherModel.get(
      token: System.data.global.token,
    ).then((value) {
      print("sukses ${value.length}");
      model.vouchers = value;
      model.loadingController.stopLoading();
      model.commit();
    }).catchError((onError) {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void onTapVoucher(TmsVoucherModel voucher) {
    if (widget.onSelected != null) {
      widget.onSelected(voucher);
    }
  }
}
