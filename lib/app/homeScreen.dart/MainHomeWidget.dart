import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tovit/app/searchpage/searchpage.dart';
import 'package:tovit/datamodels/addressmodel.dart';
import 'package:tovit/dataprovider/Appdata.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';
import 'package:tovit/responsiveUi/sizingInformation.dart';

class MainHome extends StatelessWidget {
  Function(SizingInformation size) getMeCampus;
  Function(SizingInformation size) getMeHome;

  Function(SizingInformation size, Address? pickup, Address? drop) getdirection;
  MainHome({
    Key? key,
    required this.getdirection,
    required this.getMeCampus,
    required this.getMeHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, sizingInfo) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Container(
              height: sizingInfo.screenSize!.height * 0.26,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () => getMeCampus(sizingInfo),
                      child: Container(
                        height: sizingInfo.screenSize!.height * 0.28,
                        width: 140,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              child: Center(
                                  child: Icon(
                                Icons.school_rounded,
                                color: Colors.white,
                              )),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black12),
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Get Me \nto Campus",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ),
                            ),
                            // Spacer(
                            //   flex: ,
                            // ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () => getMeHome(sizingInfo),
                      child: Container(
                        height: sizingInfo.screenSize!.height * 0.28,
                        width: 110,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              child: Center(
                                  child: Icon(
                                Icons.home_rounded,
                                color: Colors.white,
                              )),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffF0535B)),
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Get Me Home",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ),
                            ),
                            // Spacer(
                            //   flex: ,
                            // ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffF9B8BB),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              var res = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (c) => SearchPage()));
                              if (res == "1") {
                                getdirection(
                                    sizingInfo,
                                    Provider.of<AppData>(context, listen: false)
                                        .campusLocation,
                                    Provider.of<AppData>(context, listen: false)
                                        .dropLocation);
                              }
                            },
                            child: Container(
                              width: 90,
                              child: Center(
                                child: Icon(
                                  Icons.search_rounded,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFfffff),
                                border: Border.all(color: Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Icon(
                                Icons.star_outline_rounded,
                                color: Colors.black.withOpacity(0.8),
                                size: 28,
                              ),
                            ),
                            width: 90,
                            decoration: BoxDecoration(
                              color: Color(0xffFFEE78),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Select your Bus",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Icon(Icons.keyboard_arrow_right_sharp)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: sizingInfo.screenSize!.height * 0.1,
              width: sizingInfo.screenSize!.width,
              child: ListView.builder(
                itemCount: 13,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: Center(
                        child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Color(0xffF0535B),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                        ),
                      ),
                    )),
                    width: 80,
                    decoration: BoxDecoration(
                        // color: Color(0xffF9B8BB),
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
