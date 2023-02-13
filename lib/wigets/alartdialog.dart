import 'package:flutter/material.dart';

final alartDialog= AlertDialog(
title: Text('Congratulations!'),           // To display the title it is optional
content: Text('Workout Sucessfull'),   // Message which will be pop up on the screen
// Action widget which will provide the user to acknowledge the choice
actions: [

TextButton(

onPressed: () {},
child: Text('Ok'),
),
],
);