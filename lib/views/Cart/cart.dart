import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/cart.dart';
import 'package:mticketbar/services/cart_service.dart';
import 'package:mticketbar/services/sell_service.dart';
import 'package:mticketbar/services/user_service.dart';
import 'package:mticketbar/views/auth/login.dart';
import 'package:mticketbar/views/homepage/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
   bool _loading = true;
    bool _loadingbutton = false;
     int number = 0;
     String _selectedMethod = 'dinheiro';

  List<dynamic> _cartList = [];
  List<dynamic> _localList = [];

  List<String> list = <String>['Dinheiro', 'Cartao'];

  int userId = 0;

  var total = 0.0;

    Future<void> _pagar() async {

      setState(() {
      _loadingbutton = true;
    });
  
    var res = await createSell(userProfile.id, total,_selectedMethod);
    if(res.error == null){
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                 // ignore: use_build_context_synchronously
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.data}')
                  ));
                 
               }else{
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                 content: Text('${res.data}')
                  ));
               }
  }


    Future<void> retrieveCart()async{

    var totalretrive = 0.0;
    
    ApiResponse response = await getCart();
    
    SharedPreferences pref = await SharedPreferences.getInstance();

    print(pref.getInt('userid'));
    
 
   
    if(response.error == null){
      setState(() {
        _cartList = response.data as List<dynamic>;
        
      });
    }
    else if(response.error == unauthorized){
      logout().then((value)  {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const LoginPage()), (route) => false);
      });
    }
    else{
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 
   

    
    for(int i=0;i<_cartList.length;i++){
      CartModel cart = _cartList[i];
      totalretrive += cart.qtd * cart.productprice;
    }

    setState(() {
      total = totalretrive;
      number = _cartList.length;
      _loading = _loading ? !_loading : _loading;
    });

    
  }


 @override
  void initState() {

    // TODO: implement initState
    retrieveCart();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
     

    return _loading ? Padding(
      
      padding: const EdgeInsets.all(8),
    
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                          
                        ],
                      )),
                    ) : 
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Container(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            "Carrinho",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF3a3a3b),
                                fontWeight: FontWeight.w300),
                          ),
                          
                        ],
                      ),
                    ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child:  Text(
                              "Total: $total MT",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF3a3a3b),
                                  ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _cartList.length,
                            itemBuilder: (BuildContext context, int index){
                    
                              CartModel cart = _cartList[index];
                              return CartItem(
                              productName: cart.productname,
                              productPrice: cart.productprice,
                              productCartQuantity: cart.qtd.toString(),
                              idProduto: cart.id,);
                                    
                                    }
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Subtotal",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            '${total.toString()} MT',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const <Widget>[
                                          Text(
                                            "Taxa",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            '0 MT',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            '${total.toString()} MT',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                       const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: const Text(
                                          "Método pagamento",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xFF3a3a3b),
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),

                                      Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: const Text('Dinheiro'),
                                                leading: Radio<String>(
                                                  value: 'dinheiro',
                                                  groupValue: _selectedMethod,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedMethod = value!;
                                                    });
                                                     print(_selectedMethod);
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text('Cartão'),
                                                leading: Radio<String>(
                                                  value: 'cartao',
                                                  groupValue: _selectedMethod,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedMethod = value!;
                                                    });
                                                    print(_selectedMethod);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        !_loadingbutton ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            
                                           total != 0.0 ? ElevatedButton(
                                              onPressed: () {
                                               _pagar();
                                              },
                                             
                                              child: const Text(
                                                "Efectuar Venda",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    letterSpacing: 2.2,
                                                    color: Colors.white),
                                              ),
                                            ):
                                            ElevatedButton(
                                              onPressed: () {
                                               
                                              },
                                             
                                              child: const Text(
                                                "Não tem produto no carrinho",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    letterSpacing: 2.2,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ):Column(
                                          children: [
                                            CircularProgressIndicator(),
                                                        Text('  Efetuando a venda...')
                                          ],
                                        ),

                                      ],
                                    )
                                  ),
                        ],
                      ),
                    );
  }
} 

class CartItem extends StatelessWidget {
  String productName;
  int productPrice;
  String productCartQuantity;
  int idProduto;
 

  CartItem({
    Key ?key,
    required this.productName,
    required this.productPrice,
    required this.productCartQuantity,
    required this.idProduto,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    
    var qtd = int.parse(productCartQuantity);
    var price = productPrice;
    var tot = qtd*price;
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xFFfae3e2).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ]),
      child: Card(
          color: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Center(
                      child: Image(image: ExactAssetImage('assets/images/logo.png'))
                     
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                    
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              productName,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$productPrice MT',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                      
                              alignment: Alignment.topLeft,
                              child: Text('Quantidade: $productCartQuantity',
                              style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF3a3a3b),
                                          fontWeight: FontWeight.w400),)
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                    Container(
                      
                      alignment: Alignment.topLeft,
                      child: Text('Total: $tot MT',style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),)
                    )
                          ],
                        ),
                        
                        const SizedBox(
                        width: 15,
                      ),
                        
                        InkWell(
                          onTap: ()=>showDialog(context: context , builder: (BuildContext context)=>AlertDialog(
                            title: const Text('Confirmar exclusão'),
                            content: Text('Deseja apagar o produto "$productName" do seu carrinho?'),
                            actions: [
                              TextButton(
                                onPressed: ()async{
                                 
                                var res = await deleteCart(idProduto);
                                if(res.error == null){
                                  
                                   Navigator.pop(context);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                                  

                                 

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => MyCart()),
                                  // );
                                  
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('${res.data}')
                                    ));
                                  
                                }else{
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('${res.error}')
                                    ));
                                }

                              }, 
                              child: const Text('Sim')),

                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Não'))
                            ],
                          )),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: const [
                                Icon(Icons.delete),
                                Text('Apagar')
                              ],
                            )
                          ),
                        )
                      ],
                    ),
                    
                  ],
                )
              ],
            ),
          )),
    );
  }
}