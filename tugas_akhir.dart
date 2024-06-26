import 'dart:async';  // untuk Future.delayed
import 'dart:collection';  // untuk Queue
import 'dart:io';  // untuk stdin

class Member {
  String name;
  DateTime reservationTime;

  Member(this.name, this.reservationTime);
}

class Slot {
  String name;
  int capacity;
  bool isOccupied;

  Slot(this.name, this.capacity, {this.isOccupied = false});
}

void main() {
  // Inisialisasi daftar slot gym
  List<Slot> gymSlots = [
    Slot("Treadmill", 1),
    Slot("Elliptical", 5),
    Slot("Weight Machine", 2),
  ];

  // Inisialisasi antrian reservasi
  Queue<Member> reservationQueue = Queue();

  // Reservasi
  while (true) {
    print("Masukkan nama: ");
    String name = stdin.readLineSync() ?? "";

    print("Pilih slot gym: ");
    for (int i = 0; i < gymSlots.length; i++) {
      Slot slot = gymSlots[i];
      print("${i + 1}. ${slot.name} (${slot.capacity} orang)");
    }

    int slotChoice = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
    if (slotChoice <= 0 || slotChoice > gymSlots.length) {
      print("Pilihan slot gym tidak valid.");
      continue;
    }

    Slot chosenSlot = gymSlots[slotChoice - 1];

    // Periksa ketersediaan slot
    if (!chosenSlot.isOccupied && chosenSlot.capacity > reservationQueue.length) {
      chosenSlot.isOccupied = true;
      reservationQueue.add(Member(name, DateTime.now()));
      print("Reservasi atas nama $name untuk slot ${chosenSlot.name} telah dikonfirmasi.");

      // Simulasikan penggunaan slot
      Future.delayed(Duration(minutes: 30), () {
        chosenSlot.isOccupied = false;
        print("Slot ${chosenSlot.name} telah tersedia.");
      });
    } else {
      print("Maaf, slot ${chosenSlot.name} saat ini tidak tersedia.");
    }

    print("Apakah ingin reservasi lagi? (y/n)");
    String answer = stdin.readLineSync() ?? "";
    if (answer.toLowerCase() != "y") {
      break;
    }
  }

  // Tampilkan antrian reservasi
  print("\nAntrian Reservasi:");
  for (Member member in reservationQueue) {
    print("- ${member.name} (${member.reservationTime})");
  }

  // Tutup program
  exit(0);
}