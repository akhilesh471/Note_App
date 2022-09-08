import 'package:get/get.dart';
import 'package:noteapp/model/noteapp_model.dart';

class NoteAppController extends GetxController {
  List<NoteAppModel> noteList = [];
  void addNotes({required NoteAppModel model}) {
    noteList.add(model);
    update();
  }
}
