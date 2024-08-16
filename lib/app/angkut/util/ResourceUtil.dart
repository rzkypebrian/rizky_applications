import 'package:enerren/util/ResourceUtil.dart';

extension ResourceUtilExtention on ResourceUtil {
  ResourceUtil angkutId() {
    this.pickUpLocation = "Lokasi Penjemputan";
    this.orderStatus = "Status Order";
    this.allowance = "Biaya Perjalanan";
    this.loadingDetail = "Detail Pickup";
    this.credit = "Penerimaan";
    this.debt = "Pembayaran";
    return this;
  }
}
