import 'package:abd_allah_shop_app/ShopApp/Search/cubit.dart';
import 'package:abd_allah_shop_app/ShopApp/Search/states.dart';
import 'package:abd_allah_shop_app/ShopApp/Shared/Component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        defaultFormText(
                          control: searchController,
                          type: TextInputType.text,
                          onSubmit: (String? value ){
                              SearchCubit.get(context).search(value!);
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter text to search';
                            }
                          },
                          label: 'Search',
                          prefix: Icons.search,
                        ),
                        SizedBox(height: 10,),
                        if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                        SizedBox(height: 10,),
                        if(state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildFivItem(
                                  SearchCubit.get(context).model!.data?.data[index],
                                  context,
                                  isOldPrice: false
                              );
                            },
                            separatorBuilder: (context, index) {
                              return dividerWidget();
                            },
                            itemCount: SearchCubit.get(context).model!.data!.data.length,
                          ),
                        ),

                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
