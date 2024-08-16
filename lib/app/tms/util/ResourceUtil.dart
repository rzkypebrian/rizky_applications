import 'package:enerren/util/ResourceUtil.dart';

extension ResourceUtilExtention on ResourceUtil {
  ResourceUtil tmsId() {
    this.pickUpLocation = "Lokasi Penjemputan";
    this.orderStatus = "Status Order";
    this.allowance = "Biaya Perjalanan";
    this.loadingDetail = "Detail Muat";
    this.credit = "Penerimaan";
    this.debt = "Pembayaran";
    this.loading = "Muat";
    this.pickUp = "Muat";
    return this;
  }
}
