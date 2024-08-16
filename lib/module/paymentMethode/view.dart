import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/model/PaymentMethodeDetailModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(Object context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Scaffold(
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        appBar: BottonComponent.customAppBar1(
          backButtonColor: System.data.colorUtil.lightTextColor,
          backgroundColor: System.data.colorUtil.primaryColor,
          titleStyle: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          ),
          context: context,
          actionText: "",
          title: "${System.data.resource.paymentMethod}",
        ),
        body: Stack(
          children: [
            listPaymentMethode(),
            circularProgressIndicatorDecoration(),
          ],
        ),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  Widget listPaymentMethode() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 20, bottom: 15),
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Consumer<ViewModel>(
          builder: (c, d, h) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                model.paymentMethods.length,
                (index) {
                  return model
                          .paymentMethods[index].paymentMethodDetails.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 50,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                model.paymentMethods[index].methodName,
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Column(
                              children: List.generate(
                                  model.paymentMethods[index]
                                      .paymentMethodDetails.length, (i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Radio<PaymentMethodeDetailModel>(
                                          value: model.paymentMethods[index]
                                              .paymentMethodDetails[i],
                                          groupValue:
                                              model.selectedMethodDetail,
                                          onChanged: selectPaymentMethode,
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        padding: EdgeInsets.all(5),
                                        child: SvgPicture.network(
                                            "${model.paymentMethods[index].paymentMethodDetails[i].iconUrl}"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${model.paymentMethods[index].paymentMethodDetails[i].methodDetailName}",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            )
                          ],
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
