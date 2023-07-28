import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/product_model.dart';
import 'package:mticketbar/services/cart_service.dart';
import 'package:mticketbar/services/product_service.dart';
import 'package:mticketbar/services/user_service.dart';
import 'package:mticketbar/views/auth/login.dart';

class ProductDetail extends StatefulWidget {
  int id;
  ProductDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  List<dynamic> _productList = [];



  bool _loading = true;

  bool _loadingbutton = false;
  late int productid;

  late ProductModel product;
  int qtd = 1;
  
  
  Future<void> retrieveProduct()async{

  
     
   
    ApiResponse response = await getProduct(widget.id);

    
  
    setState(() {
      productid = widget.id;
    }); 
  
      setState(() {
        _productList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
      product = _productList[0];
     
     
   
    if(response.error == null){
      setState(() {
        _productList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        
      });
      product = _productList[0];
    
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


  Future<void> addCart() async {
    
    setState(() {
      _loadingbutton = true;
    });
   
   var res = await createCart(userProfile.id, widget.id, qtd);

              if(res.error == null){
                Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.data}')
                  ));
                 
               }else{
                Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.data}')
                  ));
               }


  }
   @override
  void initState() {
    // TODO: implement initState
    retrieveProduct();


    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 72, 72, 72),
        elevation: 0,
        title: Row(
          children: [
            Container(
            margin: const EdgeInsets.only(
              top: 10.0,
              ),

            width: 40,
            height: 40,
            decoration:  const BoxDecoration(
            image:  DecorationImage(
                image:  ExactAssetImage('assets/images/logo.png'),
                fit: BoxFit.scaleDown,
                ),
            )),
            const Text(
          "Detalhes do Produto",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: _loading ? Padding(padding: const EdgeInsets.all(2),
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                          
                        ],
                      )),
                                      ) : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Text('Nome: ',
                                          style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                                Text('${product.name}',
                                          style: TextStyle(
                                                fontSize: 18.0,

                                                ))
                                            ],
                                          ),
                                          ),
                                          Padding(padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Text('Preço: ',
                                          style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                                Text('${product.sellPrice} MT',
                                          style: TextStyle(
                                                fontSize: 18.0,

                                                ))
                                            ],
                                          ),
                                          ),
                                          Padding(padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Text('Evento: ',
                                          style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                                Text(userProfile.event_name,
                                          style: TextStyle(
                                                fontSize: 18.0,

                                                ))
                                            ],
                                          ),
                                          ),
                                          Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !_loadingbutton ? IconButton(
            onPressed: () {
              if(qtd > 1){
                setState(() {
                 qtd -=1; 
                });

              }
             
         
            },
            icon: Icon(Icons.remove),
            color: Colors.black,
            iconSize: 30,
          ):Container(),
          !_loadingbutton ? InkWell(
            onTap: (){

              addCart();
              /*print('object');
               var res = await createCart(1, widget.id, qtd);

               if(res.error == null){
                 Navigator.push(context, ScaleRoute(page: FoodOrderPage()));
               }*/
              
              // Navigator.push(context, ScaleRoute(page: FoodOrderPage()));
            },
            child: Container(
              width: 200.0,
              height: 45.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(3, 175, 244, 5),
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'Adicionar $qtd',
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ):Column(
            children: [
              CircularProgressIndicator(),
                          Text('  Adicionando ao carrinho...')
            ],
          ),
          !_loadingbutton ? IconButton(
            onPressed: () {
              
                setState(() {
                qtd+=1;
              });
              
              
              
             
            },
            icon: const Icon(Icons.add),
            color: const Color.fromRGBO(3, 175, 244, 5),
            iconSize: 30,
          ):Container(),
        ],
      ),
    )
                                        ],
                                      ),
      )
    );
    

  }
}