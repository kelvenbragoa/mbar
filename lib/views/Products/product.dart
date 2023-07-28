import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/product_model.dart';
import 'package:mticketbar/services/product_service.dart';
import 'package:mticketbar/services/user_service.dart';
import 'package:mticketbar/views/Products/productdetail.dart';
import 'package:mticketbar/views/auth/login.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  List<dynamic> _productList = [];




  bool _loading = true;
 

  
  
  Future<void> retrieveAllProducts()async{

 

    
    ApiResponse response = await getAllProducts();
  
 
  
      setState(() {
        _productList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
     
     
   
    if(response.error == null){
      setState(() {
        _productList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    
    }
    else if(response.error == unauthorized){
      logout().then((value)  {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      });
    }
    else{
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 

   
   
  

    

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllProducts();
  }
  @override
  Widget build(BuildContext context) {
    return  _loading ? Padding(
      
      padding: const EdgeInsets.all(8),
    
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                          
                        ],
                      )),
                    ) : Padding(
      padding: const EdgeInsets.fromLTRB(10, 24, 10, 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10), 
          itemCount: _productList.length,
        itemBuilder: (context, index){
          ProductModel product = _productList[index];
          return InkWell(
          onTap: () {
            Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProductDetail(id:product.id)),
                        );
           
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: ExactAssetImage('assets/images/background.png'),fit: BoxFit.fill,opacity: 0.2),
            color: const Color.fromRGBO(3, 175, 244, 5),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x3600000F),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(10),),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
              child:  Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text('${product.sellPrice} MT',textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),),
                       Icon(Icons.remove_red_eye_outlined,color: Colors.white,)
              ],
             ),
           )
              ],
            )
            
          ),
        );
            }),
    );
    
    // GridView.count(
    //     primary: false,
    //     padding: const EdgeInsets.all(20),
    //     crossAxisSpacing: 10,
    //     mainAxisSpacing: 10,
    //     crossAxisCount: 3,
    //     children: [
    //       InkWell(
    //         onTap: () {},
    //         child: Container(
    //           decoration: BoxDecoration(
    //             image: DecorationImage(image: ExactAssetImage('assets/images/background.png'),opacity: 0.2),
    //           color: const Color.fromRGBO(3, 175, 244, 5),
    //           boxShadow: [
    //             BoxShadow(
    //               blurRadius: 4,
    //               color: Color(0x3600000F),
    //               offset: Offset(0, 2),
    //             )
    //           ],
    //           borderRadius: BorderRadius.circular(10),),
              
    //           child: Center(
    //             child: const Text(
    //               '2M',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 20),
    //             ),
    //           ),
              
    //         ),
    //       ),
          
          
    //     ],
    //   );
  }
}