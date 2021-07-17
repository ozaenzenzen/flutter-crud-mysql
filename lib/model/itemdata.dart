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

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['price'] = this.price;
    data['stock'] = this.stock;
    return data;
  }
}
