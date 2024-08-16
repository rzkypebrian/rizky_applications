class EnvironmentModel {
  String os;
  AndroidOs detailAndroid;
  IosOs detailsIos;
  MemoryDevice memory;
  DiskSpaceDevice diskSpace;
  int battrey;
  EnvironmentModel({
    this.os,
    this.detailAndroid,
    this.detailsIos,
    this.memory,
    this.diskSpace,
    this.battrey,
  });
}

class MemoryDevice {
  int totalMemory;
  int freeMemory;
  int totalVirtualMemory;
  int freeVirtualMemory;
  MemoryDevice({
    this.totalMemory,
    this.freeMemory,
    this.totalVirtualMemory,
    this.freeVirtualMemory,
  });
}

class DiskSpaceDevice {
  double total;
  double free;

  DiskSpaceDevice({this.total, this.free});
}

class AndroidOs {
  AndroidBVersion version;
  String board;
  String bootloader;
  String brand;
  String device;
  String display;
  String fingerprint;
  String hardware;
  String host;
  String id;
  String manufacturer;
  String model;
  String product;
  List<String> supported32BitAbis;
  List<String> supported64BitAbis;
  List<String> supportedAbis;
  String tags;
  String type;
  bool isPhysicalDevice;
  String androidId;
  List<String> systemFeatures;

  AndroidOs({
    this.version,
    this.board,
    this.bootloader,
    this.brand,
    this.device,
    this.display,
    this.fingerprint,
    this.hardware,
    this.host,
    this.id,
    this.manufacturer,
    this.model,
    this.product,
    this.supported32BitAbis,
    this.supported64BitAbis,
    this.supportedAbis,
    this.tags,
    this.type,
    this.isPhysicalDevice,
    this.androidId,
    this.systemFeatures,
  });
}

class IosOs {
  String name;
  String systemName;
  String systemVersion;
  String localizedModel;
  String identifierForVendor;
  IosUts utsname;
  IosOs({
    this.name,
    this.systemName,
    this.systemVersion,
    this.localizedModel,
    this.identifierForVendor,
    this.utsname,
  });
}

class IosUts {
  String sysname;
  String nodename;
  String release;
  String version;
  String machine;

  IosUts({
    this.sysname,
    this.nodename,
    this.release,
    this.version,
    this.machine,
  });
}

class AndroidBVersion {
  String baseOS;
  String codename;
  String incremental;
  int previewSdkInt;
  String release;
  int sdkInt;
  String securityPatch;
  AndroidBVersion({
    this.baseOS,
    this.codename,
    this.incremental,
    this.previewSdkInt,
    this.release,
    this.sdkInt,
    this.securityPatch,
  });
}
