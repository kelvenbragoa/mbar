class SellDetailModel {
  int id;
  int qtd;
  int sell_id;
  int status;
  String product_name;
  var total;
  var price;
  String method;
  int totalsell;

 
  
 

 


  SellDetailModel({
    required this.id,
    required this.qtd,
    required this.sell_id,
    required this.product_name,
    required this.total,
    required this.method,
    required this.price,
    required this.totalsell,
    required this.status,

  });


  factory SellDetailModel.fromJson(Map<String, dynamic> json){
    return SellDetailModel(
      id: json['id'],
      qtd: json['qtd'],
      sell_id: json['sell_id'],
      product_name: json['product']['name'],
      total: json['total'],
      price: json['price'],
      method:json['sell']['method'],
      totalsell:json['sell']['total'],
      status:json['sell']['status']


    );
  }
}