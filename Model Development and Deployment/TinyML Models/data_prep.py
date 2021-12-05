import os
import shutil

folder = r"/home/nesl/earable_light/Activity_Dataset" #Input directory to dataset here
subfolders = [f.path for f in os.scandir(folder) if f.is_dir()]

for sub in subfolders:
    for f in os.listdir(sub):
        src = os.path.join(sub, f)
        dst = os.path.join(folder, f)
        shutil.move(src, dst)
    shutil.rmtree(sub)
