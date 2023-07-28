class ProductModel{
  int id;
  int sellPrice;
  int buyPrice;
  int qtd;
  int eventId;
  String name;
  String created_at;
  String updated_at;



 


  ProductModel({
    required this.id,
    required this.buyPrice,
    required this.qtd,
    required this.eventId,
    required this.sellPrice,
    required this.name,
    required this.created_at,
    required this.updated_at,

   
  });


  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'],
      buyPrice: json['buy_price'],
      eventId: json['event_id'],
      qtd: json['qtd'],
      sellPrice: json['sell_price'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],

      
    );
  }
}