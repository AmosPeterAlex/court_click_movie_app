import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserAccount extends Equatable {
  const UserAccount({
    required this.id,
    required this.name,
    required this.color,
    this.isKids = false,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final Color color;
  final bool isKids;
  final String? avatarUrl;

  @override
  List<Object?> get props => [id, name, color, isKids, avatarUrl];
}
