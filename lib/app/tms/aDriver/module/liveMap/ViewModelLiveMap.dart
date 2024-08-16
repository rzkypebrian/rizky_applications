import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:flutter/widgets.dart';

class ViewModeliveMap extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  int starPage = 0;

  PageController pageController = PageController(
    initialPage: 0,
  );
  TmsShipmentModel tmsShipmentModel = TmsShipmentModel();

  int get totalDestination =>
      tmsShipmentModel.tmsShipmentDestinationList.length;

  void commit() {
    notifyListeners();
  }

  void changePage(int p) {
    starPage = p;
    commit();

    changeTo(p);
  }

  bool get finishUnloadingDestinetion {
    if ((tmsShipmentModel.tmsShipmentDestinationList[starPage].detailStatus
            as int) !=
        10)
      return false;
    else
      return true;
  }

  void changePageButton({bool next = true}) {
    if (next) {
      starPage++;
      starPage = (starPage >= (totalDestination - 1))
          ? (totalDestination - 1)
          : starPage;
    } else {
      starPage--;
      starPage = (starPage <= 0) ? 0 : starPage;
    }
    commit();
    changeTo(starPage);
  }

  void changeTo(int p) {
    pageController.animateToPage(p,
        curve: Curves.ease, duration: Duration(seconds: 1));
    commit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
