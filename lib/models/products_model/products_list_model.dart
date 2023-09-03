class ProductsList {
  String itemNumber;
  String itemName;
  double itemPrice;
  double itemSales;
  ProductsList(
      {required this.itemName,
      required this.itemNumber,
      required this.itemPrice,
      required this.itemSales});

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
        itemName: json['itemName'] as String,
        itemNumber: json['itemNumber'] as String,
        itemPrice: (json['itemPrice'] as num).toDouble(),
        itemSales: (json['itemSales'] as num).toDouble(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'itemNumber': itemNumber,
        'itemName': itemName,
        'itemPrice': itemPrice,
        'itemSales': itemSales,
      };
}
