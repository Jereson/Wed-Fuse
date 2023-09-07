import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/profile_vm.dart';

class AddImageScreen extends StatefulWidget {
  final int? imageLength;
  const AddImageScreen({super.key, required this.imageLength});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Add Image'),
                actions: [
                  ElevatedButton(
                      onPressed: () => pVm.updateBanner(context,widget.imageLength!),
                      child: const Text(
                        'upload',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: GridView.builder(
                        itemCount: pVm.pickedUpdateBanner.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                                  child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => pVm.pickUpdateBanner(
                                          context, widget.imageLength!)),
                                )
                              : Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(File(pVm
                                                  .pickedUpdateBanner[index - 1]
                                                  .path)),
                                              fit: BoxFit.cover)),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Transform.translate(
                                          offset: const Offset(10, 10),
                                          child: IconButton(
                                            onPressed: () =>pVm.unPickUpdateBanner(index),
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ))
                                  ],
                                );
                        }),
                  ),
                  // uploading ? Center(child: loader()) : Container(),
                ],
              ));
        });
    ;
  }
}
