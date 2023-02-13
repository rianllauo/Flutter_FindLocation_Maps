import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// import 'package:dropdown_search/dropdown_search.dart';

class FindLocation extends StatefulWidget {
    @override
    _FindLocationState createState() => _FindLocationState();
}

class _FindLocationState extends State<FindLocation> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Geolocator geolocator = Geolocator();

    final countryController = TextEditingController();
    final stateController = TextEditingController();
    final cityController = TextEditingController();

    String _country = '';
    String _state = '';
    String _city = '';

    LatLng? _center ;


    late final MapController _mapController;

    CustomPoint _textPos = const CustomPoint(10.0, 10.0);

    @override
    void initState() {
        super.initState();
        _mapController = MapController();
        setState((){

            _center = LatLng(-6.17018, 106.640324);
        });
    }

    void _showModal() {
        showDialog(
            context: context,
            builder: (context) {
            return AlertDialog(
                content: Container(
                height: 300,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                            Image.asset(
                                'assets/images/path1.png',
                                fit: BoxFit.cover,
                                width: 150.0,
                                height: 140.0,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                                'Success',
                                style: TextStyle(color: Color(0xFF394D6F), fontSize: 16.0 , fontWeight: FontWeight.w500), 
                            ),
                            SizedBox(height: 14.0),
                            Text(
                                'Find Location Test is Succsess',
                                style: TextStyle(color: Color(0xFF5D6D89), fontSize: 12.0 , fontWeight: FontWeight.w500), 
                            ),
                            SizedBox(height: 14.0),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF20BF6B),
                                    elevation: 0.0,
                                    minimumSize: const Size.fromHeight(40), 
                                ),
                                onPressed: (){
                                    Navigator.pushNamed(context, '/');
                                },
                                child: 
                                 Text(
                                    'Back to home',
                                    style: TextStyle(fontSize: 14),
                                ),
                            ),
                        ]
                    ),
                ),
                ),
            );
            },
        );
    }
  
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: 
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [],
                    ),
                        child: 
                        Column(
                            children: <Widget> [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget> [
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: Icon(
                                                    Icons.place,
                                                    color: Color(0xFF20BF6B),
                                                    size: 20.0,
                                            ),
                                            onPressed: () {
                                                Navigator.pushNamed(context, '/');
                                            }
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                            'Find Location',
                                            style: TextStyle(color: Color(0xFF20BF6B), fontSize: 16.0 , fontWeight: FontWeight.w500), 
                                        ),
                                    ]
                                
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                    child: Form(
                                        key: _formKey,
                                        child: Column(
                                            children: <Widget> [
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget> [
                                                        Text(
                                                            'Country',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Color(0XFF5D6D89)
                                                            )
                                                        ),
                                                        SizedBox(
                                                            height: 8.0,
                                                        ),

                                                        TextField(
                                                            // controller: _fullNameController,
                                                            controller: countryController,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                ),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                                hintText: "Search Country",
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
                                                            'State',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Color(0XFF5D6D89)
                                                            )
                                                        ),
                                                        SizedBox(
                                                            height: 8.0,
                                                        ),
                                                        TextField(
                                                            // controller: _phoneNumberController,
                                                            // keyboardType: TextInputType.number,
                                                            controller: stateController,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                ),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                                hintText: "Search State",
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
                                                            'City',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Color(0XFF5D6D89)
                                                            )
                                                        ),
                                                        SizedBox(
                                                            height: 8.0,
                                                        ),
                                                        TextField(
                                                            // controller: _lastEducationController,
                                                            controller: cityController,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Color(0XFFEDEEF1)),
                                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                ),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                                                                hintText: "Search City",
                                                                hintStyle: TextStyle(fontSize: 14.0, color: Color(0XFFA5AEBD))
                                                            ),
                                                            style: TextStyle(fontSize: 14.0, color: Color(0XFF394D6F))
                                                        ),
                                                    ]
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Color(0xFF20BF6B),
                                                        elevation: 0.0,
                                                    ),
                                                    onPressed: () {
                                                        assert(_formKey.currentState != null);
                                                        _formKey.currentState?.save();
                                                        _getLocation();
                                                    },
                                                    child: Text(
                                                        'Find Maps',
                                                        style: TextStyle(fontSize: 14),
                                                    ),
                                                ),
                                                SizedBox(
                                                    height: 20.0,
                                                ),
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget> [
                                                        Text(
                                                            'Map View',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Color(0XFF5D6D89)
                                                            )
                                                        ),
                                                        SizedBox(
                                                            height: 8.0,
                                                        ),
                                                        Container(
                                                            width: double.infinity,
                                                            height: 200,
                                                            decoration: BoxDecoration(
                                                                color: Colors.transparent,
                                                                border: Border.all(color: Color(0XFFECECEC), width: 1.0),
                                                                borderRadius: BorderRadius.circular(20.0),
                                                            ),
                                                            child: 
                                                            FlutterMap(
                                                                mapController: _mapController,
                                                                options: MapOptions(
                                                                // onMapEvent: onMapEvent,
                                                                onTap: (tapPos, latLng) {
                                                                    final pt1 = _mapController.latLngToScreenPoint(latLng);
                                                                    _textPos = CustomPoint(pt1!.x, pt1.y);
                                                                    setState(() {});
                                                                },
                                                                center: _center,
                                                                zoom: 13,
                                                                rotation: 0,
                                                                ),
                                                                children: [
                                                                TileLayer(
                                                                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                                                                ),
                                                                ],
                                                            ),
                                                        ),
                                                    ]
                                                ),

                                                SizedBox(
                                                    height: 25.0,
                                                ),
                                                Row(
                                                    children: <Widget> [
                                                        Expanded(
                                                            child: OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                    side: BorderSide(color: Color(0xFF20BF6B), width: 1),
                                                                ),
                                                                onPressed: () {Navigator.pushNamed(context, '/');},
                                                                child: Text(
                                                                    'Cancle',
                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF20BF6B)),
                                                                ),
                                                            ),
                                                        ),
                                                        SizedBox(
                                                            width: 8.0,
                                                        ),
                                                        Expanded(
                                                            child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    primary: Color(0xFF20BF6B),
                                                                    elevation: 0.0,
                                                                ),
                                                                onPressed: _showModal,
                                                                child: Text(
                                                                    'Save',
                                                                    style: TextStyle(fontSize: 14),
                                                                ),
                                                            ),
                                                        ),
                                                    ]
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
                ),
            )
        ),
        );
    }

    void _getLocation() async {
        setState(() {
            _city = cityController.text;
            _state = stateController.text;
            _country = countryController.text;
        });
        
        final address = "$_city, $_state, $_country";
        List<Location> locations = await locationFromAddress(address);;
        print(locations);
        
        setState(() {
            _center = LatLng(-6.17018, 106.640324);
        });

        print(_center);
    }
}