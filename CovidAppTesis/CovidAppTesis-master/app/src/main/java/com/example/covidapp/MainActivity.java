package com.example.covidapp;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.ParcelFileDescriptor;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.material.bottomsheet.BottomSheetDialog;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.label.ImageLabel;
import com.google.mlkit.vision.label.ImageLabeler;
import com.google.mlkit.vision.label.ImageLabeling;
import com.google.mlkit.vision.label.automl.AutoMLImageLabelerLocalModel;
import com.google.mlkit.vision.label.automl.AutoMLImageLabelerOptions;

import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.util.List;

public class MainActivity extends AppCompatActivity {
  //Static
  private static final int IMAGE_PICK_CODE = 1000;
  private static final int PHOTO_PICK_CODE = 2000;
  private static final int PERMISSION_CODE = 1001;
  //View components
  ProgressBar progressBarCovid;
  ProgressBar progressBarNoCovid;
  TextView txtProgressCovid;
  TextView txtProgressNOCovid;
  ImageView mainImageView;
  //Data
  // 0 for Covid - 1 for no Covid
  float[] dataConfidence = new float[2];
  private String currentPhotoPath;
  private boolean firstScan = false;

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    getMenuInflater().inflate(R.menu.menu_options, menu);
    return true;
  }

  @Override
  public boolean onOptionsItemSelected(@NonNull MenuItem item) {
    int id = item.getItemId();
    switch (id){
      case R.id.downloadOption:
        System.out.println("Option 1");
        break;
      case R.id.helpOption:
        System.out.println("Option 2");
        break;
    }
    return super.onOptionsItemSelected(item);
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    mainImageView = (ImageView) findViewById(R.id.mainImageView);
    mainImageView.setOnLongClickListener(new View.OnLongClickListener() {
      @Override
      public boolean onLongClick(View v) {
        if(firstScan){
          callBottomSheet(dataConfidence);
        }
        return true;
      }
    });
  }


  public void clickGetFromGallery(View view) {

    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
      if(checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_DENIED){
        //Permission denied
        String[] permissions = {Manifest.permission.READ_EXTERNAL_STORAGE};
        //Show popup
        requestPermissions(permissions, PERMISSION_CODE);
      }else {
        //permission Granted
        pickImageFromGallery();
      }
    }else {
      //System less than Marshmallow
      pickImageFromGallery();
    }

  }

  private void pickImageFromGallery() {

    Intent intent = new Intent(Intent.ACTION_PICK);
    intent.setType("image/*");
    startActivityForResult(intent, IMAGE_PICK_CODE);

  }

  private void analyzeTfModel(Bitmap bitmap){

    AutoMLImageLabelerLocalModel localModel =
            new AutoMLImageLabelerLocalModel.Builder()
                    .setAssetFilePath("manifest.json")
                    .build();

    AutoMLImageLabelerOptions autoMLImageLabelerOptions =
            new AutoMLImageLabelerOptions.Builder(localModel)
                    .setConfidenceThreshold(0.0f)  // Evaluate your model in the Firebase console
                    // to determine an appropriate value.
                    .build();
    ImageLabeler labeler = ImageLabeling.getClient(autoMLImageLabelerOptions);

    InputImage image = null;

//    try {
      image = InputImage.fromBitmap(bitmap, 0);

//      image = InputImage.fromFilePath(getApplicationContext(), uri);
//    } catch (IOException e) {
//      e.printStackTrace();
//    }

    labeler.process(image)
            .addOnSuccessListener(new OnSuccessListener<List<ImageLabel>>() {
              @Override
              public void onSuccess(List<ImageLabel> labels) {
                // Task completed successfully
                // ...
                for (ImageLabel label : labels) {
                  String text = label.getText();
                  float confidence = label.getConfidence();
//                  int index = label.getIndex();

                  if(text.equals("covid")){
                    dataConfidence[0] = confidence;
                  }else {
                    dataConfidence[1] = confidence;
                  }

                  Log.println(Log.INFO, "RESULTS",
                          "Label: " + text + "\n" +
                                  "Confidence: " + confidence + "\n");
                }

                //show BottomSheet
                callBottomSheet(dataConfidence);

              }
            })
            .addOnFailureListener(new OnFailureListener() {
              @Override
              public void onFailure(@NonNull Exception e) {
                Toast.makeText(MainActivity.this, "Error al leer el modelo", Toast.LENGTH_LONG).show();
                // Task failed with an exception
                // ...
                Log.println(Log.ERROR, "ERROR:", "Algo ha pasado!");
              }
            });

  }



  private Bitmap uriToBitmap(Uri selectedFileUri) {
    Bitmap image = null;
    try {
      ParcelFileDescriptor parcelFileDescriptor =
              getContentResolver().openFileDescriptor(selectedFileUri, "r");
      FileDescriptor fileDescriptor = parcelFileDescriptor.getFileDescriptor();
      image = BitmapFactory.decodeFileDescriptor(fileDescriptor);

      parcelFileDescriptor.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return  image;
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if(resultCode == RESULT_OK){
      switch (requestCode){
        case IMAGE_PICK_CODE:{
          //aqui tienes la imagen
          Uri uri = data.getData();
          Log.println(Log.INFO,"DATA", uri.toString());
          mainImageView.setImageURI(uri);
          firstScan = true;
          analyzeTfModel(uriToBitmap(uri));
          break;
        }
        case PHOTO_PICK_CODE:{
          Bitmap bitmap = BitmapFactory.decodeFile(currentPhotoPath);
          mainImageView.setImageBitmap(bitmap);
          firstScan = true;
          analyzeTfModel(bitmap);
          break;
        }
      }
    }
//    if(resultCode == RESULT_OK && requestCode == IMAGE_PICK_CODE){
//      //aqui tienes la imagen
//      Uri uri = data.getData();
//      Log.println(Log.INFO,"DATA", uri.toString());
//      mainImageView.setImageURI(uri);
//      firstScan = true;
//      analyzeTfModel(uriToBitmap(uri));
//    }
//    if(requestCode == PHOTO_PICK_CODE && resultCode == RESULT_OK){
//      Bitmap bitmap = BitmapFactory.decodeFile(currentPhotoPath);
//      mainImageView.setImageBitmap(bitmap);
//      firstScan = true;
//      analyzeTfModel(bitmap);
//    }
  }

  @Override
  public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    switch (requestCode){
      case PERMISSION_CODE:{
        if(grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED){
          //permission was granted
          pickImageFromGallery();
        }else{
          //permission was denied
          Toast.makeText(this, "Permiso negado", Toast.LENGTH_LONG).show();
        }
      }
    }
  }

  public void callBottomSheet(float[] data) {
    int[] dataToShow = new int[2];
    dataToShow[0] = (int) Math.round(data[0]*100);
    dataToShow[1] = (int) Math.round(data[1]*100);
    System.out.println("first: " + (data[0] *100));
    System.out.println("Second: " + (data[1] * 100));

    final BottomSheetDialog bottomSheetDialog = new BottomSheetDialog(MainActivity.this, R.style.BottomSheetDialogTheme);

    View bottomSheetView = LayoutInflater.from(getApplicationContext())
            .inflate(
                    R.layout.bottom_sheet_layout,
                    (LinearLayout)findViewById(R.id.bottomSheetContainer)
            );

    progressBarCovid = (ProgressBar) bottomSheetView.findViewById(R.id.progressBarCovid);
    progressBarNoCovid =  (ProgressBar) bottomSheetView.findViewById(R.id.progressBarNOCovid);
    txtProgressCovid = (TextView) bottomSheetView.findViewById(R.id.txtProgressCovid);
    txtProgressNOCovid = (TextView) bottomSheetView.findViewById(R.id.txtProgressNOCovid);

    progressBarCovid.setProgress(dataToShow[0]);
    progressBarNoCovid.setProgress(dataToShow[1]);

    txtProgressCovid.setText(dataToShow[0] + " %");
    txtProgressNOCovid.setText(dataToShow[1] + " %");


    bottomSheetView.findViewById(R.id.buttonDispose).setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View v) {
        Toast.makeText(MainActivity.this, "Data...", Toast.LENGTH_LONG).show();
        bottomSheetDialog.dismiss();
      }
    });

    bottomSheetDialog.setContentView(bottomSheetView);
    bottomSheetDialog.show();
  }

  public void clickGetFromCamera(View view) {
    String fileName = "photo";
    File storageDirectory = getExternalFilesDir(Environment.DIRECTORY_PICTURES);
    try {

      File imageFile = File.createTempFile(fileName, ".jpg", storageDirectory);
      currentPhotoPath = imageFile.getAbsolutePath();
      Uri imageUri = FileProvider.getUriForFile(MainActivity.this, "com.example.covidapp.fileprovider", imageFile);
      Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
      intent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
      startActivityForResult(intent, PHOTO_PICK_CODE);

    }catch (IOException e){
      e.printStackTrace();
    }
  }
}