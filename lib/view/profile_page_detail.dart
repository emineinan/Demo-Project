import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class ProfilePageDetail extends StatefulWidget {
  ProfilePageDetail({Key key}) : super(key: key);

  @override
  _ProfilePageDetailState createState() => _ProfilePageDetailState();
}

class _ProfilePageDetailState extends State<ProfilePageDetail> {
  PickedFile imageFile;
  final ImagePicker picker = ImagePicker();
  var addressvisibility = false;
  Position position;
  // ignore: cancel_subscriptions
  StreamSubscription<Position> streamSubscription;
  Address address;

  @override
  void initState() {
    super.initState();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    streamSubscription = Geolocator()
        .getPositionStream(locationOptions)
        .listen((Position position) {
      setState(() {
        print(position);
        position = position;
        final coordinates =
            new Coordinates(position.latitude, position.longitude);
        convertCoordinatesToAddress(coordinates)
            .then((value) => address = value);
      });
    });
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 60, top: 25, right: 60),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            buildCenter(context),
            SizedBox(
              height: 35,
            ),
            buildRaisedButtonforLocation(),
            SizedBox(
              height: 20,
            ),
            addressvisibility
                ? Container(
                    height: 50.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Text("${address.addressLine}"))
                : Text("")
          ],
        ),
      ),
    );
  }

  Center buildCenter(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: buildBoxDecoration(context),
          ),
          buildPositioned(context),
        ],
      ),
    );
  }

  Positioned buildPositioned(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3, color: Colors.white),
            color: Color.fromARGB(255, 231, 75, 35),
          ),
          child: buildInkWellCamera(context),
        ));
  }

  InkWell buildInkWellCamera(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context, builder: ((builder) => bottomSheet()));
      },
      child: Icon(
        Icons.camera_alt,
        color: Colors.white,
      ),
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
        border: Border.all(
            width: 3, color: Theme.of(context).scaffoldBackgroundColor),
        boxShadow: [
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 10))
        ],
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: imageFile == null
              ? AssetImage("images/user.jpg")
              : FileImage(File(imageFile.path)),
        ));
  }

  RaisedButton buildRaisedButtonforLocation() {
    return RaisedButton(
      onPressed: () {
        addressvisibility = true;
      },
      color: Color.fromARGB(255, 231, 75, 35),
      child: Text(
        "GET LOCATION",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  bottomSheet() {
    return Container(
      height: 80.0,
      margin: EdgeInsets.symmetric(horizontal: 70.0, vertical: 5.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              flatButtonCamera(),
              SizedBox(
                width: 15,
              ),
              flatButtonPhotos(),
            ],
          )
        ],
      ),
    );
  }

  FlatButton flatButtonPhotos() {
    return FlatButton.icon(
        onPressed: () {
          takePhoto(ImageSource.gallery);
        },
        icon: Icon(
          Icons.photo,
        ),
        label: Text(
          "Photos",
          style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 231, 75, 35),
          ),
        ));
  }

  FlatButton flatButtonCamera() {
    return FlatButton.icon(
        onPressed: () {
          takePhoto(ImageSource.camera);
        },
        icon: Icon(Icons.camera_alt),
        label: Text("Camera",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 231, 75, 35),
            )));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile;
    });
  }
}
