import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/product_model.dart';


Future<ApiResponse> getAllProducts() async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<ProductModel> productList =[];


  try{
    
    
    final response = await http.get(
      Uri.parse('$productsBarURL/${userProfile.event_id}'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['products'];

   
     
    


    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            productList.add(ProductModel.fromJson(map));

           
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = productList;
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


Future<ApiResponse> getProduct(id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<ProductModel> productList =[];



  try{
    
    
  
    final response = await http.get(
      Uri.parse('$productBarURL/$id'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['product'];


     
    


    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            productList.add(ProductModel.fromJson(map));

           
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = productList;
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



