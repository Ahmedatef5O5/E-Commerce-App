part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class AddNewCardInitial extends PaymentMethodsState {}

final class AddNewCardLoading extends PaymentMethodsState {}

final class AddNewCardSuccessLoaded extends PaymentMethodsState {}

final class AddNewCardFailure extends PaymentMethodsState {
  final String errMsg;

  AddNewCardFailure({required this.errMsg});
}

final class PaymentMethodsFetching extends PaymentMethodsState {}

final class PaymentMethodsFetched extends PaymentMethodsState {
  final List<PaymentCardModel> paymentCards;
  PaymentMethodsFetched({required this.paymentCards});
}

final class PaymentMethodsFetchError extends PaymentMethodsState {
  final String errMsg;

  PaymentMethodsFetchError({required this.errMsg});
}
