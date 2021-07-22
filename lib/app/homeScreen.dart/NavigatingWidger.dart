import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tovit/App%20Services/Themes/appTheme.dart';
import 'package:tovit/datamodels/busModel.dart';
import 'package:tovit/datamodels/busStop.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';

class NavigatingWidget extends StatefulWidget {
  String address;
  NavigatingWidget({Key? key, required this.address}) : super(key: key);

  @override
  _NavigatingWidgetState createState() => _NavigatingWidgetState();
}

class _NavigatingWidgetState extends State<NavigatingWidget> {
  Bus bus = Bus(routes: [
    BusStop(name: "miyapur", time: "12:30", reached: true),
    BusStop(name: "Kukkatpally", time: "01:30", reached: true),
    BusStop(name: "Gudivada", time: "12:20", reached: true),
    BusStop(name: "Cooperaive Colony", time: "02:30", reached: true),
    BusStop(name: "srinagar", time: "12:10"),
    BusStop(name: "kanyakumari", time: "01:40"),
    BusStop(name: "srinagar", time: "12:10"),
    BusStop(name: "kanyakumari", time: "01:40"),
    BusStop(name: "srinagar", time: "12:10"),
    BusStop(name: "kanyakumari", time: "01:40"),
    BusStop(name: "srinagar", time: "12:10"),
    BusStop(name: "kanyakumari", time: "01:40"),
  ], driverName: "driver Babu", busNO: 01);

  bool waiting = true;
  @override
  void initState() {
    delay();
    super.initState();
  }

  void delay() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      print("future completed");
      setState(() {
        waiting = false;
        print("future set state");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        builder: (context, sizingInfo) => DraggableScrollableSheet(
              initialChildSize: waiting ? 0.28 : 0.35,
              maxChildSize: 0.7,
              builder: (context, scrollController) => waiting
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0),
                            child: LinearProgressIndicator(
                              color: shadeDark,
                              backgroundColor: shadeLight,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Fetching Ride Details...",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Container(
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.grey.shade100)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Spacer(),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 5,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "B0${bus.busNO}",
                                          style: GoogleFonts.anton(
                                            color: shadeDark,
                                            fontSize: 56,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "pickup at",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade400,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            Text(
                                              "address",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: shadeLight,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 28),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 10, left: 10),
                                      height:
                                          sizingInfo.screenSize!.height * 0.7,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TrackingWidget(
                                            controller: scrollController,
                                            routes: bus.routes,
                                            size:
                                                sizingInfo.screenSize!.height *
                                                    0.7,
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      )),
            ));
  }
}

class TrackingWidget extends StatelessWidget {
  List<BusStop> routes;
  ScrollController controller;
  var size;
  TrackingWidget(
      {required this.routes, Key? key, this.size, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, sizingInfo) {
      var scale = (size - 40) / routes.length;
      return ListView.separated(
          // controller: controller,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context, index) => Row(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: !routes[index].reached ? 16 : 16,
                    width: !routes[index].reached ? 16 : 16,
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: !routes[index].reached
                            ? Colors.white
                            : Colors.amberAccent,
                        border: Border.all(
                          color: !routes[index].reached
                              ? Colors.grey
                              : Colors.amberAccent,
                        ),
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 45,
                    child: Text(
                      routes[index].time,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                            color:
                                !routes[index].reached ? shadeDark : shadeLight,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(routes[index].name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            color: !routes[index].reached
                                ? Colors.black87
                                : Colors.grey.shade500,
                            fontWeight: FontWeight.w600,
                          ))
                ],
              ),
          separatorBuilder: (context, index) => Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Container(
                          // padding: EdgeInsets.all(15),
                          height: 25,
                          width: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 800),
                          height: !routes[index + 1].reached ? 1 : 39,
                          width: !routes[index + 1].reached ? 0 : 2,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          itemCount: routes.length);
    });
  }
}
