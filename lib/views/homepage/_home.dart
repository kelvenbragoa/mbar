import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/models/api_response.dart';
import 'package:mticketbar/services/sell_service.dart';
import 'package:mticketbar/services/user_service.dart';
import 'package:mticketbar/views/auth/login.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class HomePagePrint extends StatefulWidget {
  int id;
  HomePagePrint({Key? key, required this.id}) : super(key: key);

  @override
  State<HomePagePrint> createState() => _HomePagePrintState();
}

class _HomePagePrintState extends State<HomePagePrint> {


  List<dynamic> _sellDetailsList = [];




  bool _loading = true;
 

  
  
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
    retrieveSellDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
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
          "Detalhes do Venda",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
          ],
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('MTicket Bar',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**${userProfile.event_name}**',style: TextStyle(fontSize: 12),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**Data: ${userProfile.date}**',style: TextStyle(fontSize: 12),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**Recibo: #4**',style: TextStyle(fontSize: 12),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('**Barman: ${userProfile.name}**',style: TextStyle(fontSize: 12),),
                ),
              ),
              Divider(),
              ListView.builder(
                 shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _sellDetailsList.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(                

                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('2 x Manica',style: TextStyle(fontSize: 12)),
                                    Text('100 MT',style: TextStyle(fontSize: 12)),
                                  ],
                                )

                            );
                          }
                ),
              Divider(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      Text('Total',style: TextStyle(fontSize: 16)),
                      Text('9500 MT',style: TextStyle(fontSize: 12)),
                                ],
                      ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      Text('Pago a:',style: TextStyle(fontSize: 16)),
                      Text('Dinheiro',style: TextStyle(fontSize: 12)),
                                ],
                      ),
              ),
              Divider(),

              Center(
                child: Text('**Obrigado**',style: TextStyle(fontSize: 16)),
              ),
              Center(
                child: Container(
                  height: 100,
                  child: SfBarcodeGenerator(
                      value: 'kelven',
                      symbology: QRCode(),
                    ),
                ),
              )
              
            ],
          ),
        ),
      
    );
     
  
  }
  /// create PDF & print it
  void _createPdf() async {
    final doc = pw.Document();

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello eclectify Enthusiast'),
          ); // Center
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

  // Center(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ElevatedButton(
  //             onPressed: _createPdf,
  //             child: Text('Create & Print PDF',),
  //           ),
  //           SizedBox(height: 20,),
  //           // ElevatedButton(
  //           //   onPressed: _displayPdf,
  //           //   child: Text('Display PDF',),
  //           // ),
  //           // SizedBox(height: 20,),
  //           // ElevatedButton(
  //           //   onPressed: generatePdf,
  //           //   child: Text('Generate Advanced PDF',),
  //           // ),
  //         ],
  //       ),
  //     ),

  // /// display a pdf document.
  // void _displayPdf() {
  //   final doc = pw.Document();
  //   doc.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text(
  //             'MTicket Bar',
  //             style: pw.TextStyle(fontSize: 72),
  //           ),
  //         );
  //       },
  //     ),
  //   );

  //   /// open Preview Screen
  //   Navigator.push(context, MaterialPageRoute(builder:
  //       (context) => PreviewScreen(doc: doc),));
  // }

  // /// Convert a Pdf to images, one image per page, get only pages 1 and 2 at 72 dpi
  // void _convertPdfToImages(pw.Document doc) async {
  //   await for (var page in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
  //     final image = page.toImage(); // ...or page.toPng()
  //     print(image);
  //   }
  // }

  // /// print an existing Pdf file from a Flutter asset
  // void _printExistingPdf() async {
  //   // import 'package:flutter/services.dart';
  //   final pdf = await rootBundle.load('assets/document.pdf');
  //   await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  // }

  // /// more advanced PDF styling
  // Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  //   final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  //   final font = await PdfGoogleFonts.nunitoExtraLight();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (context) {
  //         return pw.Column(
  //           children: [
  //             pw.SizedBox(
  //               width: double.infinity,
  //               child: pw.FittedBox(
  //                 child: pw.Text(title, style: pw.TextStyle(font: font)),
  //               ),
  //             ),
  //             pw.SizedBox(height: 20),
  //             pw.Flexible(child: pw.FlutterLogo())
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //   return pdf.save();
  // }

  // void generatePdf() async {
  //   const title = 'eclectify Demo';
  //   await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  // }

}












// class PreviewScreen extends StatelessWidget {
//   final pw.Document doc;

//   const PreviewScreen({
//     Key? key,
//     required this.doc,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//         centerTitle: true,
//         title: Text("Preview"),
//       ),
//       body: PdfPreview(
//         build: (format) => doc.save(),
//         allowSharing: true,
//         allowPrinting: true,
//         initialPageFormat: PdfPageFormat.a4,
//         pdfFileName: "mydoc.pdf",
//       ),
//     );
//   }
// }



