part of 'home_cubit.dart';

enum LoadingStatus { loading, failure, success }

class GiphyState extends Equatable {
  final LoadingStatus apiStatus;

  final List<GiphyModel> list;

  const GiphyState._({
    this.apiStatus = LoadingStatus.loading,
    this.list = const <GiphyModel>[],
  });

  const GiphyState.loading() : this._();

  const GiphyState.failure() : this._(apiStatus: LoadingStatus.failure);

  const GiphyState.success({required List<GiphyModel> list})
      : this._(apiStatus: LoadingStatus.success, list: list);

  GiphyState copyWith({
    LoadingStatus? apiStatus,
    List<GiphyModel>? list,
  }) {
    return GiphyState._(
      apiStatus: apiStatus ?? this.apiStatus,
      list: list ?? this.list,
    );
  }

  @override
  List<Object> get props => [apiStatus, list];
}
