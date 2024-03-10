class Invoice {
  String? invoiceNumber;
  ClientInfo? clientinfo;
  List<InvoiceItem>? items;

  Invoice({this.invoiceNumber, this.clientinfo, this.items});
}

class InvoiceItem {
  String? itemname;
  double? quantity;
  double? price;

  InvoiceItem({this.itemname, this.quantity, this.price});
}

class ClientInfo {
  String? customerName;
  String? address;
  int? phone;

  ClientInfo({this.customerName, this.address, this.phone});
}
