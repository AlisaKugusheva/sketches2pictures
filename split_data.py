import shutil
import os
import glob

def train_test_split(dataset_dir: str, train_size: float):
    """
    splits data to train and test and moves them to the corresponding directories
    arguments:
        - dataset_dir: directory in which the dataset is stored,
        - train_size: from 0 to 1
    """
    os.chdir(dataset_dir)
    list_img = glob.glob('*.jpg')
    
    number_of_train_imgs = int(len(list_img) * train_size)
    train_imgs = sorted(list_img)[:number_of_train_imgs]
    test_imgs = sorted(list_img)[number_of_train_imgs:]
    
    for img in train_imgs:
        try:
            os.makedirs('train/')
        except FileExistsError:
            pass
        shutil.move(img, 'train/'+img)
        
    for img in test_imgs:
        try:
            os.makedirs('test/')
        except FileExistsError:
            pass
        shutil.move(img, 'test/'+img)