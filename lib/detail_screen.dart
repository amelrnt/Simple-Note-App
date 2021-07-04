import 'package:flutter/material.dart';
import 'package:dicoding_submission/notes.dart';

class DetailScreen extends StatelessWidget {
  final Notes? note;
  final int? index;

  DetailScreen({this.note, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RecordNotes(
          note: note,
          index: index,
          ),
      )
    );
  }
}

class RecordNotes extends StatefulWidget {
  final Notes? note;
  final int? index;

  RecordNotes({this.note,this.index});

  @override
  State<StatefulWidget> createState() => _RecordNotesState();
  
}
  
class _RecordNotesState extends State<RecordNotes> {
  late TextEditingController _controllerTitle = new TextEditingController();
  late TextEditingController _controllerNotes = new TextEditingController();
  late String time =  TimeOfDay.now().format(context);
  late int pointer = 0;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      time = widget.note!.editedAt;
      _controllerTitle = new TextEditingController(text: widget.note!.title);
      _controllerNotes = new TextEditingController(text: widget.note!.notes);
    }
    if (widget.index != null) {
      pointer = widget.index!;
    }
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerNotes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextField(
            maxLines: 1,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: _controllerTitle,
            onChanged: (text) {
              time = TimeOfDay.now().format(context);
            },
          ),
          SizedBox(
            height : 15,
          ),
          TextField(
            maxLines: null,
            autocorrect: true,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Notes and Thoughts',
            ),
            controller: _controllerNotes,
            onChanged: (text) {
              time =  TimeOfDay.now().format(context);
            },
            // add onchange to save current notes in case of exit
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    if (widget.index != null) {
                      Navigator.pop(context, ['1',Notes(
                        notes: _controllerNotes.text, 
                        title: _controllerTitle.text,
                        editedAt: time,
                      )]);
                    }
                    if (widget.note == null) {
                      Navigator.pop(context, ['1',Notes(
                        notes: _controllerNotes.text, 
                        title: _controllerTitle.text,
                        editedAt: time,
                      )]);
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text('Edited at $time'),
                  ),
              ),
              Expanded(
                child:ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, '0');
                  },
                  child: const Text('Delete'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}


