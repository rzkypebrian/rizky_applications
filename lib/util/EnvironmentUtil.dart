import 'package:battery/battery.dart';
import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
// import 'package:disk_space/disk_space.dart';
import 'package:enerren/model/EnvironmentModel.dart';
import 'package:system_info/system_info.dart';

class EnvironmentUtil {
  static const int MEGABYTE = 1024 * 1024;
  AndroidDeviceInfo adi;

  // static Map<String, dynamic> get getKernal {
  //   return {
  //     "main": "kernel",
  //     "name": "${SysInfo.kernelName}",
  //     "architecture": "${SysInfo.kernelArchitecture}",
  //     "version": "${SysInfo.kernelVersion}",
  //   };
  // }

  // static Map<String, dynamic> get getOS {
  //   return {
  //     "main": "os",
  //     "name": "${Platform.operatingSystem}",
  //     "version": "${Platform.operatingSystemVersion}",
  //     "numberOfProcessors": "${Platform.numberOfProcessors}",
  //     "pathSeparator": "${Platform.pathSeparator}",
  //     "localHostname": "${Platform.localHostname}",
  //   };
  // }

  // static Map<String, dynamic> get getUser {
  //   return {
  //     "main": "user",
  //     "directory": "${SysInfo.userDirectory}",
  //     "id": "${SysInfo.userId}",
  //     "name": "${SysInfo.userName}",
  //   };
  // }

  static MemoryDevice get getMemory {
    return MemoryDevice(
        totalMemory: SysInfo.getTotalPhysicalMemory() * 10 ~/ MEGABYTE,
        freeMemory: SysInfo.getFreePhysicalMemory() * 10 ~/ MEGABYTE,
        totalVirtualMemory: SysInfo.getTotalVirtualMemory() * 10 ~/ MEGABYTE,
        freeVirtualMemory: SysInfo.getFreeVirtualMemory() * 10 ~/ MEGABYTE);
  }

  static Future<DiskSpaceDevice> get getDiskSpace async {
    final DiskSpaceDevice _diskSpaceDevice = DiskSpaceDevice(
        // total: await DiskSpace.getFreeDiskSpace ?? 0,
        // free: await DiskSpace.getTotalDiskSpace ?? 0
        );

    return _diskSpaceDevice;
  }

  static Future<IosOs> get getDetailIos async {
    final _values = await DeviceInfoPlugin().iosInfo;
    return IosOs(
      name: _values.name,
      systemName: _values.systemName,
      systemVersion: _values.systemVersion,
      localizedModel: _values.localizedModel,
      identifierForVendor: _values.identifierForVendor,
      utsname: IosUts(
        machine: _values.utsname.machine,
        nodename: _values.utsname.nodename,
        release: _values.utsname.release,
        sysname: _values.utsname.sysname,
        version: _values.utsname.version,
      ),
    );
  }

  static Future<AndroidOs> get getDetailAndroid async {
    final _value = await DeviceInfoPlugin().androidInfo;
    return AndroidOs(
      androidId: _value.androidId,
      board: _value.board,
      bootloader: _value.bootloader,
      brand: _value.brand,
      device: _value.device,
      display: _value.display,
      fingerprint: _value.fingerprint,
      hardware: _value.hardware,
      host: _value.host,
      id: _value.id,
      isPhysicalDevice: _value.isPhysicalDevice,
      manufacturer: _value.manufacturer,
      model: _value.model,
      product: _value.product,
      supported32BitAbis: _value.supported32BitAbis,
      supported64BitAbis: _value.supported64BitAbis,
      supportedAbis: _value.supportedAbis,
      systemFeatures: _value.systemFeatures,
      tags: _value.tags,
      type: _value.type,
      version: AndroidBVersion(
        baseOS: _value.version.baseOS,
        codename: _value.version.codename,
        incremental: _value.version.incremental,
        previewSdkInt: _value.version.previewSdkInt,
        release: _value.version.release,
        sdkInt: _value.version.sdkInt,
        securityPatch: _value.version.securityPatch,
      ),
    );
  }

  static Future<int> get getBattery async {
    Battery _battery = Battery();
    final int _batteryLevel = await _battery.batteryLevel;
    return _batteryLevel;
  }

  static Future<void> get getBatteryState async {
    Battery _battery = Battery();
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      print("state battery $state");
    }).asFuture((e) {
      print("error battery ${e.message}");
    });
  }

  static Future<EnvironmentModel> get readDevice async {
    EnvironmentModel _environmentModel = EnvironmentModel();

    if (Platform.isAndroid) {
      _environmentModel = EnvironmentModel(
        os: "Android",
        detailAndroid: await getDetailAndroid,
        diskSpace: await getDiskSpace,
        battrey: await getBattery,
        memory: getMemory,
      );
    } else if (Platform.isIOS) {
      _environmentModel = EnvironmentModel(
        os: "IOS",
        detailsIos: await getDetailIos,
        // diskSpace: await getDiskSpace,
        // battrey: await getBattery,
      );
    }
    return _environmentModel;
  }

  // static Map<String, dynamic> get getOSs {
  //   return {
  //     "":"${}",
  //     "":"${}",
  //     "":"${}",
  //   };
  // }
}
