#!/usr/bin/python3
#Import Packages:
import argparse, re
from collections import Counter
#-----------Input command-----------#:
parser = argparse.ArgumentParser(description = "TMP-NAME: []")
##Obligatory Inputs:
parser.add_argument("-I", dest = "INPUT", help = "Input file [Required]")
parser.add_argument("-R", dest = "REF", help = "Reference file [Required]")
parser.add_argument("-O", dest = "OUTPUT", help = "Output file [Required]")
##Parser Funciton:
args = parser.parse_args()

TRANSLATION = {'ATA':'I', 'ATC':'I', 'ATT':'I', 'ATG':'M',
               'ACA':'T', 'ACC':'T', 'ACG':'T', 'ACT':'T',
               'AAC':'N', 'AAT':'N', 'AAA':'K', 'AAG':'K',
               'AGC':'S', 'AGT':'S', 'AGA':'R', 'AGG':'R',
               
               'CTA':'L', 'CTC':'L', 'CTG':'L', 'CTT':'L',
               'CCA':'P', 'CCC':'P', 'CCG':'P', 'CCT':'P',
               'CAC':'H', 'CAT':'H', 'CAA':'Q', 'CAG':'Q',
               'CGA':'R', 'CGC':'R', 'CGG':'R', 'CGT':'R',
               
               'GTA':'V', 'GTC':'V', 'GTG':'V', 'GTT':'V',
               'GCA':'A', 'GCC':'A', 'GCG':'A', 'GCT':'A',
               'GAC':'D', 'GAT':'D', 'GAA':'E', 'GAG':'E',
               'GGA':'G', 'GGC':'G', 'GGG':'G', 'GGT':'G',
               
               'TCA':'S', 'TCC':'S', 'TCG':'S', 'TCT':'S',
               'TTC':'F', 'TTT':'F', 'TTA':'L', 'TTG':'L',
               'TAC':'Y', 'TAT':'Y', 'TAA':'*', 'TAG':'*',
               'TGC':'C', 'TGT':'C', 'TGA':'*', 'TGG':'W'}

REF1 = {}
with open(args.REF, "r") as REF:
    for i in REF:
        TMP0 = i.rstrip().rsplit("\t")
        TMP1 = [TMP0[0].split(".")[0], int(TMP0[3]), int(TMP0[4])]
        REF1[TMP0[0].split(".")[0].replace(" ", "_")] = [int(TMP0[3]), int(TMP0[4])]

REF1["NAN"] = [list(Counter([v[0] for k, v in REF1.items()]).keys())[0]-20,
               list(Counter([v[1] for k, v in REF1.items()]).keys())[0]+20]

INPUT_PRE = {}
with open(args.INPUT, "r") as IN:
    FLAG = True
    HEADER = ""
    SEQUENCE = ""
    for i in IN:
        TMP1 = i.rstrip()
        if ">" in TMP1 and FLAG:
            HEADER = TMP1[1:].split(" ")[0]
            SEQUENCE = ""
            FLAG = False
        elif ">" in TMP1 and not FLAG:
            INPUT_PRE[HEADER] = SEQUENCE
            HEADER = TMP1[1:].split(" ")[0]
            SEQUENCE = ""
        elif ">" not in TMP1:
            SEQUENCE += TMP1.rstrip("\n")
        else:
            break
    INPUT_PRE[HEADER] = SEQUENCE
    
INPUT_POST = {}
COUNTER1 = 0
PROTEIN = ""
for k in INPUT_PRE.keys():
    COUNTER1 = 0
    PROTEIN = ""
    TMP1 = INPUT_PRE[k][(REF1[k][0]-1):(REF1[k][1])]
    while COUNTER1 < len(TMP1):
        if TRANSLATION[TMP1[(COUNTER1):(COUNTER1+3)]] == "*":
            PROTEIN += TRANSLATION[TMP1[(COUNTER1):(COUNTER1+3)]]
            break
        else:
            PROTEIN += TRANSLATION[TMP1[(COUNTER1):(COUNTER1+3)]]
            COUNTER1 += 3
    INPUT_POST[k] = PROTEIN

OUTPUT = open("%s.fa" %args.OUTPUT, "w+") 
for k, v in INPUT_POST.items():
    OUTPUT.write(">" + str(k) + "\n" +
                 str(v) + "\n")
OUTPUT.close()


'''
DATABASE = {}
with open(args.INPUT, "r") as IN:
    for i in IN:
        TMP1 = i.rstrip().rsplit("\t")
        if len(TMP1) > 1:
            if TMP1[0] not in DATABASE:
                DATABASE[TMP1[0]] = TMP1[1]
            else:
                DATABASE[TMP1[0]] += TMP1[1]
        else:
            pass

COUNTER1 = 0
CONSERVATION = []
for i in range(len(DATABASE[next(iter(DATABASE))])):
    REF = ""
    TMPLIST = []
    SIMILARITY = 0
    for k, v in DATABASE.items():
        if k == next(iter(DATABASE)):
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
'''
