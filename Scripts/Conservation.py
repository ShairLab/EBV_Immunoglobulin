#!/usr/bin/python3
#Import Packages:
import argparse, re
#-----------Input command-----------#:
parser = argparse.ArgumentParser(description = "TMP-NAME: []")
##Obligatory Inputs:
parser.add_argument("-I", dest = "INPUT", help = "Input file [Required]")
parser.add_argument("-O", dest = "OUTPUT", help = "Output file [Required]")
##Parser Funciton:
args = parser.parse_args()

DATABASE = {}
with open(args.INPUT, "r") as IN:
    for i in IN:
        if not "***" in i:
            TMP1 = i.rstrip().rsplit("\t")
            if len(TMP1) > 1:
                if TMP1[0] not in DATABASE:
                    DATABASE[TMP1[0]] = TMP1[1]
                else:
                    DATABASE[TMP1[0]] += TMP1[1]
            else:
                pass
        else:
            pass

REFERENCE = ""
for k in DATABASE.keys():
    if "EBNA1" in k:
        REFERENCE = k
    else:
        pass
        
COUNTER1 = 0
CONSERVATION = []
for i in range(len(DATABASE[REFERENCE])):
    REF = ""
    TMPLIST = []
    SIMILARITY = 0
    for k, v in DATABASE.items():
        if k == REFERENCE:
            REF = v[COUNTER1]
        else:
            TMPLIST.append(v[COUNTER1])
    for j in TMPLIST:
        if j == REF:
            SIMILARITY += 1
        else:
            pass
    CONSERVATION.append(SIMILARITY/len(TMPLIST))
    COUNTER1 += 1
    
OUTPUT = open("%s.csv" %args.OUTPUT, "w+") 
for k, v in DATABASE.items():
    OUTPUT.write(k + ",")
    for i in v:
        OUTPUT.write(i + ",")
    OUTPUT.write("\n")
OUTPUT.write("\n" + "Conservation" + ",")
for i in CONSERVATION:
    OUTPUT.write(str(i) + ",")
