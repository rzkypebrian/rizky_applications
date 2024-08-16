import 'package:enerren/model/DropDowns.dart';
import 'package:enerren/util/SystemUtil.dart';

class IncomeAndOutcomeModel {
  String orderNumber;
  DateTime dateTime;
  String customerName;
  DropDowns statusPayment;
  double total;
  double travelExpense;
  double helpPeople;
  double miscellaneousExpense;
  double insurangFee;
  double totalPaidByCustomer;
  double serviceFee;
  double totalPaidToTransporter;
  double totalPaidToCustomer;
  int typeProcess;

  IncomeAndOutcomeModel({
    this.customerName,
    this.orderNumber,
    this.dateTime,
    this.total,
    this.statusPayment,
    this.travelExpense,
    this.helpPeople,
    this.miscellaneousExpense,
    this.insurangFee,
    this.totalPaidByCustomer,
    this.serviceFee,
    this.totalPaidToTransporter,
    this.typeProcess = 1,
    this.totalPaidToCustomer,
  });

  static List<IncomeAndOutcomeModel> listOrderModelDummy = [
    IncomeAndOutcomeModel(
      orderNumber: "order 001",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 1, name: System.data.resource.paidOff),
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 002",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 1, name: System.data.resource.paidOff),
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 003",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 1, name: System.data.resource.paidOff),
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 004",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 1, name: System.data.resource.paidOff),
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 005",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 1, name: System.data.resource.paidOff),
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 001",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 2, name: System.data.resource.notYetPaidOff),
      typeProcess: 2,
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 002",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 2, name: System.data.resource.notYetPaidOff),
      typeProcess: 2,
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 003",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 2, name: System.data.resource.notYetPaidOff),
      typeProcess: 2,
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 004",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 2, name: System.data.resource.notYetPaidOff),
      typeProcess: 2,
    ),
    IncomeAndOutcomeModel(
      orderNumber: "order 005",
      dateTime: DateTime.now(),
      customerName: "Pt abc",
      total: 1000000,
      statusPayment: DropDowns(id: 2, name: System.data.resource.notYetPaidOff),
      typeProcess: 2,
    ),
  ];
}
