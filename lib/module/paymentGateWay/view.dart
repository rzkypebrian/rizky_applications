import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'presenter.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(Object context) {
    print("payment url is : ${widget.paymentUrl}");
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        body: Stack(
          children: [
            paymentGateWayPage(),
            circularProgressIndicatorDecoration(),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.payment}",
      backgroundColor: System.data.colorUtil.primaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
      ),
    );
  }

  Widget paymentGateWayPage() {
    return WebView(
      onWebResourceError: ((e) {
        ModeUtil.debugPrint("onWebResourceError $e");
      }),
      initialUrl: widget.paymentUrl ?? "http:www.google.com",
      onWebViewCreated: (WebViewController webViewController) {
        model.webViewController = webViewController;
      },
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>[
        _alert(context),
      ].toSet(),
      gestureNavigationEnabled: true,
      onPageStarted: (url) => model.loadingController.startLoading(),
      onPageFinished: onPageLoadFinished,
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith("shopeeid://")) {
          launchURL(request.url);
          return NavigationDecision.prevent;
        } else {
          return NavigationDecision.values.last;
        }
      },
      debuggingEnabled: true,
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  JavascriptChannel _alert(BuildContext context) {
    return JavascriptChannel(
      name: 'alert',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message.message),
            duration: Duration(hours: 1),
          ),
        );
      },
    );
  }

  Widget bottomNavigationBar() {
    return SafeArea(
      child: Consumer<ViewModel>(
        builder: (c, d, h) {
          return model.showButtonNavigationBar == true
              ? Container(
                  height: 50,
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 0,
                    bottom: 15,
                  ),
                  child: BottonComponent.roundedButton(
                    radius: 5,
                    colorBackground: System.data.colorUtil.primaryColor,
                    text: System.data.resource.viewYourOrder,
                    textstyle: System.data.textStyleUtil.mainTitle(
                      fontWeight: FontWeight.normal,
                    ),
                    onPressed: onTapViewOrder,
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                );
        },
      ),
    );
  }
}
