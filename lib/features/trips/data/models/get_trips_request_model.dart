import 'package:equatable/equatable.dart';

class GetTripsRequestModel extends Equatable {
  const GetTripsRequestModel({
    this.status,
    this.page = 1,
    this.pageSize = 20,
  });

  final int? status;
  final int page;
  final int pageSize;

  Map<String, dynamic> toJson() {
    return {
      if (status != null) 'Status': status,
      'Page': page,
      'PageSize': pageSize,
    };
  }

  @override
  List<Object?> get props => [status, page, pageSize];
}
