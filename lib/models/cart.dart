class CartModel {
  int id;
  int userid;
  int productid;
  int qtd;
  String productname;
  int productprice;


 


  CartModel({
    required this.id,
    required this.userid,
    required this.productid,
    required this.qtd,
    required this.productname,
    required this.productprice
   
  });


  factory CartModel.fromJson(Map<String, dynamic> json){
    return CartModel(
      id: json['id'],
      userid: json['user_id'],
      productid: json['product_id'],
      qtd: json['qtd'],
      productname: json['product']['name'],
      productprice: json['product']['sell_price'],
      
      
    );
  }
}