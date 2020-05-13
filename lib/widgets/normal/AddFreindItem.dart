import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/repos/normal_repo.dart';

class AddFriendItem extends StatefulWidget {
  final int index;
  final UserEntity userEntity;

  AddFriendItem({this.userEntity, this.index});

  @override
  _AddFriendItemState createState() => _AddFriendItemState();
}

class _AddFriendItemState extends State<AddFriendItem> {
  Widget actionButton  = CircularProgressIndicator();
  NormalRepo repo ;


  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text(
              "Are you sure you wana delete ${widget.userEntity.name} from friends List"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                setState(() {
                  actionButton = CircularProgressIndicator();
                });
                await NormalRepo().deleteHeMyFriend(id: widget.userEntity.uid);
                Navigator.of(context).pop();
                whatCanIdo();

              },
            ),
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void whatCanIdo() async {
    bool isMyFriend = await repo.isHeMyFriend(id: widget.userEntity.uid);
    if(isMyFriend){
      actionButton =  IconButton(
        icon: Icon(
          FontAwesomeIcons.userCheck,
          color: Color(0xff7CDE86),
        ),
        onPressed: ()async{
          _showDialog();
        },
      );
    }else{
  bool doISendHimAFriendReq = await NormalRepo()
      .doISendHimAFriendReqBefore(id: widget.userEntity.uid);
      if(doISendHimAFriendReq){
        actionButton =  IconButton(
          icon: Icon(
            FontAwesomeIcons.userTimes,
            color: Colors.red,
          ),
          onPressed: ()async{
            // cancel friend req
            setState(() {
              actionButton = CircularProgressIndicator();
            });
             await NormalRepo()
                .cancelFriendReq(id: widget.userEntity.uid);
            whatCanIdo();

          },

        );
  }else{
        actionButton =  IconButton(
          icon: Icon(
            FontAwesomeIcons.userPlus,
            color: Color(0xff7CDE86),
          ),
          onPressed: ()async{
            // make friend req
            setState(() {
              actionButton = CircularProgressIndicator();
            });
            await NormalRepo()
                .sendFriendRequest(id: widget.userEntity.uid);
            whatCanIdo();
          },
        );
      }









    }
    setState(() {

    });

// end





  }



  @override
  void initState() {
    repo = NormalRepo();
    whatCanIdo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '${widget.index + 1}',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 20,
                color: Color(0xFF787878)),
          ),
          SizedBox(
            width: 13,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              widget.userEntity.profilePic,
              width: 73,
              height: 73,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${widget.userEntity.name} ,${widget.userEntity.age}',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato Bold',
                      color: Color(0xFF151515)),
                ),
                Text(
                  '${widget.userEntity.district} ,Ukraine',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato Regular',
                      color: Color(0xFF636363)),
                )
              ],
            ),
          ),
          actionButton
        ],
      ),
    );
  }
}

