import os
import operator
import shutil
migratedDir = "migrated/"
origDir = "frames/"
# list_dir = os.listdir(origDir + '.')
# list_dir = [[f, os.path.getmtime(origDir + f)] for f in list_dir]

# list_dir = sorted(list_dir, key=operator.itemgetter(1))
# print("Moving Files....")
# for x in range(len(list_dir)):
#     # print(list_dir[x])
#     if(x % 2 == 0 and x > 0):
#         shutil.move(origDir  +  list_dir[x][0], migratedDir + list_dir[x][0])

# print("Renaming files...)

list_dir = os.listdir(migratedDir + '.')
list_dir = [[f, os.path.getmtime(migratedDir + f)] for f in list_dir]

list_dir = sorted(list_dir, key=operator.itemgetter(1))

for x in range(len(list_dir)):
    # os.rename(migratedDir  +  list_dir[x][0], migratedDir + 'best' +  str(x) + ".png")
    print(list_dir[x])


# for x in range(len(list_dir)):
#     os.rename('frames/' +  str(x), 'frames/' +  str(x) + '.JPEG')

    
