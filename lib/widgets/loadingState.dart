
import 'package:flutter/material.dart';


abstract class LoadingState<T extends StatefulWidget> extends State<T> {

  bool _isLoading = true;

  void switchLoadStatus(bool isLoading) {
    if (_isLoading != isLoading) {
      setState(() {
        _isLoading = isLoading ;
      });
    }
  }

  Widget loadingBuild(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget loadedBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return loadingBuild(context);
    }
    return loadedBuild(context);
  }
}
