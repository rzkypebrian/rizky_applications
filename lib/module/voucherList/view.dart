import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(Object context) {
    return Center(
      child: ChangeNotifierProvider<ViewModel>(
        create: (_) => super.model,
        child: Scaffold(
          appBar: BottonComponent.customAppBar1(
            context: context,
            actionText: "",
            title: System.data.resource.voucher,
            backgroundColor: System.data.colorUtil.primaryColor,
            backButtonColor: System.data.colorUtil.lightTextColor,
            titleStyle: System.data.textStyleUtil.pageTitle(),
          ),
          body: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        voucherItemList(),
        circularProgressIndicatorDecoration(),
      ],
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  Widget voucherItemList() {
    return Consumer<ViewModel>(
      builder: (c, d, h) {
        if (model.vouchers.length > 0) {
          return ListView(
            children: List.generate(
              model.vouchers.length,
              (index) {
                return voucherItem(model.vouchers[index]);
              },
            ),
          );
        } else {
          return emptyData();
        }
      },
    );
  }

  Widget voucherItem(TmsVoucherModel voucher) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
      child: GestureDetector(
        onTap: () {
          onTapVoucher(voucher);
        },
        child: Center(
          child: SvgPicture.network(
            voucher.imageVoucher,
            fit: BoxFit.fitWidth,
            placeholderBuilder: (_) {
              return SvgPicture.asset("assets/sample/voucher_loading.svg");
            },
          ),
        ),
      ),
    );
  }

  Widget emptyData() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Text(
          System.data.resource.dataIsEmoty ?? "",
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.darkTextColor,
          ),
        ),
      ),
    );
  }
}
