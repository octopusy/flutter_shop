import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int totalCounts;
  double totalMoney;
  dynamic products;



  Cart({this.totalCounts, this.totalMoney, this.products});


  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$CartToJson(this);
}



//"skuId": 2001213,
//"amount": 2,
//"price": 37.33,
//"freight": 0

@JsonSerializable()
class CartProduct {
  String skuId;

  int amount;
  double price;
  int freight;
  String norms;
  String name;
  String url;


  CartProduct({this.skuId, this.amount, this.price,this.freight, this.norms,this.name,this.url});


  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory CartProduct.fromJson(Map<String, dynamic> json) => _$CartProductFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$CartProductToJson(this);

}