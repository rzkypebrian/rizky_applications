import 'package:enerren/main.dart' as main;
import 'package:enerren/util/InternalDataUtil.dart';

class System {
  static InternalDataUtil get data {
    return main.data;
  }

  // static final SystemStream stream = new SystemStream(main.data);

  static void commit() {
    // stream.stateSink.add(data);
    main.data.commit();
  }
}
