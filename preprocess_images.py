from PIL import Image 
import numpy as np
import matplotlib.pyplot as plt
import glob
import os
import cv2
from tqdm import tqdm

def transform(img, size: tuple, crop_size: tuple):
    """
    returns resized and center cropped image
    arguments:
        -img: original image
        -size: size of image after applying resize
        -crop_size: size of image after applying center crop
    """
    img_resized = cv2.resize(img, size)
    w, h = crop_size
    center = img_resized.shape [0] / 2, img_resized.shape [1] / 2
    x = center[1] - w/2
    y = center[0] - h/2
    crop_img = img_resized[int(y):int(y+h), int(x):int(x+w)]
    return crop_img

def save_img_and_masks(img_path: str, 
                       dataset_path: str, 
                       index: int, 
                       size: tuple,
                       crop_size: tuple,
                       canny_threshold_1: int,
                       canny_threshold_2: int):
    """
    This function gets an image, applies transorms to it,
    computes skecth from the given image,
    combines image and sketch and saves them as one image to the folder
    arguments:
        -img_path: path to the image,
        -dataset_path: path to store the dataset,
        -index: index of the given image, used to rename images by their indexes,
        -size: size of image after applying resize
        -crop_size: size of image after applying center crop
        -canny_threshold_1: threshold_1 used in canny edge detection implementation of opencv,
        -canny_threshold_2: threshold_2 used in canny edge detection implementation of opencv
    """
    img = cv2.imread(img_path)
    img = transform(img, size=size, crop_size=crop_size)
    sketch = 255 - cv2.Canny(img, canny_threshold_1, canny_threshold_2)
    sketch = np.stack((sketch,)*3, axis=-1)   # make BW image have 3 color channels
    img_combined = np.concatenate([img, sketch], 1)
    try:
        os.makedirs(dataset_path)
    except FileExistsError:
    # directory already exists
        pass
    # save image and its sketch combined in one file
    cv2.imwrite(dataset_path+str(index)+'.jpg', img_combined)
