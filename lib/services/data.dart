class Data {
  int? id;
  String? itemCode;
  String? itemName;
  String? price;
  String? stock;

  Data({
    this.id,
    this.itemCode,
    this.itemName,
    this.price,
    this.stock,
  });

  factory Data.createData(Map<String, dynamic> object) {
    return Data(
      id: object['id'],
      itemCode: object['item_code'].toString(),
      itemName: object['item_name'].toString(),
      price: object['price'].toString(),
      stock: object['stock'].toString(),
    );
  }
}
