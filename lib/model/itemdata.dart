class ItemData {
  int? id;
  String? itemCode;
  String? itemName;
  String? price;
  String? stock;

  ItemData({
    this.id,
    this.itemCode,
    this.itemName,
    this.price,
    this.stock,
  });

  factory ItemData.fromJson(Map<String, dynamic> object) {
    return ItemData(
      id: object['id'],
      itemCode: object['item_code'].toString(),
      itemName: object['item_name'].toString(),
      price: object['price'].toString(),
      stock: object['stock'].toString(),
    );
  }
}
