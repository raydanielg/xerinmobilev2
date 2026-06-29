import 'package:equatable/equatable.dart';

import '../../data/models/wishlist_item_model.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();
}

class WishlistLoaded extends WishlistState {
  final List<WishlistItemModel> items;
  final Set<String> selectedIds;

  const WishlistLoaded({
    required this.items,
    this.selectedIds = const {},
  });

  WishlistLoaded copyWith({
    List<WishlistItemModel>? items,
    Set<String>? selectedIds,
  }) {
    return WishlistLoaded(
      items: items ?? this.items,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }

  @override
  List<Object?> get props => [items, selectedIds];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}
