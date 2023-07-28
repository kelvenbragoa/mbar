class SellModel {
  int id;
  int total;
  String method;
  String ref;
  int status;
  String created_at;
  
 

 


  SellModel({
    required this.id,
    required this.total,
    required this.method,
    required this.ref,
    required this.status,
    required this.created_at,
    
   
  });


  factory SellModel.fromJson(Map<String, dynamic> json){
    return SellModel(
      id: json['id'],
      total: json['total'],
      method: json['method'],
      ref: json['ref'],
      status: json['status'],
      created_at: json['created_at'],
      
    );
  }
}