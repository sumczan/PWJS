# -*- coding: utf-8 -*-
"""
Created on Wed May 27 17:16:22 2020

@author: sumczan

NA CZTERY
tak jak w perlu nie wiem jak z windowsa wyciagnac nazwe usera

scieżkę należy zacząć podawać od './' i zakończyć '/'

"""

import sys
import os
import stat
import datetime

def unixPerm(st):
    is_dir = 'd' if stat.S_ISDIR(st.st_mode) else '-'
    dic = dic = {'7':'rwx', '6' :'rw-', '5' : 'r-x', '4':'r--', '0': '---'}
    perm = str(oct(st.st_mode)[-3:])
    return is_dir + ''.join(dic.get(x,x)for x in perm)
    
    

smolL = 0
bigL = 0
index = -1

path = "./"
if len(sys.argv) > 1:
    index = sys.argv[1].find("./")
    if index != -1:
        path = sys.argv[1]
    if len(sys.argv)>2:
        try:
            index = sys.argv.index("-l")
            if index:
                smolL = 1
        except:
            smolL = 0
            
        try:
            index = sys.argv.index("-L")
            if index:
                bigL = 1
        except:
            bigL = 0

fileList = []
for entry in os.listdir(path):
    fileList.append(entry)

#print(fileList)
    
for file in fileList:
    tempFile = path+file;
    line =""
    if smolL == 1:
        temp = (file[:30] + '..')if len(file) > 30 else file.ljust(32)
        line += temp+"\t"
        
        temp = str(os.stat(tempFile).st_size)
        temp = (temp[:10] + '..') if len(temp) > 10 else temp.ljust(12)
        line += temp+"\t"
        
        temp = os.stat(tempFile).st_mtime
        temp = datetime.datetime.fromtimestamp(temp).strftime('%Y-%m-%d %H:%M:%S')
        line += temp+"\t"
        
        temp = unixPerm(os.stat(tempFile))
        line += temp+"\t"
    else:
        line += file
        
    if bigL == 1:
        temp = " "
        line+= temp+"\t"
    
    print(line)
            
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    