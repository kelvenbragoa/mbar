import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/cart.dart';
import 'package:mticketbar/models/product_model.dart';



Future<ApiResponse> getCart () async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;

  List<CartModel> _cartList =[];
  try{
  
    
    final response = await http.get(
      Uri.parse('$cartBarURL/${userProfile.id}'),
      headers: {'Accept':'application/json',}
    );

    var values = jsonDecode(response.body)['cart'];


    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            _cartList.add(CartModel.fromJson(map));
             
           
          }}
    }
    

       
  
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = _cartList;
        apiResponse.data as List<dynamic>;
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
        break;
      
      case 401:
       
       apiResponse.error = unauthorized;
       break;


      default:
      apiResponse.error = somethingwentwrong;
    }
  }catch (e){

    apiResponse.error = serverError;

  }
//funcional
  //return data;\

  return apiResponse;
}


Future<ApiResponse> createCart(int userid, int productid, int qtd) async {
ApiResponse apiResponse = ApiResponse();
  try {
   
    final response = await http.post(
      Uri.parse(cartCreateBarURL),
      headers: {
      'Accept': 'application/json',
      
    }, body: {
      'user_id': '$userid',
      'product_id': '$productid',
      'event_id': '${userProfile.event_id}',
      'qtd': '$qtd',
    } );

    
    

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        // apiResponse.error = errors[errors.keys.elementAt(0)][0];
        apiResponse.error = errors.toString();
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        print(response.body);
        apiResponse.error = somethingwentwrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Delete post
Future<ApiResponse> deleteCart(int cartId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
   
    final response = await http.delete(Uri.parse('$cartDeleteBarURL/$cartId/user/${userProfile.id}'),
    headers: {
      'Accept': 'application/json',
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingwentwrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


