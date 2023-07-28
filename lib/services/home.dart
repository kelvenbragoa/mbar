import 'package:http/http.dart' as http;
import 'package:mticketbar/constants.dart';

import 'dart:convert';

import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/home.dart';





Future<ApiResponse> getHomeData (int? id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;





  List<Home> home =[];

  try{
   
    
    final response = await http.get(
      Uri.parse('$homeBarURL/$id'),

     
      headers: {'Accept':'application/json'}
    );

  
    var values = jsonDecode(response.body)['home'];

    

      
   
   

    
  
    if(values.length>0){
    
       for(int i=0;i<values.length;i++){

          
           if(values[i]!=null){

            
             Map<String,dynamic> map = values[i];
          
             home.add(Home.fromJson(map));
           
             
           
           }}
    }

    
    
   
   
    switch (response.statusCode) {
      case 200:
        apiResponse.data = home;
        apiResponse.data as List<dynamic>;
  
        
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

  return apiResponse;
}