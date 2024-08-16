import 'package:enerren/module/splashScreen/presenter.dart';
// import 'package:enerren/util/SystemUtil.dart';
import 'package:system_info/system_info.dart';

mixin SieradPresenter on PresenterState {
  @override
  void initState() {
    print("Memory Free ${(SysInfo.getFreePhysicalMemory()).toString()}");
    super.autoStart = true;
    super.initState();
  }
}
