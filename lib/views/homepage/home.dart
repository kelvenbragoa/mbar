import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mticketbar/views/Cart/cart.dart';
import 'package:mticketbar/views/Cash/cash.dart';
import 'package:mticketbar/views/Products/product.dart';
import 'package:mticketbar/views/Sells/sells.dart';
import 'package:mticketbar/views/Tab/home.dart';
import 'package:mticketbar/views/scanner/scanner.dart';




class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return const MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
    const HomeTab(),
    const Cash(),
    const Product(),
    const Scanner(),
    const Cart(),
    
    

    const Sells()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            decoration:  BoxDecoration(
            image:  DecorationImage(
                image:  ExactAssetImage('assets/images/logo.png'),
                fit: BoxFit.scaleDown,
                ),
            )),
            const Text(
          "MTicket Bar",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
          ],
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: const Icon(
        //         Icons.camera_enhance,
        //         color: Color(0xFF3a3737),
        //       ),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => Scanner()),
        //         );
               
        //         })
        // ], systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),

           
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Cash',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Produtos',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),
          ),

           
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'QR CODE',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),

            
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Vendas',
            // backgroundColor: Color.fromARGB(255, 245, 245, 245),

            
          ),
          
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        
        
        elevation: 10.0,
        // unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),

        onTap: _onItemTapped,
      ),
    );
  }
}

