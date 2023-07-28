import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/sell.dart';
import 'package:mticketbar/models/sell_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';




Future<ApiResponse> getSells () async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<SellModel> _sellList =[];
  try{
   
    
    final response = await http.get(
      Uri.parse('${sellBarURL}/${userProfile.id}'),
      headers: {'Accept':'application/json'}
    );


   
    var values = jsonDecode(response.body)['sells'];
    // print(values);



    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            _sellList.add(SellModel.fromJson(map));
             
           
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = _sellList;
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



Future<ApiResponse> createSell (int userid, double total, String method) async {





ApiResponse apiResponse = ApiResponse();
  try {
   
    final response = await http.post(
      Uri.parse(sellcreateBarURL),
      headers: {
      'Accept': 'application/json',
      
    }, body: {
      'user_id': '$userid',
      'total': '$total',
      'event_id': '${userProfile.event_id}',
      'method':'$method',
      'ref':'$method'
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
      case 403:
        apiResponse.data = jsonDecode(response.body)['message'];
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



Future<ApiResponse> getSell(id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<SellDetailModel> productList =[];



  try{
    
    
  
    final response = await http.get(
      Uri.parse('$sellDetailBarURL/$id'),
      headers: {'Accept':'application/json',
     }
    );

    

    var values = jsonDecode(response.body)['selldetail'];


   
     
    


    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            productList.add(SellDetailModel.fromJson(map));

           
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

Future<ApiResponse> verifyreceipt (int id) async {





ApiResponse apiResponse = ApiResponse();
  try {
   
    final response = await http.get(
      Uri.parse('$verifyreceiptURL/$id/user/${userProfile.id}'),
      headers: {
      'Accept': 'application/json',
      
    });






    

    
    

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


