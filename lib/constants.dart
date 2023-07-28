import 'package:flutter/material.dart';
import 'package:mticketbar/models/user.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color.fromARGB(255, 255, 255, 255);


const defaultPadding = 16.0;


// const baseURL = 'http://mticket.co.mz/api';
// const url =     'http://mticket.co.mz/storage/';

const baseURL = 'http://192.168.0.102:8000/api';
const url =     'http://192.168.0.102:8000/storage/';


const loginURL = baseURL + '/protocol-login';
const homeURL = baseURL+ '/home';
const allTicketURL = baseURL+'/alltickets';
const doneTicketURL = baseURL+'/donetickets';
const pendingTicketURL = baseURL+'/pendingtickets';
const ticketURL = baseURL+'/ticket';
const verifyticketURL = baseURL+'/verifyticket';


//BARMAN
const loginBarURL = baseURL + '/barman-login';
const homeBarURL = baseURL+ '/barman-home';
const productsBarURL = baseURL+'/barman-products';
const productBarURL=baseURL+'/barman-product';
const cartCreateBarURL = baseURL+'/barman-carts';
const cartBarURL = baseURL+'/barman-cart';
const cartDeleteBarURL = baseURL+'/barman-cart';
const sellcreateBarURL= baseURL+'/barman-sells';
const sellBarURL= baseURL+'/barman-sells';
const sellDetailBarURL = baseURL+'/barman-sells-detail';
const userBarURL = baseURL+'/barman-user';
const verifyreceiptURL = baseURL+'/verifyreceipt';






const registerURL = baseURL+ '/register';

const logoutURL = baseURL+ '/logout';

const userURL = baseURL+ '/user';

const dashboardURL = baseURL+ '/dashboard';

const autorizationURL = baseURL + '/autorization';

const autorizationGuestURL = baseURL + '/autorizationguest';

const circulationinURL = baseURL + '/circulationin';

const circulationoutURL = baseURL + '/circulationout';

const circulationinguestURL = baseURL + '/circulationinguest';

const circulationoutguestURL = baseURL + '/circulationoutguest';

const scanURL = baseURL + '/appscan';

const createScanUserURL = baseURL+ '/scanuser';

const createScanGuestURL = baseURL+ '/scanguest';


const createGuestAutorizationURL = baseURL+ '/autorizationguest';

const activityURL = baseURL+ '/activity';


const requestCirculationURL = baseURL+ '/circulationin/create';

const storeCirculationURL = baseURL+ '/circulationin/store';

const requestCirculationOutURL = baseURL+ '/circulationout/create';

const storeCirculationOutURL = baseURL+ '/circulationout/store';


const requestCirculationGuestURL = baseURL+ '/circulationinguest/create';

const storeCirculationGuestURL = baseURL+ '/circulationinguest/store';

const requestCirculationOutGuestURL = baseURL+ '/circulationoutguest/create';

const storeCirculationOutGuestURL = baseURL+ '/circulationoutguest/store';

const requestUserPdfURL = baseURL+ '/requestuserpdf';

const requestGuestPdfURL = baseURL+ '/requestguestpdf';









const categoryproductsURL = baseURL+'/categoryproducts';

const productshomeURL = baseURL+ '/producthome';

const searchproductURL = baseURL+ '/searchproduct';

const productsURL = baseURL+ '/product';

const categoryURL = baseURL+ '/category';

const cartURL = baseURL+ '/cart';

const cartcreateURL = baseURL+ '/carts';

const localURL = baseURL+ '/local';

const sellURL = baseURL+ '/sells';

const sellcreateURL = baseURL+ '/sells';

User userProfile = User(id: id, name: name,user: user, mobile: mobile, bi: bi,password:password,event_id:event_id,event_name:event_name,date:date);//, token: token);
var id;
var user;
var name;
var mobile;
var bi;
var event_id;
var event_name;
var password;
var date;



// ERRORS

const serverError ='Erro. Verifique sua conexão e tente novamente.';

const unauthorized = 'Não autorizado';

const somethingwentwrong = 'Erro inesperado. Tente Novamente.';

