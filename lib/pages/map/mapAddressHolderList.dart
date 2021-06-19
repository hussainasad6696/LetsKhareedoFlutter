import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/constants/size_config.dart';
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
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(context, '/map');
                          });
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
                return addressCard(snapShot.data[index]);
              });
        }else return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget addressCard(MapDetail data) {
    return  Card(
      child: ListTile(
        leading: FlutterLogo(size: 72.0),
        title: Text('${data.addressLine}'),
        subtitle: Text(
            'A sufficiently long subtitle warrants three lines.'
        ),
        trailing: Icon(Icons.more_vert),
        isThreeLine: true,
      ),
    );
  }

}
