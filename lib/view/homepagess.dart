import 'dart:convert';

import 'package:demoproject/core/global_variable/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../model/usermodel.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  int currentPage = 1;
  int limit = 10;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final response = await http.get(Uri.parse(
        'https://dummyjson.com/users?page=$currentPage&limit=$limit'));

    if (response.statusCode == 200) {
      UserModel userModel = userModelFromJson(response.body);

      setState(() {
        users.addAll(userModel.users);
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "USER LIST",
          style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(h * 0.01),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsScreen(userId: users[index].id),
                        ),
                      );
                    },
                    child: Container(
                      width: w,
                      height: h * 0.1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade50),
                        borderRadius: BorderRadius.circular(w * 0.03),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: w * 0.03),
                          CircleAvatar(
                            radius: w * 0.05,
                            backgroundImage: NetworkImage(users[index].image),
                          ),
                          SizedBox(width: w * 0.03),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${users[index].firstName}",
                                  style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  users[index].email,
                                  style: TextStyle(fontSize: w * 0.03),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: h * 0.07,
            width: w * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(w * 0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentPage > 1) {
                      setState(() {
                        currentPage--;
                      });
                      _loadUsers();
                    }
                  },
                  child: Icon(
                    Icons.skip_previous_outlined,
                    color: Colors.black,
                    size: w * 0.06,
                  ),
                ),
                Text('Page $currentPage',
                    style: TextStyle(fontSize: w * 0.036)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage++;
                    });
                    _loadUsers();
                  },
                  child: Icon(
                    Icons.skip_next_outlined,
                    color: Colors.black,
                    size: w * 0.06,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: h * 0.02)
        ],
      ),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  final int userId;

  UserDetailsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "USER DETAILS",
          style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: FutureBuilder<User>(
        future: _fetchUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: h * 0.2,
                        width: w * 0.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Image.network(user.image),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    Center(
                      child: Text(
                        "ID: ${user.id}",
                        style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "First Name:",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.firstName,
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Second Name: ",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.lastName,
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Maiden Name:",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.maidenName,
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Age:",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "${user.age}",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Gender: ",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "${user.gender}",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Email: ",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Phone:",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.phone,
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "DOB:",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "${DateFormat.yMMMd().format(user.birthDate)}",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Blood Group: ",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.bloodGroup,
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Height: ",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "${user.height}",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Weight: ",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "${user.weight}",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      "Eye Color: ",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.eyeColor,
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: h * 0.01),
                    Center(
                      child: Text(
                        "See More",
                        style:
                            TextStyle(fontSize: w * 0.03, color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<User> _fetchUserDetails(int userId) async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
