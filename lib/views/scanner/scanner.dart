import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mticketbar/views/Sells/sellsdetail.dart';




class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  String _scanBarcode = 'Desconhecido';
  int status = 0;
  int errorcode = 0;
  String barcode = '' ;
  
  @override
  void initState() {
    super.initState();
  }






  Future<void> scanQR() async {
    int actual_status = 0;
    int actual_error = 0;
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // barcodeScanRes
    // if(finalvalue.idEvento == userProfile.event_id){
    //   actual_status = 1;
    //   actual_error = 0;
    // }else{
    //   actual_error = 1;
    // }


  
    setState(() {
      status = 1;
      errorcode = actual_error;
      _scanBarcode = barcodeScanRes;

      barcode = barcodeScanRes;
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // ElevatedButton(
                        //     onPressed: () => scanBarcodeNormal(),
                        //     child: Text('Start barcode scan')),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            ),

                          width: 250.00,
                          height: 250.00,
                          decoration:  const BoxDecoration(
                          image:  DecorationImage(
                              image:  ExactAssetImage('assets/images/qrcode.jpg'),
                              fit: BoxFit.scaleDown,
                              ),
                          )),
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: const Text('Iniciar Scan QRCode')),
                        // ElevatedButton(
                        //     onPressed: () => startBarcodeScanStream(),
                        //     child: Text('Start barcode scan stream')),
                        
                        status == 0 ?
                         Container(
                           child: Text('Faça o scan do recibo do bar',
                              style: TextStyle(fontSize: 18)),
                         ):
                        Column(
                          children: [
                            Container(
                           child: Text('Recibo # $barcode',
                              style: TextStyle(fontSize: 18)),
                         ),
                            barcode != '-1' ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 27, 230, 37)),
                                ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  SellsDetails(id:int.parse(barcode) )),
                                );
                              }, 
                              child: const Text('Clique aqui para confirmar')) : Container()
                            // Text(ticket.evento,
                            // style: const TextStyle(fontSize: 18)),
                            //  Text(ticket.nome,
                            // style: const TextStyle(fontSize: 18)),
                            //  Text(ticket.ticket,
                            // style: const TextStyle(fontSize: 18)),
                            // Text('#${ticket.id}',
                            // style: const TextStyle(fontSize: 18)),
                            // ticket.status == 0 ? Text('Bilhete já foi validado',
                            // style: const TextStyle(fontSize: 18,color: Colors.green)):
                            // Text('Bilhete pendente',
                            // style: const TextStyle(fontSize: 18,color: Color.fromARGB(255, 255, 179, 0))),

                            // ticket.status == 1 ? ElevatedButton(
                            //   style: ButtonStyle(
                            //       backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 27, 230, 37)),
                            //     ),
                            //   onPressed: (){
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) =>  TicketDetail(id:ticket.id)),
                            //     );
                            //   }, 
                            //   child: const Text('Clique para confirmar')) : ElevatedButton(
                            //     style: ButtonStyle(
                            //       backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 240, 74, 62)),
                            //     ),
                            //   onPressed: (){
                                
                            //   }, 
                            //   child: const Text('Nenhuma ação disponível'))
                          ],
                        )
                        

                        
                      ]));
            }));
  }
}