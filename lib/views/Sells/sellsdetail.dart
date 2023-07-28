import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/models/sell.dart';
import 'package:mticketbar/models/sell_detail.dart';
import 'package:mticketbar/services/sell_service.dart';
import 'package:mticketbar/services/user_service.dart';
import 'package:mticketbar/views/auth/login.dart';
import 'package:mticketbar/views/homepage/home.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class SellsDetails extends StatefulWidget {
  int id;
  SellsDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<SellsDetails> createState() => _SellsDetailsState();
}

class _SellsDetailsState extends State<SellsDetails> {


  List<dynamic> _sellDetailsList = [];
  late SellDetailModel selldetailmodel;




  bool _loading = true;
  bool _loadingcentral = false;

  
  
  Future<void> retrieveSellDetails()async{

 

    
    ApiResponse response = await getSell(widget.id);
  
 
  
      setState(() {
        _sellDetailsList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
     
     
   
    if(response.error == null){
      setState(() {
        _sellDetailsList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });

      selldetailmodel = _sellDetailsList[0];

    
    
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

   
   
  

    

  }

  void verifyReceipt() async {

      setState(() {
        _loadingcentral = true;
      });
    var res = await verifyreceipt(widget.id);
   
              if(res.error == null){
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                 // ignore: use_build_context_synchronously
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.data}')
                  ));
                 
               }else{

                Navigator.pop(context);
                 // ignore: use_build_context_synchronously
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.data}')
                  ));
               }
  }

@override
  void initState() {
    // TODO: implement initState
    retrieveSellDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
        backgroundColor: const Color.fromARGB(255, 72, 72, 72),
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
          "Detalhes do Venda",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
          ],
        ),
      ),
        body: _loading ? Padding(
      
      padding: const EdgeInsets.all(8),
    
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando...')
                          
                        ],
                      )),
                    ) : SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            
            selldetailmodel.status==1 ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: (){
                showDialog(context: context , builder: (BuildContext context)=>AlertDialog(
                            title: const Text('Deseja confirmar este recibo?'),
                            content: Text('Ao Confirmar este recibo, não será possível utilizar novamente?'),
                            actions: [
                              TextButton(
                                onPressed: ()async{
                                  setState(() {
                                      _loadingcentral = true;
                                    });
                                  
                                  var res = await verifyreceipt(widget.id);
                                
                                            if(res.error == null){
                                                // ignore: use_build_context_synchronously
                                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text('${res.data}')
                                                ));
                 
               }else{

                Navigator.pop(context);
                 // ignore: use_build_context_synchronously
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.data}')
                  ));
               }

                              }, 
                              child: const Text('Sim')),

                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Não'))
                            ],
                          ));
              },
              child: const Text('Confirmar',),
            ),
            const SizedBox(height: 20,),
           
          ],
        ),
      ):Container(),

      selldetailmodel.status==1 ? Center(
        child: Text('Válido',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 6, 222, 13))),
      ):Center(
        child: Text('Inválido',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 252, 8, 8))),
      ),

      
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: const Center(
                  child: Text('MTicket Bar',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**${userProfile.event_name}**',style: const TextStyle(fontSize: 12),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**Data: ${userProfile.date}**',style: const TextStyle(fontSize: 12),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**Recibo: #${selldetailmodel.sell_id}**',style: const TextStyle(fontSize: 12),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**Barman: ${userProfile.name}**',style: const TextStyle(fontSize: 12),),
                ),
              ),
              const Divider(),
              ListView.builder(
                 shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _sellDetailsList.length,
                          itemBuilder: (BuildContext context, int index){
                            SellDetailModel sellmodel = _sellDetailsList[index];
                            return ListTile(                

                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${sellmodel.qtd} x ${sellmodel.product_name}  (${sellmodel.price} MT un)',style: const TextStyle(fontSize: 12)),
                                    Text('${sellmodel.total} MT',style: const TextStyle(fontSize: 12)),
                                  ],
                                )

                            );
                          }
                ),
              const Divider(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      const Text('Total',style: TextStyle(fontSize: 16)),
                      Text('${selldetailmodel.totalsell} MT',style: const TextStyle(fontSize: 12)),
                                ],
                      ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      const Text('Pago a:',style: TextStyle(fontSize: 16)),
                      Text(selldetailmodel.method,style: const TextStyle(fontSize: 12)),
                                ],
                      ),
              ),
              const Divider(),

              const Center(
                child: Text('**Obrigado**',style: TextStyle(fontSize: 16)),
              ),
              Center(
                child: SizedBox(
                  height: 100,
                  child: SfBarcodeGenerator(
                      value: 'kelven',
                      symbology: QRCode(),
                    ),
                ),
              ),
              Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: (){
                _createPdf(selldetailmodel,_sellDetailsList);
              },
              child: const Text('Imprimir',),
            ),
            const SizedBox(height: 20,),
            // ElevatedButton(
            //   onPressed: _displayPdf,
            //   child: Text('Display PDF',),
            // ),
            // SizedBox(height: 20,),
            // ElevatedButton(
            //   onPressed: generatePdf,
            //   child: Text('Generate Advanced PDF',),
            // ),
          ],
        ),
      ),
              
            ],
          ),
        ),
      
    );
     
  
  }
  /// create PDF & print it
  Future<void> _createPdf(SellDetailModel sell, List<dynamic> sellDetailsList) async {
    
    final doc = pw.Document();

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
            
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('MTicket Bar',style:  pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
              )
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**${userProfile.event_name}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
             pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**Data: ${userProfile.date}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**Recibo: #${sell.sell_id}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**Barman: ${userProfile.name}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
            pw.Divider(),

            pw.ListView.builder(
              itemCount: sellDetailsList.length,
              itemBuilder: (context, index){
                SellDetailModel sellmodel = sellDetailsList[index];
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('${sellmodel.qtd} x ${sellmodel.product_name}',style:  pw.TextStyle(fontSize: 12)),
                    pw.Text('${sellmodel.total} MT',style:  pw.TextStyle(fontSize: 12)),
                  ]
                );

              }, 
              ),
            
            pw.Divider(),
            pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                     children: [
                       pw.Text('Total',style: pw.TextStyle(fontSize: 16)),
                      pw.Text('${selldetailmodel.totalsell} MT',style: const pw.TextStyle(fontSize: 12)),
                                ],
                      ),
              ),
            pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                     children: [
                       pw.Text('Pago a:',style: pw.TextStyle(fontSize: 16)),
                      pw.Text(selldetailmodel.method,style:  pw.TextStyle(fontSize: 12)),
                                ],
                      ),
              ),
               pw.Divider(),
                pw.Center(
                child: pw.Text('**Obrigado**',style: pw.TextStyle(fontSize: 16)),
              ),
              pw.SizedBox(height: 5),

              pw.Center(
                child: pw.SizedBox(
                  child: pw. BarcodeWidget(
                    barcode: pw.Barcode.qrCode(
                      errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high,
                    ),
                    data: '${sell.sell_id}',
                    width: 100,
                    height: 100,
                  ),
                 
                )
              ),
               pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text('Beira, Moçambique',style: pw.TextStyle(fontSize: 12)),
              ),
              pw.Center(
                child: pw.Text('+258 842648618',style: pw.TextStyle(fontSize: 12)),
              ),
              pw.SizedBox(height: 50),
              pw.Center(
                child: pw.Text('***************',style: pw.TextStyle(fontSize: 16)),
              ),
            
          ]);
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }


  /// display a pdf document.
  void _displayPdf() {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'MTicket Bar',
              style: pw.TextStyle(fontSize: 72),
            ),
          );
        },
      ),
    );

    /// open Preview Screen
    Navigator.push(context, MaterialPageRoute(builder:
        (context) => PreviewScreen(doc: doc),));
  }

  /// Convert a Pdf to images, one image per page, get only pages 1 and 2 at 72 dpi
  void _convertPdfToImages(pw.Document doc) async {
    await for (var page in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
      final image = page.toImage(); // ...or page.toPng()
      print(image);
    }
  }

  /// print an existing Pdf file from a Flutter asset
  void _printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load('assets/document.pdf');
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }

  /// more advanced PDF styling
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  void generatePdf() async {
    const title = 'eclectify Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  }

}












class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Preview"),
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "mydoc.pdf",
      ),
    );
  }
}



