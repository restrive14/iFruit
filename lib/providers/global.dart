import 'package:flutter/foundation.dart';

class GlobalProvider extends ChangeNotifier {
  String? _selectedRoute;
  String? get selectedRoute => _selectedRoute;
  String _title = '电子邮件';
  String get title => _title;

  void setTopTitle(String title) {
    if (_title != title) {
      _title = title;
      notifyListeners();
    }
  }

  void setSelectedRoute(String? route) {
    if (_selectedRoute != route) {
      _selectedRoute = route;
    }
  }

  void clearSelectedRoute() {
    if (_selectedRoute != null) {
      _selectedRoute = null;
    }
  }
}
