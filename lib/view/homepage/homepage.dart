import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/controller/noteapp_controller.dart';
import 'package:noteapp/core/colors.dart';
import 'package:noteapp/core/size.dart';
import 'package:noteapp/model/noteapp_model.dart';
import 'package:noteapp/view/homepage/widgets.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final NoteAppController noteAppController = Get.put(NoteAppController());
  final formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.note_alt_outlined),
        title: const Text("Note App"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            kheight10,
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  (noteAppController.noteList.isEmpty)
                      ? const SizedBox()
                      : const SideTitle(text: 'List Notes', size: 16),
                ],
              ),
            ),
            kheight10,
            Expanded(
              child: SizedBox(
                // height: 600,
                child: GetBuilder<NoteAppController>(
                    init: NoteAppController(),
                    builder: (controller) {
                      final data = controller.noteList;
                      return (data.isEmpty)
                          ? const Center(
                              child:SideTitle(text: 'Please Add Data', size: 20)
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                      bottom: 10,
                                      top: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: colors[index % 6],
                                        border: Border.all(
                                            width: 1, color: Colors.amber),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    width: size.width * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Data(
                                              text: data[index].title,
                                              size: 18,
                                              weight: FontWeight.bold),
                                          kheight10,
                                          Data(
                                              text: data[index].description,
                                              size: 15,
                                              weight: FontWeight.normal),
                                          kheight20,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Data(
                                                  text: data[index].date,
                                                  size: 12,
                                                  weight: FontWeight.normal),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void openBottomSheet() {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                kheight20,
                const Center(
                  child: Text(
                    'ADD NOTES',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                kheight20,
                AddTextField(
                    hintText: 'Title',
                    maxLines: 1,
                    controller: _titleController),
                kheight10,
                AddTextField(
                  hintText: 'Description',
                  maxLines: 2,
                  controller: _descriptionController,
                ),
                kheight10,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Close'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          submitData();
                        },
                        child: const Text('Submit'),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void submitData() {
    final model = NoteAppModel(
        title: _titleController.text,
        description: _descriptionController.text,
        date:DateFormat.yMd().format(DateTime.now()).toString() );
    if (formkey.currentState!.validate()) {
      noteAppController.addNotes(model: model);
      _titleController.clear();
      _descriptionController.clear();
      Get.back();
      Get.snackbar('Note App', "Data Added Succesfuly",
          backgroundColor: Colors.amber);
    }
  }
}

