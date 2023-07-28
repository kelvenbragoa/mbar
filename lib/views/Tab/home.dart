import 'package:flutter/material.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/home.dart';
import 'package:mticketbar/services/home.dart';
import 'package:mticketbar/services/user_service.dart';
import 'package:mticketbar/views/auth/login.dart';
import 'package:mticketbar/views/homepage/_home.dart';
import 'package:mticketbar/views/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<dynamic> homeDashboard = [];
    bool _loading = true;
    late Home home;

    Future<void> retrieveData()async{

    
    
    ApiResponse response = await getHomeData(userProfile.id);

    if(response.error == null){
      setState(() {
        homeDashboard = response.data as List<dynamic>;
        home = homeDashboard[0];
         _loading = _loading ? !_loading : _loading;
      });

      

  

    }else if(response.error == unauthorized){
      logout().then((value)  {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const LoginPage()), (route) => false);
      });
    }else{
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 

    

   

  }
  @override
  void initState() {
    // TODO: implement initState
     retrieveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
        child: Column(
          children:  <Widget>[
            
             const Text(
            ' Mticket Bar',
            style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10.0,
              ),

            width: 100.00,
            height: 250.00,
            decoration:  BoxDecoration(
            image:  DecorationImage(
                image:  ExactAssetImage('assets/images/logo.png'),
                fit: BoxFit.scaleDown,
                ),
            )),

            // ElevatedButton(
            //   onPressed: (){
            //       Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) =>  HomePagePrint(id:4)),
            //             );
            //   }, 
            //   child: Text('Print')),

             Text(
            userProfile.event_name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Icons.location_on,
                    size: 16.0,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  userProfile.date,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  AllTickets()),
                    //   );
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                              Icons.shopping_bag,
                              size: 25.0,
                              color: theme.primaryColor
                            ),
                      Text(
                        'Produtos',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: theme.primaryColor,
                        ),
                      ),
                        ],
                      ),
                      _loading ? Padding(padding: const EdgeInsets.all(8),
                      child: Center(child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          
                        ],
                      )),
                    ) :
                      Text(
                        '${home.products}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  DoneTickets()),
                    //   );
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                              Icons.shopping_cart,
                              size: 25.0,
                              color: Colors.green
                            ),
                      Text(
                        'Carrinho',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.green,
                        ),
                      ),
                        ],
                      ),
                      _loading ? Padding(padding: const EdgeInsets.all(8),
                      child: Center(child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          
                        ],
                      )),
                    ) :
                      Text(
                        '${home.carts}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  PendingTickets()),
                    //   );
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                              Icons.list,
                              size: 25.0,
                              color: Colors.amber[600]
                            ),
                      Text(
                        'Vendas',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.amber[600],
                        ),
                      ),
                        ],
                      ),
                      _loading ? Padding(padding: const EdgeInsets.all(8),
                      child: Center(child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          
                        ],
                      )),
                    ) :
                      Text(
                        '${home.sells}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 5.0,
            ),
            child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color.fromARGB(255, 224, 224, 224),
                      ))),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.supervised_user_circle,
                            size: 25.0,
                            color: theme.primaryColor
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Text(
                              'Barman: '+userProfile.name,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color.fromARGB(255, 224, 224, 224),
                      ))),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            size: 25.0,
                            color: theme.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Text(
                              'Telefone: '+userProfile.mobile,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 223, 222, 222),
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.assignment,
                            size: 25.0,
                            color: theme.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Text(
                              'Usuário: '+userProfile.user,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                   
                    InkWell(
                      onTap: (){
                        showDialog(context: context , builder: (BuildContext context)=>AlertDialog(
                            title: const Text('Sair da aplicação'),
                            content: Text('Deseja realmente sair da aplicação?'),
                            actions: [
                              TextButton(
                                onPressed: ()async{
                                 SharedPreferences pref = await SharedPreferences.getInstance();
                                 pref.remove('userid');
                               
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Onboarding()));

                              }, 
                              child: const Text('Sim')),

                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Não'))
                            ],
                          ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 218, 217, 217),
                            ),
                          ),
                        ),
                        child: Row(
                          children: const <Widget> [
                            Icon(
                              Icons.power_settings_new,
                              size: 25.0,
                              color: Colors.red
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: Text(
                                'Sair',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            )

          ],
        ),
      );
  }
}