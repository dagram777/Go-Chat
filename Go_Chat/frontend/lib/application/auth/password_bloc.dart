import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';


class PassBloc extends Bloc<PassEvent,PassState>{
  PassBloc() : super(Obscure()){
  on<PassEvent>(_changePasswordState);}

  bool isObscure=true;
 
  void _changePasswordState(PassEvent event, Emitter emitter){
    
    if (isObscure==true){
      isObscure=!isObscure;
      emitter(Visible());
    }
    else if(isObscure==false){
      isObscure=!isObscure;
      emitter(Obscure());
    }
   
    
  }
}