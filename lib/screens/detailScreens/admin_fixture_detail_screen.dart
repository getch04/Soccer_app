import 'package:flutter/material.dart';
import 'package:soccer_app/screens/route.dart';

class AdminFixtureDetail extends StatelessWidget {
  static const routeName = 'admin_fixture_detail';
  final FixtureRoutArgsForDetail fixture;

  AdminFixtureDetail({@required this.fixture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.fixture.fixture.clubs[0].name}' +
            "Vs" +
            '${this.fixture.fixture.clubs[1].name}'),
      ),
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
                            'Stadium: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.fixture.fixture.stadiumName}',
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
                            'Longtude: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.fixture.fixture.stadiumLongitude}',
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
                            'Latitude: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.fixture.fixture.stadiumLatitude}',
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
                            'StartingDate: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${this.fixture.fixture.startingDate}',
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
