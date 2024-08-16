import 'package:enerren/util/ResourceUtil.dart';

extension ResourceUtilExtention on ResourceUtil {
  ResourceUtil peopleTransportId() {
    this.pickUpLocation = "Lokasi Penjemputan";
    this.orderStatus = "Status Order";
    this.allowance = "Biaya Perjalanan";
    this.loadingDetail = "Detail Pickup";
    this.credit = "Penerimaan";
    this.debt = "Pembayaran";
    this.extraPeople = "Total Penumpang";
    this.itemType = "Keperluan";
    this.deliverySchedule = "Jadwal Penjemputan";
    this.goodsDetail = "Detail";
    this.instantCourier = "Instant Pick Up";
    this.unloadingDetail = "Detail Drop";
    this.tackOrder = "Lacak Perjalanan";
    this.warningVehicleType =
        "Pastikan jenis kendaraan sesuai dengan kebutuhan anda";
    this.thereIsNoItemList = "Tidak ada daftar penumpang";
    this.checkingGoods = "Pengecekan Penumpang";
    this.thereIsNoItemListPleaseClickThePlusSignBelow =
        "Tidak ada daftar penumpang\n\nSilahkan klik tanda “Tambah“ dibawah !";
    this.itemName = "Name Penumpang";
    this.photoOfGoods = "Foto Penumpang";
    this.goodsReceipt = "Menurunkan Penumpang";
    this.detailShipment = "Detail Perjalanan";
    this.equipmentHome = "Contoh : Perjalanan Dinas";
    this.shipped = "Diantar";
    this.receiverName = "Nama";
    return this;
  }

  ResourceUtil peopleTransportEn() {
    this.extraPeople = "Total Passenger";
    this.itemType = "Necessary";
    this.deliverySchedule = "Pick Up Schedule";
    this.goodsDetail = "Detail";
    this.instantCourier = "Instant Pick Up";
    this.unloadingDetail = "Detail Drop";
    this.tackOrder = "Track Trips";
    this.warningVehicleType = "Make sure the type of vehicle fits your needs";
    this.thereIsNoItemList = "There Is No Passenger List";
    this.checkingGoods = "Passenger Checking";
    this.thereIsNoItemListPleaseClickThePlusSignBelow =
        "There is no passenger list \n\nPlease click the Plus sign below!";
    this.itemName = "Passenger Name";
    this.photoOfGoods = "Passengers Photo";
    this.goodsReceipt = "Drop off Passengers";

    this.detailShipment = "Trip Detail";
    this.equipmentHome = "Example : Meeting";
    this.shipped = "Delivered";
    this.receiverName = "Name";
    return this;
  }
}
