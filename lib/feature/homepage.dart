import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:demoproject/core/theme/pallette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/global_variable/global_variable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> leads = [];

  @override
  void initState() {
    super.initState();
    fetchLeads().then((data) {
      setState(() {
        leads = data;
      });
    });
  }

  Future<List<dynamic>> fetchLeads() async {
    final http.Client dartClient = http.Client();

    try {
      final response = await dartClient.get(
        Uri.parse(
          'https://crm-beta-api.vozlead.in/api/v2/lead/lead_list/?priority=&date=&to=&from=&status=&page=1&item=25&search=&user_id=',
        ),
        headers: {
          'Authorization': 'Token bcd4fe3b56a1f73e190c28dd7487bd0f03a7eb49',
        },
      );

      if (response.statusCode == 200) {
        print(response);
        return jsonDecode(response.body);
      } else {
        print('Failed to load leads. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching leads: $error');
      return [];
    } finally {
      dartClient.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        body: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.02),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey.shade100,
                        blurRadius: 3,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(2, 0))
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: w * 0.04),
                    Icon(
                      Icons.filter_list_sharp,
                      size: w * 0.07,
                      color: Colors.grey.shade900,
                    ),
                    SizedBox(width: w * 0.04),
                    Text(
                      "Lead List",
                      style: TextStyle(
                          fontSize: h * 0.026, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.bell_fill,
                      size: w * 0.07,
                      color: Colors.grey.shade900,
                    ),
                    SizedBox(width: w * 0.04),
                  ],
                ),
              ),
              SizedBox(height: h * 0.04),
              SizedBox(
                height: h * 0.68,
                child: ListView.builder(
                  // itemCount: 3,
                  itemCount: leads.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final lead = leads[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: h * 0.02),
                      child: Container(
                        width: w,
                        height: h * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.02),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey.shade100,
                                blurRadius: 3,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(2, 0))
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: w * 0.03),
                            Container(
                              width: w * 0.12,
                              height: h * 0.15,
                              decoration: BoxDecoration(
                                color: Palette.secondaryColor,
                                borderRadius: BorderRadius.circular(w * 0.06),
                              ),
                              child: Center(
                                child: Text(
                                  "01",
                                  style: TextStyle(
                                      fontSize: h * 0.024,
                                      color: Palette.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: w * 0.03),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: h * 0.01),
                                Text(
                                  // "Daniel",
                                  lead['name'] ?? 'Unknown',
                                  style: TextStyle(
                                      fontSize: h * 0.026,
                                      color: Palette.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: h * 0.01),
                                Text(
                                  "example@gmail.com",
                                  style: TextStyle(
                                      fontSize: h * 0.02,
                                      color: Palette.primaryColor,
                                      fontWeight: FontWeight.w200),
                                ),
                                Text(
                                  "created: 17/09/2023",
                                  style: TextStyle(
                                      fontSize: h * 0.02,
                                      color: Palette.primaryColor,
                                      fontWeight: FontWeight.w200),
                                ),
                                Text(
                                  "Mob: 989898989",
                                  style: TextStyle(
                                      fontSize: h * 0.02,
                                      color: Palette.primaryColor,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              width: w * 0.15,
                              height: h * 0.05,
                              decoration: BoxDecoration(
                                color: Palette.secondaryColor,
                                borderRadius: BorderRadius.circular(w * 0.06),
                              ),
                              child: Center(
                                child: Text(
                                  "Flutter",
                                  style: TextStyle(
                                      fontSize: h * 0.017,
                                      color: Palette.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: w * 0.02),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: h * 0.02,
                                    ),
                                    Text(
                                      "Calicut",
                                      style: TextStyle(
                                        fontSize: h * 0.02,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: h * 0.02),
                                Icon(
                                  Icons.phone_in_talk,
                                  size: h * 0.044,
                                  color: Palette.primaryColor,
                                )
                              ],
                            ),
                            SizedBox(width: w * 0.02),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Palette.thirdColor,
          label: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: w * 0.05,
              ),
              Text(
                'Add Lead',
                style: TextStyle(fontSize: h * 0.024, color: Colors.white),
              )
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
