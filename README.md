# rizky_applications

A new Flutter project.

ini adalah based project untuk aplikasi yang ada di Enerren. Untuk project ini tersedia hanya pada flutter versi 2, project ini belum di upgrade ke flutter versi 3.

## Getting Started

buat breach baru dari breanc ini dan mulai menambahkan modul modul atau komppnen lainnya dengan cara pull from pada vs code

## Change Icon Louncher

ubah settingan pada file flutter_louncher_icon.yaml dan jalankan perintah berikut pada terminal

```c
flutter pub get
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons.yaml
```

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

--cara bikin keystore
rizky-MacBook-Pro:Enerren_Mobile-1 rizky$ keytool -genkey -v -keystore ~/sieraddriver.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

--cara bikin .pem untuk reset keystore
keytool -export -rfc -alias unggah -file upload_certificate.pem -keystore keystore.jks

---catatan build

## create app bundle

flutter build apk --release --no-tree-shake-icons

You are building a fat APK that includes binaries for android-arm, android-arm64, android-x64.
If you are deploying the app to the Play Store, it's recommended to use app bundles or split the
APK to reduce the APK size.
    To generate an app bundle, run:
        `flutter build appbundle --target-platform android-arm,android-arm64,android-x64 --no-tree-shake-icons`
        Learn more on: <https://developer.android.com/guide/app-bundle>
    To split the APKs per ABI, run:
        flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
        Learn more on:
        <https://developer.android.com/studio/build/configure-apk-splits#configure-abi-split>



## Create PEPK private key

`java -jar pepk.jar --keystore=sieradcustomer.jks --alias=key --output=sieradcustomer --encryptionkey=eb10fe8f7c7c9df715022017b00c6471f8ba8170b13049a11e6c09ffe3056a104a3bbe4ac5a955f4ba4fe93fc8cef27558a3eb9d2a529a2092761fb833b656cd48b9de6a`



## sierad driver -> sreeya

### BRAH Driver --core--

 dart package_changer.dart changePackage --applicationId 'com.enerren.sierad.driver' --applicationName 'Sreeya Driver' --buildNumber 87 --buildName 1.2.37 --launcherAssets 'assets/sierad/driver_launcher.png' --keystore sieraddriver --notificationIcon sreeya_driver_notification_icon --assets sierad --route 'sierad/driver'

### Live Bird Driver

 dart package_changer.dart changePackage --applicationId 'com.enerren.sieradlb.driver' --applicationName 'Sreeya Live Bird Driver' --buildNumber 5 --buildName 1.1.5 --launcherAssets 'assets/sierad/louncher_live_bird_driver.png' --keystore sieraddriver --notificationIcon sreeya_livebird_notification_icon --assets sieradlb --route 'sieradlb/driver'

## sierad customer -> sreeya

### BRAH

 dart package_changer.dart changePackage --applicationId 'com.enerren.sierad.customer' --applicationName 'Sreeya Customer' --buildNumber 41 --buildName 1.2.11 --launcherAssets 'assets/sierad/sreeya_louncher.png' --keystore sieradcustomer --notificationIcon sreeya_notification_icon --assets sierad --route 'sierad/customer'

### Live Bird

 dart package_changer.dart changePackage --applicationId 'com.enerren.sieradlb.customer' --applicationName 'Live Bird Customer' --buildNumber 4 --buildName 1.1.4 --launcherAssets 'assets/sierad/loucher_live_bird.png' --keystore sieradcustomer --notificationIcon sreeya_livebird_notification_icon --assets sieradlb --route 'sieradlb/customer'

## sierad transporter -> sreeya

### BRHA transporter

 dart package_changer.dart changePackage --applicationId 'com.enerren.sierad.transporter' --applicationName 'Sreeya Transporter' --buildNumber 48 --buildName 1.2.18 --launcherAssets 'assets/sierad/transporter_launcher.png' --keystore sieradtransporter --notificationIcon sreeya_transporter_notification_icon --assets sierad --route 'sierad/transporter'

### Live Bird transporter

 dart package_changer.dart changePackage --applicationId 'com.enerren.sieradlb.transporter' --applicationName 'Sreeya Live Bird Transporter' --buildNumber 4 --buildName 1.1.4 --launcherAssets 'assets/sierad/louncher_live_bird_transporter.png' --keystore sieradtransporter --notificationIcon sreeya_livebird_notification_icon --assets sieradlb --route 'soeradlb/transporter'

## sierad admin -> sreeya

### BRAH Admin

 dart package_changer.dart changePackage --applicationId 'com.enerren.sierad.admin' --applicationName 'Sreeya Admin' --buildNumber 45 --buildName 1.2.15 --launcherAssets 'assets/sierad/admin_launcher.png' --keystore sieradadmin --notificationIcon sreeya_admin_notification_icon --assets sierad --route 'sierad/admin'

### live Bird Admin

 dart package_changer.dart changePackage --applicationId 'com.enerren.sieradlb.admin' --applicationName 'Sreeya Live Bird Admin' --buildNumber 4 --buildName 1.1.4 --launcherAssets 'assets/sierad/admin_launcher.png' --keystore sieradadmin --notificationIcon sreeya_livebird_notification_icon  --assets sieradlb --route 'sieradlb/admin'



## angkut driver

dart package_changer.dart changePackage --applicationId "com.enerren.angkut.driver" --applicationName 'Angkut Driver' --buildNumber 82 --buildName '1.3.52' --launcherAssets 'assets/angkut/driver_launcher.png' --keystore 'angkutdriver' --notificationIcon 'angkut_notification_icon' --mapApiKey 'AIzaSyByt2IOztZscq6-dpO_3nGxVajuFOduDY0' --assets angkut --route 'angkut/driver'

### Angkut Basic

 dart package_changer.dart changePackage  --applicationId 'com.enerren.angkut.driver' --applicationName 'Angkut Driver' --buildNumber 74 --buildName 1.2.44 --launcherAssets 'assets/angkut/driver_launcher.png' --keystore angkutdriver --assets angkut --route 'angkut/driver'

### Inova Pickup Style

 dart package_changer.dart changePackage  --applicationId 'com.enerren.inovapickup.driver' --applicationName 'Inova Pickup Driver' --buildNumber 10 --buildName 1.1.44 --launcherAssets 'assets/angkut/logo_inovatrack_driver.png' --keystore angkutdriver  --assets angkut --route 'angkut/driver'

### Inova Pickup People Transport

dart package_changer.dart changePackage --applicationId 'com.enerren.inovapt.driver' --applicationName 'Driver People Transport' --buildNumber 7 --buildName 1.1.7 --launcherAssets 'assets/inovapickup/inova_piclup_people_transport_driver_launcher.png' --keystore angkutdriver --assets angkut --route 'angkut/driver'



## angkut customer

### Angkut Basic

dart package_changer.dart changePackage --applicationId 'com.enerren.angkut.customer' --applicationName 'Angkut' --buildNumber 137 --buildName 1.3.106 --launcherAssets 'assets/angkut/logo_angkut.png' --keystore angkutcustomer  --notificationIcon angkut_notification_icon  --mapApiKey AIzaSyByt2IOztZscq6-dpO_3nGxVajuFOduDY0 --assets angkut --route 'angkut/customer'

### Inova Pickup Style

dart package_changer.dart changePackage --applicationId 'com.enerren.inovapickup.customer' --applicationName 'Inova Pickup' --buildNumber 11 --buildName 1.1.11 --launcherAssets 'assets/angkut/logo_inovatrack.png' --keystore angkutcustomer --assets angkut --route 'angkut/customer'

### Inova Pickup People Transport

dart package_changer.dart changePackage --applicationId 'com.enerren.inovapt.customer' --applicationName 'People Transport' --buildNumber 6 --buildName 1.1.6 --launcherAssets 'assets/inovapickup/inova_pickup_people_transport_launcher.png' --keystore angkutcustomer --assets angkut --route 'angkut/customer'

## angkut transporter

 dart package_changer.dart changePackage --applicationId 'com.enerren.angkut.transporter' --applicationName 'Angkut Transporter' --buildNumber 53 --buildName 1.3.53 --launcherAssets 'assets/angkut/transporter_launcher.png' --keystore angkuttransporter  --notificationIcon  angkut_notification_icon  --mapApiKey AIzaSyByt2IOztZscq6-dpO_3nGxVajuFOduDY0 --assets angkut --route 'angkut/transporter'

### Angkut Basic

 dart package_changer.dart changePackage --applicationId 'com.enerren.angkut.transporter' --applicationName 'Angkut Transporter' --buildNumber 45 --buildName 1.2.45 --launcherAssets 'assets/angkut/transporter_launcher.png' --keystore angkuttransporter   --assets angkut --route 'angkut/transporter'

### Inova Pickup Style

 dart package_changer.dart changePackage --applicationId 'com.enerren.inovapickup.transporter' --applicationName 'Inova Pickup Transporter' --buildNumber 11 --buildName 1.1.11 --launcherAssets 'assets/angkut/logo_inovatrack_transporter.png' --keystore angkuttransporter --assets angkut --route 'angkut/transporter'

### Inova Pickup People Transport

dart package_changer.dart changePackage --applicationId 'com.enerren.inovapt.transporter' --applicationName 'Transporter People Transport' --buildNumber 3 --buildName 1.1.3 --launcherAssets 'assets/inovapickup/inova_pickup_people_transport_transporter_launcher.png' --keystore angkuttransporter --assets angkut --route 'angkut/transporter'

## inovatrack customer

 dart package_changer.dart changePackage --applicationId 'com.enerren.inovatrack' --applicationName 'Inovatrack' --buildNumber 3 --buildName 3.1.0 --launcherAssets 'assets/inovatrack/logo_inovatrack.png' --keystore inovatrack
 --assets inovatrack --route 'inovatrack/customer'


## TMS Driver



### TMS General

dart package_changer.dart changePackage --applicationId 'com.enerren.tms.driver' --applicationName 'Tms Driver' --buildNumber 13 --buildName 1.1.14 --launcherAssets 'assets/tms/tms_driver_launcher_2.png' --keystore sieraddriver --notificationIcon tms_notification_icon --assets tms --route 'tms/driver'



### TMS Hacaca

dart package_changer.dart changePackage --applicationId 'com.enerren.hacaca.driver' --applicationName 'Hacaca Driver' --buildNumber 7 --buildName 1.2.7 --launcherAssets 'assets/tms/tms_driver_launcher_2.png' --keystore sieraddriver --notificationIcon tms_notification_icon --assets tms --route 'tms/driver'

### Uli Vaksin

dart package_changer.dart changePackage --applicationId 'com.enerren.ulivaksin.driver' --applicationName 'ULI Vaccine' --buildNumber 2 --buildName 1.1.2 --launcherAssets 'assets/uliVaksin/launcher_driver.png' --keystore sieraddriver --notificationIcon tms_notification_icon --assets ulivaksin --route 'tms/driver'



## TMS Customer

dart package_changer.dart changePackage --applicationId 'com.enerren.tms.customer' --applicationName 'TMS Customer' --buildNumber 11 --buildName 1.1.11 --launcherAssets 'assets/tms/tms_launcher_2.png' --keystore sieradcustomer --notificationIcon tms_notification_icon --assets tms --route 'tms/customer'


### Customer General

dart package_changer.dart changePackage --applicationId 'com.enerren.tms.customer' --applicationName 'TMS Customer' --buildNumber 10 --buildName 1.1.10 --launcherAssets 'assets/tms/tms_launcher_2.png' --keystore sieradcustomer --notificationIcon tms_notification_icon --assets tms --route 'tms/customer'



### Customer Hacaca

dart package_changer.dart changePackage --applicationId 'com.enerren.hacaca.customer' --applicationName 'Hacaca Customer' --buildNumber 7 --buildName 1.1.7 --launcherAssets 'assets/tms/tms_launcher_2.png' --keystore sieradcustomer --notificationIcon tms_notification_icon --assets tms --route 'tms/customer'







## TMS Transporter



### Transporter General

dart package_changer.dart changePackage --applicationId 'com.enerren.tms.transporter' --applicationName 'TMS Transporter' --buildNumber 21 --buildName 1.1.21 --launcherAssets 'assets/tms/tms_transporter_launcher.png' --keystore sieradtransporter --notificationIcon tms_notification_icon --assets tms --route 'tms/transporter'

### Transporter Hacaca

dart package_changer.dart changePackage --applicationId 'com.enerren.hacaca.transporter' --applicationName 'Hacaca Transporter' --buildNumber 8 --buildName 1.1.8 --launcherAssets 'assets/tms/tms_transporter_launcher_2.png' --keystore sieradtransporter --notificationIcon tms_notification_icon --assets tms --route 'tms/transporter'

### Transporter Uli Vaksin

dart package_changer.dart changePackage --applicationId 'com.enerren.ulivaksin.transporter' --applicationName 'TMS Transporter' --buildNumber 15 --buildName 1.1.15 --launcherAssets 'assets/uliVaksin/launcher_transporter_2.png' --keystore sieradtransporter --notificationIcon tms_notification_icon --assets ulivaksin --route 'tms/transporter'



## TMS Admin

dart package_changer.dart changePackage --applicationId 'com.enerren.tms.admin' --applicationName 'TMS Admin' --buildNumber 12 --buildName 1.1.12 --launcherAssets 'assets/tms/tms_transporter_launcher.png' --keystore sieradadmin --notificationIcon tms_notification_icon --assets tms --route 'tms/admin'



## InovaPickup



### InovaPickup Basic

dart package_changer.dart changePackage --applicationId 'com.enerren.inovapickup.customer' --applicationName 'Inova Pickup' --buildNumber 1 --buildName 1.1.1 --launcherAssets 'assets/inovapickup/inova_pickup_people_transport_launcher.png' --keystore angkutcustomer  --notificationIcon angkut_notification_icon  --assets inovapickup --route 'inovapickup/inovaPickupBasic'

fix some error in ios
rm -rf ios/Pods, rm ios/Podfile.lock
cd ios, pod cache clean --all
Reboot
pod repo update, pod install

sudo killall -STOP -c usbd
rm -rf <flutter_repo_directory>/bin/cache

