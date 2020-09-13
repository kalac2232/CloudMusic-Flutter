import 'package:cloudmusic/commen/only_text_pager.dart';
import 'package:cloudmusic/discovery/bloc/cubit/mini_player_bloc.dart';
import 'package:cloudmusic/discovery/bloc/event/commen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerPager extends StatefulWidget {
  @override
  _PlayerPagerState createState() => _PlayerPagerState();
}

class _PlayerPagerState extends State<PlayerPager> {

  @override
  void initState() {
    super.initState();
    print("initState");
    context.bloc<MiniPlayerBloc>().add(MiniPlayerWidgetControlEvent.gone);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.greenAccent,
        child: GestureDetector(
            child: Text("播放器页"),
          onTap: (){
              //Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_){
                  return OnlyTextPage(text: "kong",);
                }
              ));
          },
        ),
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();

  }

  @override
  void deactivate() {
    context.bloc<MiniPlayerBloc>().add(MiniPlayerWidgetControlEvent.visible);
    print("deactivate");
    super.deactivate();
  }
}
