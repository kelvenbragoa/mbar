
class Home{
  int products;
  int carts;
  int sells;

 

 


  Home({
    required this.products,
    required this.carts,
    required this.sells,



   
  });


  factory Home.fromJson(Map<String, dynamic> json){
    return Home(
      products: json['products'],
      carts: json['carts'],
      sells: json['sells'],

    );
  }
}