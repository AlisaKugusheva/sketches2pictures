# sketches2pictures
### Introduction

Transform sketches to images using GAN.

Two models are implemented: the first converts sketches to the cars and the second to the pets (dogs and cats).

### Pix2Pix macOS app

The projects contains the macOS application which allows to draw and then see the generated model based on the drawing.

#### How to launch?

To launch an app locally, multiple steps should be done:

* checkpoints folder needs to be added to the sketches2pictures/ui folder locally. It should has the following structure: `ui/checkpoints/edges2pets/latest_net_G.pth` and `ui/checkpoints/edges2cars/latest_net_G.pth` where the `.pht` files are the weights of the pretrained models for the pets and cars, accordingly.
* In the `MainView` file `MAIN_PATH` variable should be edited to point to the local path to the `sketches2pictures/ui` folder.
* After the app launch, before start working, it needs to be opened full screen.

#### Screen record

Below is an example of how an app can be used for the cars generation:


https://user-images.githubusercontent.com/19249980/146027057-fa69f1a3-6576-4e8f-8e08-888021beb977.mp4

 ### Datasets and models
 
 On the [Google Drive](https://drive.google.com/drive/folders/1HgaKpAwGchjvTlGalAKgFZi0dtsr1vSz) you can find the preprocessed datasets and models weights.
