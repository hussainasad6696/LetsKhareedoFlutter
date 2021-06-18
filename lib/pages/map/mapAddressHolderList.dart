import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'package:letskhareedo/device_db/userAddresses/mapDetailModel.dart';


class SavedMapList extends StatefulWidget {
  const SavedMapList({Key key}) : super(key: key);

  @override
  _SavedMapListState createState() => _SavedMapListState();
}

class _SavedMapListState extends State<SavedMapList> {
  HiveMethods hiveMethods = HiveMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(
            s: "MapsList",drawerButtonClicked: (check) {
              if(!check) Navigator.pop(context);
          },
          )),
      body: Center(
        child: Column(
          children: [
            Flexible(
                flex: 7,
                child: dbFutureHandler()
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/map');
                        },
                        child: Text(
                          "Add New Address",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(kPrimaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(RADIUS))),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget dbFutureHandler(){
    return FutureBuilder(
      future: hiveMethods.getMeAllMapDetailData(),
      builder: (context,snapShot){
        if(snapShot.hasData) {
          return ListView.builder(
              itemCount: snapShot.data.length,
              itemBuilder: (context, index) {
                return addressCard(snapShot.data[index]);
              });
        }else return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget addressCard(MapDetail data) {
    return Row(
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.location_on_outlined, color: kPrimaryColor,)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(title: Text("${data.houseNumber} ${data.street} ${data.sector}"),),
              Text("Floor number: ${data.floorNumber}"),
              Text("${data.city}"),
              Text("${data.label}")
            ],
          ),
        ),
        IconButton(onPressed: (){}, icon: Icon(Icons.edit_location_outlined, color: kPrimaryColor,)),
        IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline, color: kPrimaryColor,))
      ],
    );
  }

}
