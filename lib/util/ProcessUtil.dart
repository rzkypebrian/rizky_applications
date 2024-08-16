import 'dart:async';

import 'package:flutter/material.dart';

class ProcessUtil  {
  static executor({
    VoidCallback initFunction,
    VoidCallback mainFunction
  }){
     Timer t;
     t = Timer.periodic(Duration(microseconds: 1), (res) {
       if(res.tick == 1){
         initFunction();
       }
       else if(res.tick == 2){
         mainFunction();
       }
       else{
         t.cancel();
       }
     });
  }
}