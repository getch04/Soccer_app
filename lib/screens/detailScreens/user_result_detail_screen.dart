import 'package:flutter/material.dart';
import 'package:soccer_app/screens/route.dart';

class UserResultDetail extends StatelessWidget {
  static const routeName = 'admin_result_detail';
  final ResultRoutArgsForDetail result;

  UserResultDetail({@required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" RESULT DETAIL" ),),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                  height: 75,
                  width: 350,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40.0,0,0,0),
                      child: Row(
                        children: [
                          Text(
                            'First Club: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.result.result.fixture.clubs[0].name}',
                              style: TextStyle(color: Colors.black)),
                          SizedBox(width: 80,),
                          Icon(Icons.sports_football,color: Colors.black,size: 50,)
                        ],
                      ),
                    ),
                  )),
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                  height: 75,
                  width: 350,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40.0,0,0,0),
                      child: Row(
                        children: [
                          Text(
                            'Club Two: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.result.result.fixture.clubs[1].name}',
                              style: TextStyle(color: Colors.black)),
                          SizedBox(width: 80,),
                          Icon(Icons.map,color: Colors.black,size: 50,)
                        ],
                      ),
                    ),
                  )),
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                  height: 75,
                  width: 350,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40.0,0,0,0),
                      child: Row(
                        children: [
                          Text(
                            'Club one Score: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.result.result.firstClubScore}',
                              style: TextStyle(color: Colors.black)),
                          SizedBox(width: 80,),
                          Icon(Icons.map_outlined,color: Colors.black,size: 50,)
                        ],
                      ),
                    ),
                  )),
            ),

            Card(
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.9),
                  width: 1,
                ),
              ),
              child: Container(
                  height: 75,
                  width: 350,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40.0,0,0,0),
                      child: Row(
                        children: [
                          Text(
                            'Club Two Score: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.result.result.secondClubScore}',
                              style: TextStyle(color: Colors.black)),

                        ],
                      ),
                    ),
                  )),
            ),

            Text("GOOD LUCK"),
          ],
        ),
      ),
    );
  }
}
