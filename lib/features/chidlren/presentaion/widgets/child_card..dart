import 'package:flutter/material.dart';

class ChildCard extends StatelessWidget {
  final String name;
  final String? details;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final String? avatarLetter;

  const ChildCard({
    Key? key,
    required this.name,
    this.details,
    this.onTap,
    this.onDelete,
    this.avatarLetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                child: Text(avatarLetter ?? (name.isNotEmpty ? name[0] : '?'),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    if (details != null) ...[
                      const SizedBox(height: 4),
                      Text(details!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700])),
                    ],
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton(icon: Icon(Icons.delete_outline, color: Colors.red[400]), onPressed: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}
