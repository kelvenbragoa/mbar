import 'package:flutter/material.dart';
import 'package:mticketbar/constants.dart';
import 'package:mticketbar/views/auth/login.dart';
import 'package:mticketbar/views/homepage/home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({ Key? key }) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
   
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(()=> isLastPage = index==2);
          },
          children: [
            Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                     Image.asset('assets/images/gate1.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    ),
                
                  const SizedBox(height: defaultPadding,),
                  const Text(
                    'MTicket Bar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  const SizedBox(height: defaultPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text('O seu aplicativo para gerir o seu bar. ',textAlign: TextAlign.center,),
                  )
                  
                ],
              ),
            ),
            Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                     Image.asset('assets/images/gate2.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    ),
                
                  const SizedBox(height: defaultPadding,),
                  const Text(
                    'Bar',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: defaultPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text('Apenas pessoal autorizado e com credenciais serão portadores do aplicativo para utilização no bar.',textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Image.asset('assets/images/gate3.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    ),
                  const SizedBox(height: defaultPadding,),
                  const Text(
                    'Mticket Bar',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: defaultPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text('O seu aplicativo para Gerir o seu bar do Eventos',textAlign: TextAlign.center,),
                  )
                  
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage ? 
      TextButton(
        style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(5) 
            ),
        minimumSize: const Size.fromHeight(80)
        ),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
          
        }, 
        child: const Text('Iniciar')
        ) : 
        
        Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: (){
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                controller.jumpToPage(2);
              }, 
              child: const Text('Saltar')),
            
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                onDotClicked: (index) => controller.animateToPage(
                  index, 
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeInOut),
              ),
            ),

            TextButton(
              onPressed: (){
                controller.nextPage(
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeInOut);
              }, 
              child: const Text('Próximo'))
          ],
        ),
      ),
    );
  }
}