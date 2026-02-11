part of 'add_new_card_cubit.dart';

sealed class AddNewCardState {}

final class AddNewCardInitial extends AddNewCardState {}

final class AddNewCardLoading extends AddNewCardState {}

final class AddNewCardSuccessLoaded extends AddNewCardState {}

final class AddNewCardFailure extends AddNewCardState {
  final String errMsg;

  AddNewCardFailure({required this.errMsg});
}

// final class PaymentMethodsFetching extends AddNewCardState {}

// final class PaymentMethodsFetched extends AddNewCardState {
//   final List<PaymentCardModel> paymentCards;
//   PaymentMethodsFetched({required this.paymentCards});
// }

// final class FetchPaymentMethodsError extends AddNewCardState {
//   final String errMsg;

//   FetchPaymentMethodsError({required this.errMsg});
// }
