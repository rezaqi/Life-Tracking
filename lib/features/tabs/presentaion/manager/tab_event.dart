abstract class TabsEvent {}

class OnTabEvent extends TabsEvent {
  final int index;

  OnTabEvent({required this.index});
}
