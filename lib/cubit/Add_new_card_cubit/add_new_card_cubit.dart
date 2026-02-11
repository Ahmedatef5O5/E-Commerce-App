import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

  void addNewCard(
    String cardNumber,
    String cardHolderName,
    String expirtyDate,
    String cvvCode,
  ) {
    emit(AddNewCardLoading());
    final newCard = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expirtyDate: expirtyDate,
      cvv: cvvCode,
    );
    Future.delayed(Duration(seconds: 1), () {
      dummyPaymentCards.add(newCard);
      emit(AddNewCardSuccessLoaded());
    });
  }
}
