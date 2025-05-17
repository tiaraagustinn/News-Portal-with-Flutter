import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 

 
class RegistPage extends StatefulWidget { 
  @override 
  _RegistPageState createState() => _RegistPageState(); 
} 
 
class _RegistPageState extends State<RegistPage> {
   TextEditingController userController = TextEditingController(); 
  TextEditingController passController = TextEditingController(); 
  TextEditingController pass2Controller = TextEditingController(); 
 
  // Fungsi untuk menambahkan data pengguna 
  addDataUser( 
    TextEditingController userController, 
    TextEditingController passController, 
    TextEditingController pass2Controller, 
  ) async { 
    // Validasi input pengguna 
    if (userController.text != '' && 
        passController.text != '' && 
        pass2Controller.text != '' && 
        passController.text == pass2Controller.text) { 
      setState(() { 
        var link = Uri.parse( 
          'https://e-commerce-store.glitch.me/signup', 
        ); // Menggunakan Uri.parse() 
 
        // Mengirim data menggunakan http.post 
        http 
            .post( 
              link, 
              body: { 
                "username": userController.text, 
                "password": passController.text, 
              }, 
            ) 
            .then((response) { 
              // Cek apakah registrasi berhasil berdasarkan status code 
              if (response.statusCode == 200) { 
                // Tindakan jika berhasil 
                _showErrorToast("Registrasi berhasil."); 
                return Navigator.pop(context); 
              } else { 
                // Tindakan jika gagal 
                _showErrorToast("Registrasi gagal. Coba lagi."); 
              } 
            }) 
            .catchError((e) { 
              // Menangani kesalahan jaringan 
              _showErrorToast( 
                "Terjadi kesalahan. Pastikan Anda terhubung ke internet.", 
              ); 
            }); 
      }); 
       } else { 
      // Kosongkan form jika validasi gagal 
      userController.text = ''; 
      passController.text = ''; 
      pass2Controller.text = ''; 
      _showErrorToast("Pastikan semua kolom terisi dengan benar."); 
    } 
  } 
 
  // Menampilkan pesan toast jika ada error 
  void _showErrorToast(String message) { 
    ScaffoldMessenger.of(context).showSnackBar( 
      SnackBar(content: Text(message), duration: Duration(seconds: 3)), 
    ); 
  } 

 
  @override 
  Widget build(BuildContext context) { 
    return SafeArea( 
      child: Scaffold( 
        body: Center( 
          child: Container( 
            margin: EdgeInsets.all(20), 
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [ 
                Text( 
                  'Registrasi', 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), 
                ), 
                SizedBox(height: 20), 
                TextField( 
                  controller: userController, 
                  decoration: InputDecoration(hintText: "Username"), 
                ), 
                TextField( 
                  controller: passController, 
                  decoration: InputDecoration(hintText: "Password"), 
                  obscureText: true, 
                ), 
                TextField( 
                   controller: pass2Controller, 
                  decoration: InputDecoration(hintText: "Konfirmasi Password"), 
                  obscureText: true, 
                ), 
                SizedBox(height: 20), 
                Row( 
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [ 
                    TextButton( 
                      style: TextButton.styleFrom( 
                        backgroundColor: Colors.blue, 
                        shape: RoundedRectangleBorder( 
                          borderRadius: BorderRadius.circular(10.0), 
                        ), 
                        padding: EdgeInsets.symmetric( 
                          horizontal: 16.0, 
                          vertical: 12.0, 
                        ), 
                      ), 
                      onPressed: () { 
                        Navigator.pop(context); 
                      }, 
                      child: Text( 
                        'Back', 
                        style: TextStyle(color: Colors.white), 
                      ), 
                    ), 
                    SizedBox(width: 20), 
                    TextButton( 
                      style: TextButton.styleFrom( 
                        backgroundColor: Colors.blue, 
                        shape: RoundedRectangleBorder( 
                          borderRadius: BorderRadius.circular(10.0), 
                        ), 
                        padding: EdgeInsets.symmetric( 
                          horizontal: 16.0, 
                          vertical: 12.0, 
                        ), 
                      ), 
                      onPressed: () { 
                        addDataUser( 
                          userController, 
                          passController, 
                          pass2Controller, 
                        ); 
                      }, 
                      child: Text( 
                        'Sign Up', 
                        style: TextStyle(color: Colors.white), 
                      ), 
                    ), 
                  ], 
                ), 
              ], 
            ), 
          ), 
        ), 
      ), 
    ); 
  } 
} 


