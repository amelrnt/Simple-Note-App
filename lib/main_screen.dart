import 'package:flutter/material.dart';
import 'package:dicoding_submission/detail_screen.dart';
import 'package:dicoding_submission/notes.dart';

class MainScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return NoteList();
  }
}

class NoteList extends StatefulWidget {
  const NoteList({ Key? key }) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  @override
  void initState() {
    super.initState();
    //notesList = <Notes>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final Notes notes = notesList[index];
                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            _notesStatus(context,notes,index);
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                notes.title,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                notes.notes,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //elevation: 1.0,
                );
              },  
              itemCount : notesList.length,
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          var result = await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => new DetailScreen(),
            )
          );
          if (result[0] == '1') {
            setState(() => notesList.add(result[1]));
            final snackBar = SnackBar(
            content: Text('New Notes Saved'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (result[0] == '0') {
            final snackBar = SnackBar(
            content: Text('Notes unsaved'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('New Notes',),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  void _notesStatus(BuildContext context, Notes notes, int index) async {
    
    var result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => new DetailScreen(note: notes, index: index),
      )
    );

    if (result[0] == '1') {
      setState(() => notesList[index] = result[1]);
      final snackBar = SnackBar(
        content: Text('Notes Edited'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if(result[0] == '0'){
      setState(() => notesList.remove(notes));
      final snackBar = SnackBar(
        content: Text('Notes Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() => notesList.add(notes));
            final snackBar = SnackBar(
              content: Text('Undo Deleting Notes'),
              );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  
}