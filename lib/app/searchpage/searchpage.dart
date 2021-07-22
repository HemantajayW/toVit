import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/app/searchpage/VM_Searchpage.dart';
import 'package:tovit/datamodels/addressmodel.dart';
import 'package:tovit/dataprovider/Appdata.dart';
import 'package:tovit/enums/viewState.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';
import 'package:tovit/responsiveUi/baseView.dart';

class SearchPage extends StatefulWidget {
  Address? pickupLocation;
  Address? dropLocation;
  bool toCampus;

  SearchPage(
      {Key? key, this.dropLocation, this.pickupLocation, this.toCampus = false})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController destinController = TextEditingController();
  var destinfocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String address;
    if (Provider.of<AppData>(context).campusLocation == null) {
      address = "";
    } else {
      address = Provider.of<AppData>(context).campusLocation!.placeName ?? "";
      pickupController.text = address;
      if (address.length != 0) {
        FocusScope.of(context).requestFocus(destinfocus);
      }
    }

    return BaseView<VM_SearchPage>(
      builder: (context, value, child) => ResponsiveWidget(
        builder: (context, sizingInfo) => Scaffold(
          backgroundColor: Colors.grey.shade100,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
            ),
            // brightness: Brightness.light,
            title: Text(
              "Set Destination",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  // color: Colors.white,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 0.5,
                        offset: Offset(0.5, 0.5))
                  ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0) +
                        EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              Icon(
                                Icons.my_location_rounded,
                                color: Colors.green,
                                size: 22,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Center(
                                  child: TextFormField(
                                    controller: pickupController,
                                    decoration: InputDecoration(
                                      hintText: "Pick Up Location",
                                      isDense: true,
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 13,
                                        top: 13,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              Icon(
                                Icons.place_rounded,
                                color: Colors.blue,
                                size: 22,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Center(
                                  child: TextFormField(
                                    onChanged: (str) => value!.SearchPlace(str),
                                    focusNode: destinfocus,
                                    controller: destinController,
                                    decoration: InputDecoration(
                                      hintText: "Where to?",
                                      isDense: true,
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 13,
                                        top: 13,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        value!.state == ViewState.BUSY
                            ? LinearProgressIndicator()
                            : SizedBox(
                                height: 0,
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: value.predictionList.length > 0
                      ? ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          // separatorBuilder: (context, index) => Divider(
                          //   color: Colors.grey,
                          //   height: 10,
                          // ),
                          itemCount: value.predictionList.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  var res = await value.getPlaceDetails(
                                      value.predictionList[index].placeId,
                                      context);
                                  print("res:$res");
                                  if (res == 1) {
                                    print("Navigating Back");
                                    Navigator.of(context).pop("1");
                                    print("Navigated Back");
                                  }
                                },
                                child: Container(
                                  height: 65,
                                  child: Center(
                                    child: ListTile(
                                      minVerticalPadding: 0,
                                      leading: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade300),
                                        child: Center(
                                          child: Icon(
                                            Icons.place_outlined,
                                            color: Colors.grey.shade700,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        value.predictionList[index].mainText,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      subtitle: Text(
                                        value.predictionList[index]
                                            .secondaryText,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                indent: 66,
                              )
                            ],
                          ),
                        )
                      : Container(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
