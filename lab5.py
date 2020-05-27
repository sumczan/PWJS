# -*- coding: utf-8 -*-
"""
Created on Wed May 27 15:04:07 2020

@author: sumczan

NA CZTERY

scieżkę należy podawać od katalogu z wywołaniem skryptu

"""
import sys
import os
import string

if len(sys.argv)>1:
    
    path = sys.argv[1]
    fileList = []
    for entry in os.listdir(path):
        if os.path.isfile(os.path.join(path, entry)):
            fileList.append(path+entry)
            
    duplicateString = ""
            
    for file in fileList:
        bytes1 = open(file, "rb")
        data1 = bytes1.read()
        #print(data1)
        for file2 in fileList:
            if(file!=file2):
                bytes2 = open(file2, "rb")
                data2 = bytes2.read()
                if(os.stat(file).st_size == os.stat(file2).st_size):
                    #print(data2)
                    if(data1 == data2):
                        alreadyPresent = duplicateString.find(file)
                        if(alreadyPresent == -1):
                            #tempString = '\n', file,' Duplikaty: '
                            duplicateString += '\n'
                            duplicateString += file
                            duplicateString += ' Duplikaty: '
                            
                        alreadyPresent = duplicateString.find(file2)
                        if(alreadyPresent == -1):
                            duplicateString += file2
                            duplicateString += " "
                            
    print(duplicateString)
                    
        
            