import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const HomePage({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    child: Icon(Icons.menu, color: Colors.black),
                    onTap: onMenuTap,
                  ),
                  Text("DashBoard",
                      style: TextStyle(fontSize: 24, color: Colors.black)),
                  Icon(Icons.settings, color: Colors.black),
                ],
              ),
              SizedBox(height: 50),
              Container(
                height: 200,
                child: PageView(
                  controller: PageController(viewportFraction: 0.8),
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: <Widget>[
                    CustomScrollView(
                      slivers: <Widget>[
                        //custom scroll behaviour for appbar
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leading: InkWell(
                            onTap: onMenuTap,
                            child: Icon(Icons.menu, color: Colors.black),
                          ),
                          iconTheme: new IconThemeData(color: Colors.blue),
                          floating: true,
                          snap: true,
                          //seethrough
                          backgroundColor: Colors.transparent,

                          //shadow
                          elevation: 0.0,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(
                              "dashboard",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            centerTitle: true,
                          ),
                        ),
                        FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("service_type")
                                .orderBy("pos")
                                .get(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return SliverToBoxAdapter(
                                  child: Container(
                                    height: 200.0,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                );
                              else {
                                return SliverStaggeredGrid.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1.0,
                                  mainAxisSpacing: 1.0,
                                  staggeredTiles: snapshot.data.docs.map((doc) {
                                    return StaggeredTile.count(
                                        doc.data()["x"], doc.data()["y"]);
                                  }).toList(),
                                  children: snapshot.data.docs.map((doc) {
                                    return Container(
                                      height: 200.0,
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        child: Card(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0)),
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 5.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () {},
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                        top: 0.0,
                                                        left: 0.0,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6,
                                                                  top: 10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              //The title
                                                              Text(
                                                                doc.data()[
                                                                    "title"],
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            67,
                                                                            73,
                                                                            80,
                                                                            1),
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
//                Text(
//                  "quantity"
////                  doc.data["quantity"],
//                  ,style: TextStyle(
//                      color: Colors
//                          .grey[500],
//                      fontSize: 12.0,
//                      fontWeight:
//                          FontWeight
//                              .bold),
//                )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0.0,
                                                        left: 0.0,
                                                        right: 0.0,
                                                        child: Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 8,
                                                                    right: 8),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                FadeInImage
                                                                    .memoryNetwork(
                                                                  height: 70.0,
                                                                  width: 70.0,
                                                                  placeholder:
                                                                      kTransparentImage,
                                                                  alignment:
                                                                      FractionalOffset
                                                                          .bottomRight,
                                                                  image: doc
                                                                          .data()[
                                                                      "imgLink"],
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            )),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                            })
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
