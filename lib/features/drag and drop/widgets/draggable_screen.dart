import 'package:flutter/material.dart';
class DraggableScreen extends StatefulWidget {
  const DraggableScreen({super.key});

  @override
  State<DraggableScreen> createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {
  // A list to hold the colors of the containers that have been dropped into the drop zone.
  // 'null' represents an empty slot.
  final List<Color?> _droppedColors = [null, null, null];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Row containing the three draggable containers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDraggableContainer(Colors.red),
              _buildDraggableContainer(Colors.green),
              _buildDraggableContainer(Colors.blue),
            ],
          ),

          const SizedBox(height: 50),

          // The main drop zone where containers will be placed
          _buildDropZone(),
        ],
      ),
    );
  }

  // Helper method to create a single draggable container
  Widget _buildDraggableContainer(Color color) {
    return Draggable<Color>(
      // The data associated with this draggable widget (the color)
      data: color,
      // The widget that follows the user's finger while dragging
      feedback: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(Icons.drag_handle, color: Colors.white),
      ),
      // The widget shown in the original position while dragging
      childWhenDragging: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      // The original widget before it's dragged
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  // Helper method to create the drop zone, which is a DragTarget
  Widget _buildDropZone() {
    return DragTarget<Color>(
      // The builder method creates the UI for the drop zone
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 350,
          // The drop zone's height is fixed
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: List.generate(3, (index) {
              final color = _droppedColors[index];
              final isDropped = color != null;

              return Expanded(
                child: GestureDetector(
                  // Tapping on a dropped container removes it from the drop zone
                  onTap: () {
                    if (isDropped) {
                      setState(() {
                        _droppedColors[index] = null;
                      });
                    }
                  },
                  // AnimatedContainer for a smooth and bouncy height transition
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    // When a container is dropped, its height snaps to 150. Otherwise, it's 0.
                    height: isDropped ? 150 : 0,
                    decoration: BoxDecoration(
                      color: isDropped ? color : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.all(2),
                    // Show a 'close' icon on the dropped container
                    child: isDropped
                        ? const Icon(Icons.close, color: Colors.white)
                        : null,
                  ),
                ),
              );
            }),
          ),
        );
      },
      // Callback triggered when a draggable container is dropped onto the drop zone
      onAcceptWithDetails: (details) {
        setState(() {
          // Get the color data from the dropped item
          final color = details.data;
          // Find the first empty slot in the list
          final index = _droppedColors.indexOf(null);
          // If a slot is available, place the new color in it
          if (index != -1) {
            _droppedColors[index] = color;
          }
        });
      },
    );
  }
}