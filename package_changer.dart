import 'dart:io';

void main(List<String> arguments) async {
  if (arguments[0] == "changePackage") {
    String packageName;
    String appName;
    int versionCode;
    String versionName;
    String launcherIcon;
    String keystore;
    String notificationIcon;
    String mapApiKey;
    String assets;
    String route;
    stdout.writeln("apakah anda yakin akan menerapkan setting berikut?");
    stdout.writeln(
        "-------------------------------------------------------------------");
    stdout.writeln("|");
    for (var i = 1; i < arguments.length; i++) {
      switch (arguments[i]) {
        case "--applicationId":
          packageName = arguments[i + 1];
          stdout.writeln("| applicationId    : $packageName");
          break;
        case "--applicationName":
          appName = arguments[i + 1];
          stdout.writeln("| applicationName  : $appName");
          break;
        case "--buildNumber":
          versionCode = int.parse(arguments[i + 1]);
          stdout.writeln("| buildNumber      : $versionCode");
          break;
        case "--buildName":
          versionName = (arguments[i + 1]);
          stdout.writeln("| buildName        : $versionName");
          break;
        case "--launcherAssets":
          launcherIcon = (arguments[i + 1]);
          stdout.writeln("| launcherAssets   : $launcherIcon");
          break;
        case "--keystore":
          keystore = (arguments[i + 1]);
          stdout.writeln("| keystore         : $keystore");
          break;
        case "--notificationIcon":
          notificationIcon = (arguments[i + 1]);
          stdout.writeln("| notificationIcon : $notificationIcon");
          break;
        case "--mapApiKey":
          mapApiKey = (arguments[i + 1]);
          stdout.writeln("| mapApiKey        : $mapApiKey");
          break;
        case "--assets":
          assets = (arguments[i + 1]);
          stdout.writeln("| assets           : $assets");
          break;
        case "--route":
          route = (arguments[i + 1]);
          stdout.writeln("| route            : $route");
          break;
      }
    }
    stdout.writeln("|");
    stdout.writeln(
        "-------------------------------------------------------------------");
    stdout.writeln("tulis \"Y\" untuk melanjutkan!");
    var response = stdin.readLineSync();
    if (response != "Y" && response != "y") return;
    changePackage(
      packageName: packageName,
      appName: appName,
      versionCode: versionCode,
      versionName: versionName,
      newIcon: launcherIcon,
      keyStoreProperties: keystore,
      notificationIcon: notificationIcon,
      googleMapApiKey: mapApiKey,
      assets: assets,
      route: route,
    );
  } else if (arguments[0] == "changeGoogleMapApiKey") {
    if (arguments.length != 2) {
      print(
          "change package memerlukan 1 parameter googleMapApiKey anda memasukan ${arguments.length - 1}");
    } else {
      changeGoogleMapApiKey(arguments[1]);
    }
  }
}

Future<void> changePackage({
  String packageName,
  String appName,
  int versionCode,
  String versionName,
  String newIcon,
  String keyStoreProperties,
  String notificationIcon,
  String googleMapApiKey,
  String assets,
  String route,
}) async {
  //print("change bundle id in android/app/build.gradle");
  File buildGradle = File('android/app/build.gradle');
  buildGradle.readAsString().then((String contents) {
    var newcontent = contents;

    if (packageName != null) {
      stdout.writeln("change applicationId in android/app/build.gradle");
      newcontent = newcontent.replaceAll(
          RegExp(r'applicationId ".*"'), 'applicationId "$packageName"');
    }

    if (versionCode != null) {
      stdout.writeln("change version code in android/app/build.gradle");
      newcontent = newcontent.replaceAll(
          RegExp(r'versionCode .*'), 'versionCode $versionCode');
    }

    if (versionName.isNotEmpty && versionName != null) {
      stdout.writeln("change version name in android/app/build.gradle");
      newcontent = newcontent.replaceAll(
          RegExp(r'versionName .*'), "versionName '$versionName'");
    }

    if (keyStoreProperties.isNotEmpty && keyStoreProperties != null) {
      stdout.writeln("change keystoreproperties in android/app/build.gradle");
      newcontent = newcontent.replaceAll(
          RegExp(r"def keystorePropertiesFile = rootProject\.file\(\'.*\'\)"),
          "def keystorePropertiesFile = rootProject.file('properties/$keyStoreProperties.properties')");
    }

    buildGradle.writeAsString(newcontent);
  });

  File debugManifest = File('android/app/src/debug/AndroidManifest.xml');
  debugManifest.readAsString().then((contents) {
    var newcontent = contents;
    if (packageName != null) {
      stdout.writeln("change applicationId in android manifest debug");
      newcontent = contents.replaceAll(
          RegExp(r'package=".*"'), 'package="$packageName"');
    }
    debugManifest.writeAsString(newcontent);
  });

  File mainManifest = File('android/app/src/main/AndroidManifest.xml');
  await mainManifest.readAsString().then((contents) {
    var newcontent = contents;
    if (packageName != null) {
      stdout.writeln(
          "change applicationId in android manifest main to $packageName");
      newcontent = newcontent.replaceAll(
          RegExp(r'package=".*"'), 'package="$packageName"');
    }

    if (appName != null) {
      stdout.writeln(
          "change applicationName in android manifest main to $appName");
      newcontent = newcontent.replaceAll(
          RegExp(r'(android:label="[^"]*")'), 'android:label="$appName"');
    }

    mainManifest.writeAsString(newcontent);
  });

  File mainActivityJava =
      File('android/app/src/main/java/com/example/enerren/MainActivity.java');
  await mainActivityJava.readAsString().then((contents) {
    var newcontent = contents;

    if (packageName != null) {
      stdout.writeln("change applicationId in android mainActivity.java");
      newcontent =
          newcontent.replaceAll(RegExp(r'package .*'), 'package $packageName;');
    }
    mainActivityJava.writeAsString(newcontent);
  });

  File mainActivityKt =
      File('android/app/src/main/kotlin/com/example/enerren/MainActivity.kt');
  await mainActivityKt.readAsString().then((contents) {
    var newcontent = contents;
    if (packageName != null) {
      stdout.writeln("change applicationId in android mainActivity.kt");
      newcontent =
          newcontent.replaceAll(RegExp(r'package .*'), 'package $packageName');
    }

    mainActivityKt.writeAsString(newcontent);
  });

  File internalDataUtil = File('lib/util/internalDataUtil.dart');
  await internalDataUtil.readAsString().then((contents) {
    var newcontent = contents;
    if (versionName != null) {
      stdout.writeln("change versionName in android internalDataUtil.dart");
      newcontent = newcontent.replaceAll(
          RegExp(r'String version = .*'), 'String version = "$versionName";');
    }
    if (appName != null) {
      stdout.writeln("change applicationName in android internalDataUtil.dart");
      newcontent = newcontent.replaceAll(RegExp(r'String applicationName = .*'),
          'String applicationName = "$appName";');
    }
    internalDataUtil.writeAsString(newcontent);
  });

  if (newIcon != null) {
    stdout.writeln("change image path in flutter_loucher_icon.yaml");
    File laucherIcon = File('flutter_launcher_icons.yaml');
    await laucherIcon.readAsString().then((contents) {
      var newcontent = contents.replaceAll(
          RegExp(r'image_path:.*'), 'image_path: "$newIcon"');
      laucherIcon.writeAsString(newcontent);
    });
  }

  stdout.writeln("updade google service json");
  if (FileSystemEntity.typeSync("google-service/$packageName.json") !=
      FileSystemEntityType.notFound) {
    File googleServiceProperties = File('google-service/$packageName.json');
    print("update google-service.json");
    await googleServiceProperties.readAsString().then((value) async {
      File("android/app/google-services.json").writeAsString(value);
      print("add google service");
      File buildGradle = File('android/app/build.gradle');
      await buildGradle.readAsString().then((String contents) {
        var newcontent = contents.replaceAll(
            RegExp(
                r'\/\/--google play service--\/\/([\x00-\x7F]*?)\/\/--google play service--\/\/'),
            "//--google play service--// \n" +
                "apply plugin: 'com.google.gms.google-services' \n" +
                "googleServices { disableVersionCheck = true } \n" +
                "//--google play service--//");
        buildGradle.writeAsString(newcontent);
      });
    });
  } else {
    print("delete google-service.json");
    if (FileSystemEntity.typeSync("android/app/google-services.json") !=
        FileSystemEntityType.notFound) {
      final dir = Directory("android/app/google-services.json");
      dir.deleteSync(recursive: true);
    }
    print("remark google-service in build gradle");
    File buildGradle2 = File('android/app/build.gradle');
    await buildGradle2.readAsString().then((String contents) {
      var newcontent = contents.replaceAll(
          RegExp(
              r'\/\/--google play service--\/\/[\x00-\x7F]*?\/\/--google play service--\/\/'),
          "//--google play service--// \n" +
              "//apply plugin: 'com.google.gms.google-services' \n" +
              "//googleServices { disableVersionCheck = true } \n" +
              "//--google play service--//");
      buildGradle2.writeAsString(newcontent);
    });
  }

  stdout.writeln("update notification icon");
  List<String> resolusi = [
    "drawable-hdpi",
    "drawable-mdpi",
    // "drawable-v24",
    "drawable-xhdpi",
    "drawable-xxhdpi",
    "drawable-xxxhdpi"
  ];

  if (notificationIcon.isNotEmpty) {
    for (var item in resolusi) {
      File iconFile = File(
          'drawable/$notificationIcon/$item/ic_stat_onesignal_default.${item == "drawable-v24" ? "xml" : "png"}');
      iconFile.copy(
          "android/app/src/main/res/$item/ic_stat_onesignal_default.${item == "drawable-v24" ? "xml" : "png"}");
    }
  } else {
    for (var item in resolusi) {
      File iconFile = File(
          'drawable/default_icon_notification/$item/ic_stat_onesignal_default.${item == "drawable-v24" ? "xml" : "png"}');
      iconFile.copy(
          "android/app/src/main/res/$item/ic_stat_onesignal_default.${item == "drawable-v24" ? "xml" : "png"}");
    }
  }

  // print("update google map apikey"); 

  if (googleMapApiKey != null && googleMapApiKey != "") {
    await changeGoogleMapApiKey(googleMapApiKey);
  } else {
    await changeGoogleMapApiKey("AIzaSyBE996CIxSciAsuAPanJ3izkguREa6VvYA");
  }

  if (assets != null) {
    stdout.writeln("update assets in pubspec.yaml");
    try {
      File pubspecYaml = File('pubspec.yaml');
      File assetYaml = File('yaml-assets/$assets.yaml');
      String assetYamlContent = await assetYaml.readAsString();
      await pubspecYaml.readAsString().then((contents) {
        var newcontent = contents.replaceAll(
            RegExp(r'#assets#([\x00-\x7F]*?)#assets#'),
            '#assets#\n$assetYamlContent\n#assets#');
        pubspecYaml.writeAsString(newcontent);
      });
    } catch (e) {
      stdout.writeln(textError(e.toString()));
    }
  }

  if (route != null) {
    stdout.writeln("update route in route.dart");
    try {
      File routeDart = File('lib/route.dart');
      File newRouteDart = File('route-dart/$route.dart');
      String newRouteDartContent = await newRouteDart.readAsString();
      await routeDart.readAsString().then((contents) {
        routeDart.writeAsString(newRouteDartContent);
      });
    } catch (e) {
      stdout.writeln(textError(e.toString()));
    }
  }

  stdout.writeln("harap jalankan ${textWrning("flutter pub get")} kemudian");
  stdout.writeln(
      "harap jalankan ${textWrning("flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons.yaml")}");
  stdout.writeln("untuk menerapkan icon baru");
  stdout.writeln(
      "untuk build apk jalankan ${textInfo("flutter build apk --release --no-tree-shake-icons")}");
  stdout.writeln(
      "untuk build app bundle jalankan ${textInfo("flutter build appbundle --target-platform android-arm,android-arm64,android-x64 --no-tree-shake-icons")}");
}

Future<void> changeGoogleMapApiKey(String apiKey) async {
  stdout.writeln("change google map api key in build.gradle");
  File buildGradle2 = File('android/app/build.gradle');
  await buildGradle2.readAsString().then((String contents) {
    var newcontent2 = contents.replaceAll(
        RegExp(r'(mapsApiKey:[^"]*"[^"]*")'), 'mapsApiKey: "$apiKey"');
    buildGradle2.writeAsString(newcontent2);
  });
  stdout.writeln("change google map api key in AppDelegate.m");
  File appDelegate = File('ios/Runner/AppDelegate.m');
  await appDelegate.readAsString().then((String contents) {
    var newcontent = contents.replaceAll(
        RegExp(r'(\[GMSServices provideAPIKey:@"[^"]*"\])'),
        '[GMSServices provideAPIKey:@"$apiKey"]');
    appDelegate.writeAsString(newcontent);
  });
}

String textWrning(String text) {
  return '\x1B[33m$text\x1B[0m';
}

String textError(String text) {
  return ('\x1B[31m$text\x1B[0m');
}

String textInfo(String text) {
  return ('\x1B[32m$text\x1B[0m');
}
