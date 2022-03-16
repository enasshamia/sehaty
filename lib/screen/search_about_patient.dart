import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/appProvider.dart';

import 'package:graduation/models/user.dart';

import 'package:graduation/screen/home_patient_screen.dart';
import 'package:graduation/screen/patientDetails.dart';
import 'package:graduation/widget/searchwidget.dart';


import 'package:provider/provider.dart';

class SearchAboutPatientScreen  extends StatefulWidget {


  @override
  _SearchAboutPatientScreenState createState() => _SearchAboutPatientScreenState();
}

class _SearchAboutPatientScreenState extends State<SearchAboutPatientScreen> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text("ابحث عن مريض " ,style:GoogleFonts.cairo () ,) , centerTitle: true,
     
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () {
showSearch(context: context, delegate: DataSearch());

        })
      ],),
      body:Directionality(
        textDirection: TextDirection.rtl,
        child: SearchWidget()),
    );
  }
}
class DataSearch extends SearchDelegate <String>{
  List <AppUser> appuser ; 
  @override
  List<Widget> buildActions(BuildContext context) {
   return [
    IconButton(icon: Icon(Icons.clear), onPressed: () {
    query = "" ;
    })

   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow ,progress:  transitionAnimation,), onPressed: 
    (){
      Get.to(HomePatientScreen());
    }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

     Size size = MediaQuery.of(context).size;

    return  Selector<AppsProvider , List<AppUser>>(
           builder: (context, value, child) {
                if(query.isEmpty) {
                  return Center(child: Text("لا يوجد عملية بحث حتى الان .... "  , textDirection: TextDirection.rtl,) );;
                }else if (
                  query.isNotEmpty
                ) {
                value.where((element) => element.userName.startsWith(query)).toList();
                }
                else {
                print("error");
                }
              return  ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context , index) {
                     return Directionality(
                       textDirection: TextDirection.rtl,
                       child: Container(
             //     margin: EdgeInsets.only(top: 20),
                   padding: EdgeInsets.symmetric(horizontal: size.width*0.02 , vertical: size.height*0.006),
                         child: GestureDetector(
                           onTap: () {
                             Get.to(patientDetailsScreen(value[index]));
                           },
                           child: Card(
                            elevation: 5,
                             child: ListTile(
                             //  contentPadding: EdgeInsets.all(0.02),
                               subtitle: Text(value[index].email),
                               title: RichText(
                               text: TextSpan(
                                 text: value[index].userName.substring(0,query.length )
                                 ,style: GoogleFonts.cairo(color: Colors.black , fontWeight: FontWeight.bold,
                                 ),
                                 children: [
                                   TextSpan(text :  value[index].userName.substring(query.length ) ,style: GoogleFonts.cairo (color: Colors.grey )
                                 ),
                                 ]
                                 
                               ),
                             ),
                             leading: Container(
                               width: size.width*0.2,
                              
                               child: Image.network(value[index].logo, fit: BoxFit.cover,)),
                             ),
                           ),
                         ),
                       ),
                     );
                     
                });
           },
           selector: (x,y) {
             return y.patients ;
           },
   );
   
  }

}