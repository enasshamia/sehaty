
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/backend/repositary.dart';
import 'package:graduation/models/rate.dart';
import 'package:provider/provider.dart';
import 'package:graduation/backend/server.dart';
class PatientRating extends StatefulWidget {


  @override
  _PatientRatingState createState() => _PatientRatingState();
}

class _PatientRatingState extends State<PatientRating> {
    void initState() {
    super.initState();
    getRatingPatient(Repository.repository.appUser.userId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("التقييمات" , style: GoogleFonts.cairo(),),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Selector<AppsProvider, List<Rate>>(
            builder: (context, value, child) {
              return value.isEmpty
                  ? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
Text("لا يوجد ملاحظات ...."),
 CircularProgressIndicator()

                  ],))
                  : ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white ,
                          elevation: 5,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(value[index].doctorname , style: GoogleFonts.cairo(fontSize: 20 ,fontWeight: FontWeight.bold)),
                                  RatingBar.builder(
                                    initialRating:
                                        double.parse(value[index].rateing),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Text(value[index].commnet , style: GoogleFonts.cairo(fontSize: 18 , fontWeight: FontWeight.w600))
                                ]),
                          ),
                        );
                      });
            },
            selector: (x, y) {
              return y.rates;
            },
          ),
        ),
      ),
    );
  }
}