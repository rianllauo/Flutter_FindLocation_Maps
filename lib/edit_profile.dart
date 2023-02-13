import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
    @override
    _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    // state menyimpan value dari setia TextField
    final _fullNameController = TextEditingController();
    final _phoneNumberController = TextEditingController();
    final _skillController = TextEditingController();
    final _lastEducationController = TextEditingController();
    final _addressController = TextEditingController();

    // state untuk membuat loading
    bool isLoading = true;

    @override
    void initState() {
        super.initState();
        fetchData();
    }

    Future<void> fetchData() async {

        // Ambil data dari API
        final response = await http.get(Uri.parse('https://63987d90044fa481d69f8389.mockapi.io/users'));
        final data = json.decode(response.body)[0];

        if (response.statusCode == 200) {
            setState(() {
                _fullNameController.text = data['full_name'];
                _phoneNumberController.text = data['phone'].toString();
                _skillController.text = data['skill'];
                _lastEducationController.text = data['last_education'];
                _addressController.text = data['address'];

                isLoading = false;
            });
        }

    }

    Future<void> _postData() async {
        setState(() {
            isLoading = true;
        });
        final response = await http.patch(Uri.parse(
            'https://63987d90044fa481d69f8389.mockapi.io/users/1'),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
                'full_name': _fullNameController.text,
                'phone': int.parse(_phoneNumberController.text),
            }),
        );

        if (response.statusCode == 200) {
            print('Data has been posted successfully');
            Navigator.pushNamed(context, '/');
            setState(() {
                isLoading = false;
            });
        } else {
            final error = jsonDecode(response.body);
            print(error);
            print('Failed to post data');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(

        // app bar
        appBar: AppBar(
            automaticallyImplyLeading: false,
            shadowColor: Colors.black12,
            elevation: 10,
            backgroundColor: Colors.white,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 20.0,
                        ),
                        onPressed: () {
                            Navigator.pushNamed(context, '/');
                        }
                    ),
                    SizedBox(width: 10.0),
                    Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.black, fontSize: 14.0), 
                    )
                ]
            
            ),
        ),
        // body 
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: SingleChildScrollView(
                child: 
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                            Container(
                                child: 
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget> [
                                        Container(
                                            margin: const EdgeInsets.only(top: 17.0),
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                image: AssetImage('assets/images/Avatar.png'),
                                                fit: BoxFit.cover
                                                ),
                                            ),
                                            child: 
                                                Stack(
                                                    children: <Widget>[
                                                        Positioned(
                                                            bottom: -10,
                                                            right: -10,
                                                            child: SizedBox(
                                                                width: 44.0,
                                                                height: 44.0,
                                                                child:  
                                                                FloatingActionButton(
                                                                    backgroundColor: Colors.white,
                                                                    elevation: 0.0,
                                                                    foregroundColor: Colors.white,
                                                                    child: Icon(
                                                                            Icons.camera_alt,
                                                                            size: 20.0,
                                                                            color: Color(0xFF20BF6B)
                                                                        ),
                                                                    onPressed: () {
                                                                        
                                                                    },
                                                                ),
                                                            ) 
                                                        ),
                                                    ],
                                                ),
                                        ),
                                    ]
                                    
                                ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                        children: <Widget> [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget> [
                                                    Text(
                                                        'Full Name',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Color(0XFF5D6D89)
                                                        )
                                                    ),
                                                     SizedBox(
                                                        height: 8.0,
                                                    ),
                                                    TextField(
                                                        controller: _fullNameController,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                            hintText: "Input Full Name",
                                                            hintStyle: TextStyle(fontSize: 14.0, color: Color(0XFFA5AEBD))
                                                        ),
                                                        style: TextStyle(fontSize: 14.0, color: Color(0XFF394D6F))
                                                    ),
                                                ]
                                            ),
                                            SizedBox(
                                                height: 19.0,
                                            ),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget> [
                                                    Text(
                                                        'Phone Number',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Color(0XFF5D6D89)
                                                        )
                                                    ),
                                                     SizedBox(
                                                        height: 8.0,
                                                    ),
                                                    TextField(
                                                        controller: _phoneNumberController,
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                            hintText: "Input Phone Number",
                                                            hintStyle: TextStyle(fontSize: 14.0, color: Color(0XFFA5AEBD))
                                                        ),
                                                        style: TextStyle(fontSize: 14.0, color: Color(0XFF394D6F))
                                                    ),
                                                ]
                                            ),
                                            SizedBox(
                                                height: 19.0,
                                            ),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget> [
                                                    Text(
                                                        'Skill',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Color(0XFF5D6D89)
                                                        )
                                                    ),
                                                     SizedBox(
                                                        height: 8.0,
                                                    ),
                                                    TextField(
                                                        controller: _skillController,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                            hintText: "Input Skill",
                                                            hintStyle: TextStyle(fontSize: 14.0, color: Color(0XFFA5AEBD))
                                                        ),
                                                        style: TextStyle(fontSize: 14.0, color: Color(0XFF394D6F))
                                                    ),
                                                ]
                                            ),
                                            SizedBox(
                                                height: 19.0,
                                            ),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget> [
                                                    Text(
                                                        'Last Education',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Color(0XFF5D6D89)
                                                        )
                                                    ),
                                                     SizedBox(
                                                        height: 8.0,
                                                    ),
                                                    TextField(
                                                        controller: _lastEducationController,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                            hintText: "Input Last Education",
                                                            hintStyle: TextStyle(fontSize: 14.0, color: Color(0XFFA5AEBD))
                                                        ),
                                                        style: TextStyle(fontSize: 14.0, color: Color(0XFF394D6F))
                                                    ),
                                                ]
                                            ),
                                            SizedBox(
                                                height: 19.0,
                                            ),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget> [
                                                    Text(
                                                        'Address',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Color(0XFF5D6D89)
                                                        )
                                                    ),
                                                     SizedBox(
                                                        height: 8.0,
                                                    ),
                                                    TextField(
                                                        controller: _addressController,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            ),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                            hintText: "Input Address",
                                                            hintStyle: TextStyle(fontSize: 14.0, color: Color(0XFFA5AEBD))
                                                        ),
                                                        style: TextStyle(fontSize: 14.0, color: Color(0XFF394D6F))
                                                    ),
                                                ]
                                            ),
                                            SizedBox(
                                                height: 40.0,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFF20BF6B),
                                                    elevation: 0.0,
                                                    minimumSize: const Size.fromHeight(40), 
                                                ),
                                                onPressed: _postData,
                                                child: isLoading 
                                                ? Center(child:CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                    strokeWidth: 3.0,
                                                ))
                                                : Text(
                                                    'Save',
                                                    style: TextStyle(fontSize: 14),
                                                ),
                                            ),
                                            SizedBox(
                                                height: 10.0,
                                            ),
                                        ]
                                    ),
                                ),
                            ),
                        ]
                    )
                )
            )
        ),
        );
    }
}