import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMahasiswaController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddMahasiswa = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController npmC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddMahasiswa() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddMahasiswa.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        UserCredential mahasiswaCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: "password");

        if (mahasiswaCredential.user != null) {
          String uid = mahasiswaCredential.user!.uid;

          await firestore.collection("mahasiswa").doc(uid).set({
            "npm": npmC.text,
            "name": nameC.text,
            "job": jobC.text,
            "email": emailC.text,
            "uid": uid,
            "role": "mahasiswa",
            "createdAt": DateTime.now().toIso8601String(),
          });

          await mahasiswaCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "Berhasil menambahkan mahasiswa");
        }
        isLoadingAddMahasiswa.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingAddMahasiswa.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar(
              "Tejadi Kesalahan", "Password yang digunakan terlalu singkat");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Tejadi Kesalahan",
              "Mahasiswa sudah ada. Kamu tidak dapat menambahkan mahasiswa dengan email ini.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Tejadi Kesalahan", "Admin tidak dapat login. Password salah !");
        } else {
          Get.snackbar("Tejadi Kesalahan", "${e.code}");
        }
      } catch (e) {
        isLoadingAddMahasiswa.value = false;
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan mahasiswa.");
      }
    } else {
      isLoading.value = false;
      Get.snackbar(
          "Terjadi Kesalahan", "Password wajib diisi untuk keperluan validasi");
    }
  }

  Future<void> addMahasiswa() async {
    isLoading.value = true;
    if (nameC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        npmC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            Text("Masukan password untuk validasi admin!"),
            SizedBox(height: 20),
            TextField(
              controller: passAdminC,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              isLoading.value = false;
              Get.back();
            },
            child: Text("CANCEL"),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (isLoadingAddMahasiswa.isFalse) {
                  await prosesAddMahasiswa();
                }
                isLoading.value = false;
              },
              child: Text(isLoadingAddMahasiswa.isFalse
                  ? "ADD MAHASISWA"
                  : "LOADING...."),
            ),
          ),
        ],
      );
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "NIM, Nama, Job, dan Email harus diisi.");
    }
  }
}


// Regis Syawaludin Rifaldi - 2142010