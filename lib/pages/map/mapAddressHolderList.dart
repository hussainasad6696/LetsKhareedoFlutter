import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/constants/size_config.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'package:letskhareedo/device_db/userAddresses/mapDetailModel.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';


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
          child: CustomAppBar(s: "MapList", drawerButtonClicked: (check){
            if(!check)
              Navigator.pop(context);
          },)),
      body: Center(
        child: Column(
          children: [
            Flexible(
                flex: 7,
                child: dbFutureHandler()),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () =>
                          navigateToMapPage()
                        ,
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
            )
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
            shrinkWrap: true,
              itemCount: snapShot.data.length,
              itemBuilder: (context, index) {
                return addressCard(snapShot.data[index], index);
              });
        }else return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget addressCard(MapDetail data, int index) {
    IconData _icons;
    if(data.label == "Home") {
      _icons = Icons.home_outlined;
    }else if(data.label == "Work") _icons = Icons.work_outline_outlined;
    else if(data.label == "Partner") _icons = Icons.favorite_border;
    else if(data.label == "Other") _icons = Icons.location_on_outlined;
    return  Card(
      child: ListTile(
        leading: Column(
          children: [
            Icon(Icons.location_on_outlined, color: kPrimaryColor,),
            SizedBox(height: 6,),
            Icon(_icons, color: kPrimaryColor,),
          ],
        ),
        title: Text('${data.addressLine}', style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(
            'Floor: ${data.floorNumber}'
        ),
        trailing: Column(
          children: [
            GestureDetector(
                onTap: (){
                  Dialogs.materialDialog(
                      msg: 'Are you sure ? you can\'t undo this',
                      title: "Delete",
                      color: Colors.white,
                      context: context,
                      actions: [
                        IconsOutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                          iconData: Icons.cancel_outlined,
                          textStyle: TextStyle(color: Colors.grey),
                          iconColor: Colors.grey,
                        ),
                        IconsButton(
                          onPressed: () {
                             HiveMethods().deleteMapDataFromList(index);
                             Navigator.pop(context);
                             setState(() {

                             });
                          },
                          text: 'Delete',
                          iconData: Icons.delete,
                          color: Colors.red,
                          textStyle: TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                        ),
                      ]);
                },
                child: Icon(Icons.delete_outline, color: kPrimaryColor,)),
            SizedBox(
              height: 6,
            ),
            // GestureDetector(
            //     onTap: (){
            //       Navigator.pushNamed(context, '/map',
            //       arguments: {
            //         "floorNumber" : data.floorNumber,
            //         "label" : data.label,
            //         "addressLine" : data.addressLine,
            //         "longitude" : data.longitude,
            //         "latitude" : data.latitude,
            //         "city" : data.city,
            //         "index" : index
            //       });
            //     },
            //     child: Icon(Icons.edit_location_outlined, color: kPrimaryColor,))
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  navigateToMapPage() async {
    var back = await Navigator.pushNamed(context, '/map');
    setState(() {
      print("$back");
    });
  }

}
