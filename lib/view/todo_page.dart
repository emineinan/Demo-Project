import 'package:demo_project/constants/input_decoration.dart';
import 'package:demo_project/model/item.dart';
import 'package:demo_project/utils/db_helper.dart';
import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  ToDoPage({Key key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Item> allItems = new List<Item>();
  bool isActive = false;
  var _controllerTodo = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  int clickedItemID;

  void getItems() async {
    var itemFuture = _databaseHelper.getAllItems();
    await itemFuture.then((data) {
      setState(() {
        this.allItems = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do Page"),
        backgroundColor: Color.fromARGB(255, 231, 75, 35),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    buildForm(_controllerTodo, "Todo"),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton(
                    "SAVE", Color.fromARGB(255, 231, 75, 35), saveObject),
                buildButton(
                    "UPDATE", Color.fromARGB(255, 231, 75, 35), updateObject),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _controllerTodo.text = allItems[index].todo;
                              clickedItemID = allItems[index].id;
                            });
                          },
                          title: Text(allItems[index].todo),
                          trailing: GestureDetector(
                            onTap: () {
                              _deleteItem(allItems[index].id, index);
                            },
                            child: Icon(Icons.delete),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  buildForm(TextEditingController textEditingController, String str) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: false,
        controller: textEditingController,
        decoration: textInputDecoration.copyWith(hintText: "ToDo Item"),
        // InputDecoration(labelText: str, border: OutlineInputBorder()),
      ),
    );
  }

  buildButton(String str, Color buttonColor, Function eventFunc) {
    return RaisedButton(
      onPressed: eventFunc,
      child: Text(
        str,
        style: TextStyle(color: Colors.white),
      ),
      color: buttonColor,
    );
  }

  void updateObject() {
    if (clickedItemID != null) {
      if (_formKey.currentState.validate()) {
        _updateItem(Item.withId(clickedItemID, _controllerTodo.text));
      } else {
        showAlertDialog();
      }
    }
  }

  void saveObject() {
    if (_formKey.currentState.validate()) {
      _addItem(Item(_controllerTodo.text));
    }
  }

  //CRUD METHODS
  void _addItem(Item item) async {
    await _databaseHelper.insert(item);
    setState(() {
      getItems();
      _controllerTodo.text = "";
    });
  }

  void _updateItem(Item item) async {
    await _databaseHelper.update(item);
    setState(() {
      getItems();
      _controllerTodo.text = "";
      clickedItemID = null;
    });
  }

  void _deleteItem(int deletedID, int deletedIndex) async {
    await _databaseHelper.delete(deletedID);
    setState(() {
      getItems();
    });
  }

  void showAlertDialog() {
    AlertDialog alertDialog = AlertDialog(
      title: Text("There is no selected item!"),
      content: Text("Please enter a item to list for updating list."),
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}
