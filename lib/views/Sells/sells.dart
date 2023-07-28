import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/sell.dart';
import 'package:mticketbar/services/sell_service.dart';
import 'package:mticketbar/services/user_service.dart';
import 'package:mticketbar/views/Sells/sellsdetail.dart';
import 'package:mticketbar/views/auth/login.dart';

class Sells extends StatefulWidget {
  const Sells({Key? key}) : super(key: key);

  @override
  State<Sells> createState() => _SellsState();
}

class _SellsState extends State<Sells> {
   bool _loading = true;
    List<dynamic> _sellList = [];
    
      Future<void> retrieveSell() async{

    // userId = await getUserId();
    //var _sellList = await getCategories();
    ApiResponse response = await getSells();
    
    
    /*
    setState(() {
        _sellListT = _sellList;
        _loading = _loading ? !_loading : _loading;
      });*/
   
    if(response.error == null){
      setState(() {
        _sellList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if(response.error == unauthorized){
      logout().then((value)  {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      });
    }
    else{
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 
  }

  @override
  void initState() {
    // TODO: implement initState
    retrieveSell();
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
                    ) : Column(
                      children: [
                         Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          "Vendas",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3a3a3b),
                              fontWeight: FontWeight.w300),
                        ),
                        
                      ],
                    ),
                    ),

                    Expanded(
                    child: ListView.builder(
                      itemCount: _sellList.length,
                      itemBuilder: (BuildContext context, int index){
                        var status='';
                          var statusSell='';
                          
                           SellModel sell = _sellList[index];
                          String formattedDate = DateFormat('MMM d, HH:mm ').format(DateTime.parse(sell.created_at));
                          if(sell.status == 0){status = 'Inválido';}
                          if(sell.status== 1){status = 'Válido';}
                          return InkWell(
                            onTap: () {
                                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  SellsDetails(id:sell.id)),
                        );
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => APIDetailView(data[index])),
                              );*/
                            },
      
                            child: Card(
                              child: ListTile(                //return new ListTile(
                                 
                                 
                                  title: sell.status==1 ? Text('#${sell.id} - ${formattedDate} - $status' ,style: TextStyle(color: Color.fromARGB(255, 3, 123, 7)),) : Text('#${sell.id} - ${formattedDate} - $status' ,style: TextStyle(color: Color.fromARGB(255, 244, 60, 60)),),
                                  subtitle: Text('Total: ${sell.total} MT'),
                                  trailing: Icon(Icons.arrow_right),
                                  
                            
                              ),
                            ),
      
                          );

                          
                      }
                      )
                      )
                      ],
                    );
  }
}