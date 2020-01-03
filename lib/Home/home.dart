
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:login_flutter_app/Drawer/side_drawer.dart';
import 'package:login_flutter_app/ModalClass/db_wrapper.dart';
import 'package:login_flutter_app/ModalClass/todo_model.dart' as Model;
import 'package:login_flutter_app/UtilityClasses/utility.dart';
import 'package:login_flutter_app/widgets/header.dart';
import 'package:login_flutter_app/widgets/popup.dart';
import 'package:login_flutter_app/widgets/todo.dart';
import 'package:login_flutter_app/widgets/dones.dart';
import 'package:login_flutter_app/widgets/task_input.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(backgroundColor: Color(0xfffff5eb)),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _title = "Home";
  String welcomeMsg;
  //make
  List<Model.Todo> todos;
  List<Model.Todo> dones;

  @override
  void initState() {
    super.initState();
    getTodosAndDones();
    welcomeMsg = Utility.getWelcomeMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text(_title),
//        backgroundColor: Colors.blue,
//      ),
      drawer: SideMenu(
        kuchbhi: (str) {
          setState(() {
            _title = str;
          });
        },
      ),

      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Utility.hideKeyboard(context);
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(_title),
                  background: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Header(
                                      msg: welcomeMsg,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 35),
                                      child: Popup(
                                        getTodosAndDones: getTodosAndDones,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TaskInput(
                                  onSubmitted: addTaskInTodo,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                expandedHeight: 250,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    switch (index) {
                      case 0:
                        return Todo(
                          todos: todos,
                          onTap: markTodoAsDone,
                          onDeleteTask: deleteTask,
                        ); // Active todos
                      case 1:
                        return SizedBox(
                          height: 30,
                        );
                      default:
                        return Done(
                          dones: dones,
                          onTap: markDoneAsTodo,
                          onDeleteTask: deleteTask,
                        ); // Done todos
                    }
                  },
                  childCount: 3,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  //Get ToDos from userDefaults
  void getTodosAndDones() async{
    final _todos = await DBWrapper.sharedInstance.getTodos();
    final _dones = await DBWrapper.sharedInstance.getDones();

    setState(() {
      todos = _todos;
      dones = _dones;
    });
  }

  //Add Task In Todo List

void addTaskInTodo({ @required TextEditingController controller}) {
    final inputText = controller.text.trim();

    if (inputText.length > 0){
      //Add Todos

      Model.Todo todo = Model.Todo(
        title: inputText,
        created: DateTime.now(),
          updated: DateTime.now(),
        status: Model.TodoStatus.active.index,
      );

      DBWrapper.sharedInstance.addTodo(todo);
      getTodosAndDones();
    }else{
      Utility.hideKeyboard(context);
    }
    controller.text = '';
}

  void markTodoAsDone({@required int pos}) {
    DBWrapper.sharedInstance.markTodoAsDone(todos[pos]);
    getTodosAndDones();
  }

  void markDoneAsTodo({@required int pos}) {
    DBWrapper.sharedInstance.markDoneAsTodo(dones[pos]);
    getTodosAndDones();
  }

  void deleteTask({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.deleteTodo(todo);
    getTodosAndDones();
  }

}
