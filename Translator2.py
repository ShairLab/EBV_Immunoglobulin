#!/usr/bin/python3
#Import Packages:
import argparse, re
from collections import Counter
#-----------Input command-----------#:
parser = argparse.ArgumentParser(description = "TMP-NAME: []")
##Obligatory Inputs:
parser.add_argument("-I", dest = "INPUT", help = "Input file [Required]")
#parser.add_argument("-R", dest = "REF", help = "Reference file [Required]")
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
               'TGC':'C', 'TGT':'C', 'TGA':'*', 'TGG':'W',
               
               'NNN':'X',
               
               'ANN':'X', 'CNN':'X', 'TNN':'X', 'GNN':'X',
               'AAN':'X', 'CAN':'X', 'TAN':'X', 'GAN':'X',
               'ACN':'X', 'CCN':'X', 'TCN':'X', 'GCN':'X',
               'ATN':'X', 'CTN':'X', 'TTN':'X', 'GTN':'X',
               'AGN':'X', 'CGN':'X', 'TGN':'X', 'GGN':'X',
               
               'NNA':'X', 'NNC':'X', 'NNT':'X', 'NNG':'X',
               'NAA':'X', 'NAC':'X', 'NAT':'X', 'NAG':'X',
               'NCA':'X', 'NCC':'X', 'NCT':'X', 'NCG':'X',
               'NTA':'X', 'NTC':'X', 'NTT':'X', 'NTG':'X',
               'NGA':'X', 'NGC':'X', 'NGT':'X', 'NGG':'X'
               }

'''
REF1 = {}
with open(args.REF, "r") as REF:
    for i in REF:
        TMP0 = i.rstrip().rsplit("\t")
        TMP1 = [TMP0[0].split(".")[0], int(TMP0[3]), int(TMP0[4])]
        REF1[TMP0[0].split(".")[0].replace(" ", "_")] = [int(TMP0[3]), int(TMP0[4])]

REF1["NAN"] = [list(Counter([v[0] for k, v in REF1.items()]).keys())[0]-20,
               list(Counter([v[1] for k, v in REF1.items()]).keys())[0]+20]
'''

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
START = "ATGTCTGACGAGGGGCCAGG"
for k in INPUT_PRE.keys():
    FLAG1 = True
    i = 0
    COUNTER1 = 0
    PROTEIN = ""
    for i in range(len(INPUT_PRE[k])-20):
        if INPUT_PRE[k][i:i+20] == "ATGTCTGACGAGGGGCCAGG":
            break
        else:
            pass
    #print(k, i)
    try:
        while FLAG1:
            if TRANSLATION[INPUT_PRE[k][(i):(i+3)]] == "*":
                PROTEIN += TRANSLATION[INPUT_PRE[k][(i):(i+3)]]
                FLAG1 = False
            else:
                PROTEIN += TRANSLATION[INPUT_PRE[k][(i):(i+3)]]
                i += 3
            INPUT_POST[k] = PROTEIN
    except(KeyError):
        pass

for k, v in INPUT_POST.items():
    print(k, v)
    
OUTPUT = open("%s.fa" %args.OUTPUT, "w+") 
for k, v in INPUT_POST.items():
    OUTPUT.write(">" + str(k) + "\n" +
                 str(v) + "\n")
OUTPUT.close()
