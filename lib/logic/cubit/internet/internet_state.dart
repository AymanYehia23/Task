part of 'internet_cubit.dart';

@immutable
sealed class InternetState {}

final class InternetInitial extends InternetState {}

class ConnectedState extends InternetState {}

class NotConnectedState extends InternetState {}
