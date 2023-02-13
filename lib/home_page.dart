import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    // state untuk menampilkan loading saat data user masih di fetch
    bool isLoading = true;

    // state untuk menampung data user
    Map<String, dynamic> _user = {};

    // menjalankan fungsi fetch user ketika screen di load
    @override
    void initState() {
        super.initState();
        _fetchUser();
    }

    // fungsi fetch user dari API
    _fetchUser() async {
        final response = await http.get(Uri.parse('https://63987d90044fa481d69f8389.mockapi.io/users/1'));
        print(response.body);
        setState(() {
            _user = json.decode(response.body);
            isLoading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return 
        Scaffold(
        body: SafeArea(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                    
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                            Text(
                                "Zahir Mobile",
                                style: const TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w400, color: Color(0xFF20BF6B)),
                            ),
                            Text(
                                "Dev Challenge", 
                                style: const TextStyle(fontSize: 20.0 ,  fontWeight: FontWeight.w400, color: Color(0xFF20BF6B)),
                            ),
                            Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 20.0),
                                padding: EdgeInsets.only(top: 26.0, bottom: 26.0),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Color(0XFFECECEC), width: 1.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                    child: isLoading
                                    ? Center(child:CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF20BF6B)),
                                        strokeWidth: 3.0,
                                    ))
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget> [
                                            Image.asset(
                                                'assets/images/Avatar.png',
                                                fit: BoxFit.cover,
                                                width: 100.0,
                                                height: 100.0,
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget> [
                                                    Text(
                                                        '${_user['full_name']}',
                                                        style: const TextStyle(fontSize: 16.0 , fontWeight: FontWeight.w500, color: Color(0XFF394D6F)),
                                                    ),
                                                    IconButton(
                                                        padding: EdgeInsets.zero,
                                                        constraints: BoxConstraints(),
                                                        icon: Icon(
                                                                Icons.edit,
                                                                size: 17.0,
                                                                color: Color(0xFF20BF6B),
                                                            ),
                                                    
                                                        onPressed: () {
                                                            Navigator.pushNamed(context, '/edit-profile');
                                                        }
                                                    ),
                                                ]
                                            ),
                                            SizedBox(height: 5.0),
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget> [
                                                    Text(
                                                        '${_user['phone']}',
                                                        style: const TextStyle(fontSize: 14.0 , fontWeight: FontWeight.w400, color: Color(0XFFADADAD)),
                                                    ),
                                                    SizedBox(height: 5.0),
                                                    Text(
                                                        '${_user['skill']}',
                                                        style: const TextStyle(fontSize: 14.0 , fontWeight: FontWeight.w400, color: Color(0XFFADADAD)),
                                                    ),
                                                ]
                                            )
                                        ]
                                    )
                                ),
                            ),
                            GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(context, '/find-location');
                                },
                                child: 
                                Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 19.0),
                                    padding: EdgeInsets.only(top: 14.0, bottom: 14.0, left: 20.0, right: 20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: Color(0XFFECECEC), width: 1.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                            Text(
                                                "Location finding challenge",
                                                style: const TextStyle(fontSize: 14.0 , fontWeight: FontWeight.w500, color: Color(0XFF394D6F)),
                                            ),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                icon: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 18.0,
                                                    ),
                                                onPressed: () {
                                                    Navigator.pushNamed(context, '/find-location');
                                                }
                                            ),
                                        ]
                                    )
                                ),
                            )
                        ], 
                    ),
                ),
            )
        ),
        );
    }
}