import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/repos/AuthRepo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class FinishApprovalScreen extends StatefulWidget {
  @override
  _FinishApprovalScreenState createState() => _FinishApprovalScreenState();
}

class _FinishApprovalScreenState extends State<FinishApprovalScreen> {
  final AuthRepo repo = AuthRepo();
  List<File> files = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Pending status ',
                  style: TextStyle(
                      fontFamily: 'Lato Bold',
                      fontSize: 30,
                      color: Color(0xFF4D525D)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: AuthRepo().howMuchCanIUpload(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Text('Network error try again');
                  } else if (snapShot.hasData) {
                    if (snapShot.data == 0) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Center(
                            child: Text(
                              'You have Uploaded the maximum files allowed ,'
                              'Plase Wait till we verify your identity,'
                              'it usaly takes 24 hours',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xD94D525D)),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 10, bottom: 20),
                            child: Text(
                              'you can upload ${snapShot.data} Files more to verify your identity',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xD94D525D)),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              child: Text(
                                'pick files',
                                style: TextStyle(
                                    fontSize: 25, color: Color(0xFF528EFD)),
                              ),
                            ),
                            onTap: () async {
                              files = await FilePicker.getMultiFile(
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'jpeg', 'png'],
                              );
                              if (files == null) {
                                files = [];
                              }
                              if (files.length > 0) {
                                while (files.length > snapShot.data) {
                                  files.removeAt(files.length - 1);
                                }
                                setState(() {});
                              }
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              return FileItem(p.basename(files[index].path));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Visibility(
                              child: InkWell(
                                child: Container(
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                        fontSize: 25, color: Color(0xFF528EFD)),
                                  ),
                                ),
                                onTap: () async {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    bool done = await AuthRepo()
                                        .uploadFiles(documents: files);
                                    if (done) {
                                      Fluttertoast.showToast(msg: 'Done');
                                      setState(() {
                                        isLoading = false;
                                        files = [];
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Plase try agian later ');
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  } catch (e) {
                                    print(e);
                                    Fluttertoast.showToast(
                                        msg: 'Plase try agian later ');
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                              ),
                              visible: files.length > 0,
                            ),
                          )
                        ],
                      );
                    }
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final String fileName;

  FileItem(this.fileName);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text(
            fileName,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
