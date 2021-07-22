import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tovit/App%20Services/Themes/appTheme.dart';
import 'package:tovit/datamodels/busModel.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';

class WhileNavigating extends StatelessWidget {
  WhileNavigating({
    Key? key,
    required this.pageController,
    required this.resetAll,
  }) : super(key: key);
  Function resetAll;

  final PageController pageController;

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, sizingInfo) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
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
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10) +
                          EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Your Bus",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      InkWell(
                        onTap: () {
                          resetAll();
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      height: sizingInfo.screenSize!.height * 0.28,
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        pageSnapping: true,
                        // scrollBehavior: ScrollBehavior.,
                        controller: pageController,
                        // padding: EdgeInsets.zero,
                        // margin: EdgeInsets.zero,
                        // initialIndex: 1,
                        // itemSize:
                        //     (sizingInfo.screenSize!.width * 0.75) +
                        //         25,
                        // onItemFocus: (d) {},
                        // scrollPhysics: BouncingScrollPhysics(),

                        itemCount: 20,
                        // separatorBuilder: (context, index) =>
                        //     Padding(
                        //   padding: EdgeInsets.all(10),
                        // ),
                        // physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: sizingInfo.screenSize!.width * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                          color: Color(0xff7279B9),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          "0${index + 1}",
                                          style: GoogleFonts.teko(
                                              color: Colors.white,
                                              height: 1.6,
                                              fontSize: 36),
                                        ),
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                          text: "${index + 6}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                          children: [
                                            TextSpan(
                                              text: " mins",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Pickup",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "near Trendset",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Continue",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(
                                              color: Color(0xff7279B9),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffABAFD5),
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
