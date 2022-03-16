
import 'package:flutter/material.dart';
import 'package:graduation/backend/repositary.dart';
import 'package:graduation/models/user.dart';

class GridTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Repository.repository.appUser.type == userType.docotr ?
    GridTile(
      child: Image.network(Repository.repository.appUser.logo),
      footer: Text(Repository.repository.appUser.userName),
    ) : 
    Container();
  }
}