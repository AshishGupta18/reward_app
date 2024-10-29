import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coin_event.dart';
part 'coin_state.dart';

class CoinBlocBloc extends Bloc<CoinBlocEvent, CoinBlocState> {
  CoinBlocBloc() : super(CoinBlocInitial()) {
    on<CoinBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
