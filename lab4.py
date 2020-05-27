# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.

scieżki należy podawać od katalogu ze skryptem

1 argument dotyczy czesci pierwszej
2 argument -> czesc druga

"""
import sys
import string
from collections import Counter

temp = ''
letters = 0;

if len(sys.argv) > 1:
    print("\nczesc I\n")
    file1 = open(sys.argv[1],"r")
    for line in file1:
        temp += line.lower()
        
    letterCount = Counter(temp.translate(str.maketrans('','',string.punctuation)))
    letterCount = {k: letterCount.get(k,0) for k in string.ascii_lowercase}
    letters = sum(letterCount.values())
    letterSorted = sorted(letterCount.items(), key=lambda pair: pair[1], reverse=True)
    print(letters)
    for each in letterSorted:
        print(each[0], ':\t',each[1], '\t:', round(int(each[1])/letters*100,2),"%")

if len(sys.argv) >2:
    occurence = ""
    print("\nczesc II\n")
    file = open(sys.argv[2], "r")
    letterFrequency = file.readline()
    letterFrequency = letterFrequency.lower()
    letterFrequency = letterFrequency.strip()
        
    temp = ''
    for line in file:
        temp += line.lower()
        
    letterCount = Counter(temp.translate(str.maketrans('','',string.punctuation)))
    letterCount = {k: letterCount.get(k,0) for k in string.ascii_lowercase}
    letterSorted = sorted(letterCount.items(), key=lambda pair: pair[1], reverse=True)
    for each in letterSorted:
        occurence+=each[0]
            
    temp2 = ''
    counter = 0
    for letter in temp:
        index = occurence.find(letter)
        if(index != -1):
            temp2+=letterFrequency[index]
        else:
            temp2+=letter
    print(temp2)
        
    
    
        
        
