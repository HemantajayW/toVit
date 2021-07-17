import 'package:flutter/material.dart';
import 'package:tovit/Styles/textstyles.dart';

class NotDrawer extends StatelessWidget {
  const NotDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade100,
        child: ListView(
          children: [
            Container(
              height: 150,
              color: Colors.white,
              // padding: EdgeInsets.all(10),
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade200),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/images/user.png",
                        height: 42,
                        width: 42,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hemanth ajay kumar",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "@18MIS7062",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.departure_board_outlined,
                color: Colors.grey,
                size: 24,
              ),
              title: Text("Departure Board", style: knavmenutextstyle(context)),
            ),
            ListTile(
              leading: Icon(
                Icons.person_search_outlined,
                color: Colors.grey,
                size: 24,
              ),
              title: Text("Search people", style: knavmenutextstyle(context)),
            ),
            ListTile(
              leading: Icon(
                Icons.history_outlined,
                color: Colors.grey,
                size: 24,
              ),
              title: Text("History", style: knavmenutextstyle(context)),
            ),
            ListTile(
              leading: Icon(
                Icons.support_outlined,
                color: Colors.grey,
                size: 24,
              ),
              title: Text("support", style: knavmenutextstyle(context)),
            ),
          ],
        ),
      ),
    );
  }
}
