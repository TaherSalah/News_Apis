import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_apis/shared/cubit/cubit.dart';
import 'package:news_apis/shared/cubit/states.dart';

import '../../shared/components/component.dart';

class BusinessNews extends StatelessWidget {
  const BusinessNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state)=>{},
    builder: (context,state){
      var list =NewsCubit.get(context).business;
      return articlesBuilderItems(list, context);
    }

    );
  }
}
