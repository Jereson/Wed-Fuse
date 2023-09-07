import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../getit.dart';
import '../../../utils/base_view_builder.dart';
import '../../../utils/constant_utils.dart';
import '../../../viewModel/profile_vm.dart';


class TextStory extends StatefulWidget {
  const TextStory( {Key? key, required this.users}) : super(key: key);
  final List users;


  @override
  State<TextStory> createState() => _TextStoryState();
}

class _TextStoryState extends State<TextStory> {
  String picture=profileAvaterUrl;

  PlatformFile? selectedPdf;
  UploadTask? uploadTask;
  UploadTask? loadTask;
  bool load = false;
  final TextEditingController _messageTitleController = TextEditingController();

  Color _selectedColor = Colors.red;
  FontStyle _selectedFontStyle = FontStyle.normal;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageTitleController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
        return Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: InkWell(

                  onTap: () async {

                  load==false?load=true:load=false;
                  if(_messageTitleController.text.isEmpty){

                  }else {
                    setState(() {
                      load = true;
                    });
                    await FirebaseFirestore.instance.collection(
                        "status").add({
                      "id": _messageTitleController.text.trim(),
                      "color": _selectedColor.value,
                      "profilePix": pVm.cachedUserDetail!.photoUrl!,
                      "imgUrl": "",
                      "friends":widget.users
                    });
                    setState(() {
                      load = false;
                    });
                    _messageTitleController.clear();
                  }},child: load==false? Image.asset("assets/images/img_3.png",scale: 1,):const CircularProgressIndicator(backgroundColor: Colors.red,),),
              ),
            ],
          ),
          backgroundColor: _selectedColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBar(
                    backgroundColor: _selectedColor,
                    elevation: 0,
                    leading: TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("X",style: TextStyle(color: Colors.white,fontSize: 20),)),
                    actions: [
                      DropdownButton<FontStyle>(
                        dropdownColor: Colors.white,
                        isExpanded: false,
                        icon: const Text("B",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
                        items: const [
                          DropdownMenuItem(
                            value: FontStyle.normal,
                            child: Text('Normal'),
                          ),
                          DropdownMenuItem(
                            value: FontStyle.italic,
                            child: Text('Italic'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedFontStyle = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 10,),
                      DropdownButton<Color>(
                        alignment: Alignment.bottomLeft,
                        dropdownColor: Colors.white,
                        icon: Container(
                          height: 19,
                          width: 16,
                          decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/img_2.png"))
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: Colors.red,
                            child: Text('Red'),
                          ),
                          DropdownMenuItem(
                            value: Colors.orange,
                            child: Text('Orange'),
                          ),
                          DropdownMenuItem(
                            value: Colors.grey,
                            child: Text('grey'),
                          ),
                          DropdownMenuItem(
                            value: Colors.green,
                            child: Text('Green'),
                          ),
                          DropdownMenuItem(
                            value: Colors.blue,
                            child: Text('Blue'),
                          ),
                          DropdownMenuItem(
                            value: Colors.yellow,
                            child: Text('Yellow'),
                          ),
                          DropdownMenuItem(
                            value: Colors.purple,
                            child: Text('Purple'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedColor = value!;
                          });
                        },
                      ),

                    ],
                  ),
                  const Expanded(
                      flex: 1,
                      child: Text("")),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [

                        Flexible(
                          flex: 4,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _messageTitleController,
                                keyboardType: TextInputType.multiline,
                                autocorrect: true,
                                maxLines: 10,
                                style: TextStyle(
                                    fontStyle: _selectedFontStyle,
                                    fontSize: 40, color: Colors.white
                                ),
                                decoration: const InputDecoration(
                                    hintText: "Type your status",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                              )
                          ),
                        ),


                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }


}
