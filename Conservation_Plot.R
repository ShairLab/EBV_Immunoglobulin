getwd()
setwd("Playground/BW/Conservation/")

library(ggplot2)
library(ggpubr)
library(scales)
library(reshape2)

E_CN_S_A <- read.csv2(file = "Endemic_CN_Saliva/Endemic_CN_Saliva_Akata.tsv", header = T, sep = ",", dec = ".")
E_CN_S_B <- read.csv2(file = "Endemic_CN_Saliva/Endemic_CN_Saliva_B95-8.tsv", header = T, sep = ",", dec = ".")
E_CN_SH_A <- read.csv2(file = "Endemic_CN_Saliva_Healthy/Endemic_CN_Saliva_Healthy_Akata.tsv", header = T, sep = ",", dec = ".")
E_CN_SH_B <- read.csv2(file = "Endemic_CN_Saliva_Healthy/Endemic_CN_Saliva_Healthy_B95-8.tsv", header = T, sep = ",", dec = ".")
E_CN_T_A <- read.csv2(file = "Endemic_CN_Tumor/Endemic_CN_Tumor_Akata.tsv", header = T, sep = ",", dec = ".")
E_CN_T_B <- read.csv2(file = "Endemic_CN_Tumor/Endemic_CN_Tumor_B95-8.tsv", header = T, sep = ",", dec = ".")
E_HK_T_A <- read.csv2(file = "Endemic_HK_Tumor/Endemic_HK_Tumor_Akata.tsv", header = T, sep = ",", dec = ".")
E_HK_T_B <- read.csv2(file = "Endemic_HK_Tumor/Endemic_HK_Tumor_B95-8.tsv", header = T, sep = ",", dec = ".")
E_IN_NB_A <- read.csv2(file = "Endemic_IN_NasalBrush/Endemic_IN_NasalBrush_Akata.tsv", header = T, sep = ",", dec = ".")
E_IN_NB_B <- read.csv2(file = "Endemic_IN_NasalBrush/Endemic_IN_NasalBrush_B95-8.tsv", header = T, sep = ",", dec = ".")
E_IN_T_A <- read.csv2(file = "Endemic_IN_Tumor/Endemic_IN_Tumor_Akata.tsv", header = T, sep = ",", dec = ".")
E_IN_T_B <- read.csv2(file = "Endemic_IN_Tumor/Endemic_IN_Tumor_B95-8.tsv", header = T, sep = ",", dec = ".")
E_TW_S_A <- read.csv2(file = "Endemic_TW_Saliva/Endemic_TW_Saliva_Akata.tsv", header = T, sep = ",", dec = ".")
E_TW_S_B <- read.csv2(file = "Endemic_TW_Saliva/Endemic_TW_Saliva_B95-8.tsv", header = T, sep = ",", dec = ".")
NE_CN_P_A <- read.csv2(file = "Non-Endemic_CN_Plasma/Non-Endemic_CN_Plasma_Akata.tsv", header = T, sep = ",", dec = ".")
NE_CN_P_B <- read.csv2(file = "Non-Endemic_CN_Plasma/Non-Endemic_CN_Plasma_B95-8.tsv", header = T, sep = ",", dec = ".")
NE_CN_SH_A <- read.csv2(file = "Non-Endemic_CN_Saliva_Healthy/Non-Endemic_CN_Saliva_Healthy_Akata.tsv", header = T, sep = ",", dec = ".")
NE_CN_SH_B <- read.csv2(file = "Non-Endemic_CN_Saliva_Healthy/Non-Endemic_CN_Saliva_Healthy_B95-8.tsv", header = T, sep = ",", dec = ".")
NE_CN_T_A <- read.csv2(file = "Non-Endemic_CN_Tumor/Non-Endemic_CN_Tumor_Akata.tsv", header = T, sep = ",", dec = ".")
NE_CN_T_B <- read.csv2(file = "Non-Endemic_CN_Tumor/Non-Endemic_CN_Tumor_B95-8.tsv", header = T, sep = ",", dec = ".")
NE_US_SC_A <- read.csv2(file = "Non-Endemic_US_Saliva_CAEBV/Non-Endemic_US_Saliva_CAEBV_Akata.tsv", header = T, sep = ",", dec = ".")
NE_US_SC_B <- read.csv2(file = "Non-Endemic_US_Saliva_CAEBV/Non-Endemic_US_Saliva_CAEBV_B95-8.tsv", header = T, sep = ",", dec = ".")

LABEL <-  c(`Endemic_CN_Saliva_Akata` = "Saliva\t\tCancer\tEndemic\t\tChina\t\t(46)",
            `Endemic_CN_Saliva_B95.8` = "Saliva\t\tCancer\tEndemic\t\tChina\t\t(46)",
            `Endemic_CN_Saliva_Healthy_Akata` = "Saliva\t\tHealthy\tEndemic\t\tChina\t\t(36)",
            `Endemic_CN_Saliva_Healthy_B95.8` = "Saliva\t\tHealthy\tEndemic\t\tChina\t\t(36)",
            `Endemic_CN_Tumor_Akata` = "Tumor\t\tCancer\tEndemic\t\tChina\t\t(99)",
            `Endemic_CN_Tumor_B95.8` = "Tumor\t\tCancer\tEndemic\t\tChina\t\t(99)",
            `Endemic_HK_Tumor_Akata` = "Saliva\t\tCancer\tEndemic\t\tHong Kong\t(9)",
            `Endemic_HK_Tumor_B95.8` = "Saliva\t\tCancer\tEndemic\t\tHong Kong\t(9)",
            `Endemic_IN_NasalBrsh_Akata` = "Nasal Brush\tCancer\tEndemic\t\tIndonesia\t\t(13)",
            `Endemic_IN_NasalBrsh_B95.8` = "Nasal Brush\tCancer\tEndemic\t\tIndonesia\t\t(13)",
            `Endemic_IN_Tumor_Akata` = "Tumor\t\tCancer\tEndemic\t\tIndonesia\t\t(2)",
            `Endemic_IN_Tumor_B95.8` = "Tumor\t\tCancer\tEndemic\t\tIndonesia\t\t(2)",
            `Endemic_TW_Saliva_Akata` = "Saliva\t\tCancer\tEndemic\t\tTaiwan\t\t(3)",
            `Endemic_TW_Saliva_B95.8` = "Saliva\t\tCancer\tEndemic\t\tTaiwan\t\t(3)",
            `Non.Endemic_CN_Plasma_Akata` = "Plasma\t\tCancer\tNon-Endemic\tChina\t\t(1)",
            `Non.Endemic_CN_Plasma_B95.8` = "Plasma\t\tCancer\tNon-Endemic\tChina\t\t(1)",
            `Non.Endemic_CN_Saliva_Healthy_Akata` = "Saliva\t\tHealthy\tNon-Endemic\tChina\t\t(3)",
            `Non.Endemic_CN_Saliva_Healthy_B95.8` = "Saliva\t\tHealthy\tNon-Endemic\tChina\t\t(3)",
            `Non.Endemic_CN_Tumor_Akata` = "Tumor\t\tCancer\tNon-Endemic\tChina\t\t(17)",
            `Non.Endemic_CN_Tumor_B95.8` = "Tumor\t\tCancer\tNon-Endemic\tChina\t\t(17)",
            `Non.Endemic_US_Saliva_CAEBV_Akata` = "Saliva\t\tCAEBV\tNon-Endemic\tUnited States\t(5)",
            `Non.Endemic_US_Saliva_CAEBV_B95.8` = "Saliva\t\tCAEBV\tNon-Endemic\tUnited States\t(5)")

Combo <- cbind(E_CN_S_A, E_CN_S_B,
               E_CN_SH_A, E_CN_SH_B,
               E_CN_T_A, E_CN_T_B,
               E_HK_T_A, E_HK_T_B,
               E_IN_NB_A, E_IN_NB_B,
               E_IN_T_A, E_IN_T_B,
               E_TW_S_A, E_TW_S_B,
               NE_CN_P_A, NE_CN_P_B,
               NE_CN_SH_A, NE_CN_SH_B,
               NE_CN_T_A, NE_CN_T_B,
               NE_US_SC_A, NE_US_SC_B)
Combo$POS <- row.names(Combo)
mCombo <- melt(Combo, id.vars = "POS")

mCombo2 <- mCombo
mCombo2$variable_f = factor(mCombo2$variable, levels = c("Endemic_CN_Tumor_Akata", "Endemic_CN_Tumor_B95.8",
                                                         "Endemic_IN_Tumor_Akata", "Endemic_IN_Tumor_B95.8",
                                                         "Non.Endemic_CN_Tumor_Akata", "Non.Endemic_CN_Tumor_B95.8",
                                                         
                                                         "Endemic_CN_Saliva_Akata", "Endemic_CN_Saliva_B95.8" ,
                                                         "Endemic_HK_Tumor_Akata", "Endemic_HK_Tumor_B95.8",
                                                         "Endemic_TW_Saliva_Akata", "Endemic_TW_Saliva_B95.8",
                                                         "Endemic_CN_Saliva_Healthy_Akata", "Endemic_CN_Saliva_Healthy_B95.8",
                                                         "Non.Endemic_CN_Saliva_Healthy_Akata", "Non.Endemic_CN_Saliva_Healthy_B95.8",
                                                         "Non.Endemic_US_Saliva_CAEBV_Akata", "Non.Endemic_US_Saliva_CAEBV_B95.8",
                                                         
                                                         "Endemic_IN_NasalBrsh_Akata", "Endemic_IN_NasalBrsh_B95.8",
                                                         "Non.Endemic_CN_Plasma_Akata", "Non.Endemic_CN_Plasma_B95.8"))

Combo_PLOT <- ggplot(data = mCombo2, aes(x = as.numeric(POS), y = value)) +
  geom_line(aes(group = 1)) +
  scale_y_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1),
                     expand = c(0, 0.01)) +
  expand_limits(y = 1.2) +
  scale_x_continuous(breaks = c(0, 100, 200, 300, 400, 500, 600, 642),
                     expand = c(0, 5)) + #ADD THE LAST POSITION TICK
  xlab("Amino Acid Position") +
  ylab("Consevation") +
  theme_pubr() +
  annotate("rect", xmin = 1, xmax = 89 , ymin = 0, ymax = 1.19, fill = "#F8766D", alpha = 0.2) +
  annotate("text", x = 45, y = 1.12, size = 4, label = "N-Terminus") +
  annotate("rect", xmin = 90, xmax = 328 , ymin = 0, ymax = 1.19, fill = "#B79F00", alpha = 0.2) +
  annotate("text", x = 209, y = 1.12, size = 4, label = "Gly-Ala Repeat") +
  annotate("rect", xmin = 379, xmax = 387 , ymin = 0, ymax = 1.19, fill = "#00BA38", alpha = 0.2) +
  annotate("text", x = 378, y = 1.12, size = 4, label = "NLS") +
  annotate("rect", xmin = 382, xmax = 410 , ymin = 0, ymax = 1.19, fill = "#00BFC4", alpha = 0.2) +
  annotate("text", x = 396, y = 1.12, size = 4, label = "IDE") +
  annotate("rect", xmin = 413, xmax = 452 , ymin = 0, ymax = 1.19, fill = "#00BFC4", alpha = 0.2) +
  annotate("text", x = 432.5, y = 1.12, size = 4, label = "IDE") +
  
  annotate("rect", xmin = 459, xmax = 477 , ymin = 0, ymax = 1.19, fill = "#619CFF", alpha = 0.2) +
  annotate("text", x = 468, y = 1.12, size = 4, label = "DBD") +
  annotate("rect", xmin = 501, xmax = 532 , ymin = 0, ymax = 1.19, fill = "#F564E3", alpha = 0.2) +
  annotate("text", x = 516.5, y = 1.12, size = 4, label = "Dimer 1") +
  annotate("rect", xmin = 554, xmax = 598 , ymin = 0, ymax = 1.19, fill = "#F564E3", alpha = 0.2) +
  annotate("text", x = 576, y = 1.12, size = 4, label = "Dimer 2") +
  
  facet_wrap(. ~ variable_f, ncol = 2, labeller = as_labeller(LABEL)) +
  theme(strip.text = element_text(hjust = 0,
                                  size = 15))

Combo_PLOT
empty <- data.frame()

Header <- ggplot(data = empty) +
  scale_x_continuous(expand = expansion(mult = c(0.026, 0.0033))) +
  scale_y_continuous(expand = c(0, 0.01)) +
  theme_void() +
  annotate("rect", xmin = 0, xmax = 0.4985 , ymin = 0, ymax = 1, fill = "gray90") +
  annotate("text", x = 0.225, y = 0.5, size = 6, label = "Akata") +
  annotate("rect", xmin = 0.502, xmax = 1 , ymin = 0, ymax = 1, fill = "gray90") +
  annotate("text", x = 0.775, y = 0.5, size = 6, label = "B95-8")

ggarrange(Header, Combo_PLOT, 
          ncol = 1,
          heights = c(1, 20))

mSubCombo <- mCombo[mCombo$variable == "Endemic_CN_Tumor_Akata" | mCombo$variable == "Endemic_CN_Tumor_B95.8",]
SubCombo_PLOT <- ggplot(data = mSubCombo, aes(x = as.numeric(POS), y = value)) +
  geom_line(aes(group = 1)) +
  scale_y_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1),
                     expand = c(0, 0.01)) +
  expand_limits(y = 1.2) +
  scale_x_continuous(breaks = c(0, 100, 200, 300, 400, 500, 600, 642),
                     expand = c(0, 5)) + #ADD THE LAST POSITION TICK
  xlab("Amino Acid Position") +
  ylab("Consevation") +
  theme_pubr() +
  annotate("rect", xmin = 1, xmax = 89 , ymin = 0, ymax = 1.19, fill = "#F8766D", alpha = 0.2) +
  annotate("text", x = 45, y = 1.12, size = 4, label = "N-Terminus") +
  annotate("rect", xmin = 90, xmax = 328 , ymin = 0, ymax = 1.19, fill = "#B79F00", alpha = 0.2) +
  annotate("text", x = 209, y = 1.12, size = 4, label = "Gly-Ala Repeat") +
  annotate("rect", xmin = 379, xmax = 387 , ymin = 0, ymax = 1.19, fill = "#00BA38", alpha = 0.2) +
  annotate("text", x = 378, y = 1.12, size = 4, label = "NLS") +
  annotate("rect", xmin = 382, xmax = 410 , ymin = 0, ymax = 1.19, fill = "#00BFC4", alpha = 0.2) +
  annotate("text", x = 396, y = 1.12, size = 4, label = "IDE") +
  annotate("rect", xmin = 413, xmax = 452 , ymin = 0, ymax = 1.19, fill = "#00BFC4", alpha = 0.2) +
  annotate("text", x = 432.5, y = 1.12, size = 4, label = "IDE") +
  
  annotate("rect", xmin = 459, xmax = 477 , ymin = 0, ymax = 1.19, fill = "#619CFF", alpha = 0.2) +
  annotate("text", x = 468, y = 1.12, size = 4, label = "DBD") +
  annotate("rect", xmin = 501, xmax = 532 , ymin = 0, ymax = 1.19, fill = "#F564E3", alpha = 0.2) +
  annotate("text", x = 516.5, y = 1.12, size = 4, label = "Dimer 1") +
  annotate("rect", xmin = 554, xmax = 598 , ymin = 0, ymax = 1.19, fill = "#F564E3", alpha = 0.2) +
  annotate("text", x = 576, y = 1.12, size = 4, label = "Dimer 2") +
  
  facet_wrap(. ~ variable, ncol = 1, labeller = as_labeller(LABEL)) +
  theme(strip.text = element_text(hjust = 0,
                                  size = 15))
SubCombo_PLOT

#----------LN827548----------
LN_A <- read.csv2(file = "LN827548/LN827548_Akata.tsv", header = T, sep = ",", dec = ".")
LN_B <- read.csv2(file = "LN827548/LN827548_B95-8.tsv", header = T, sep = ",", dec = ".")

LN <- cbind(LN_A, LN_B)
LN$POS <- row.names(LN)
mLN <- melt(LN, id.vars = "POS")
LN_PLOT <- ggplot(data = mLN, aes(x = as.numeric(POS), y = value)) +
  geom_line(aes(group = 1)) +
  scale_y_continuous(breaks = c(0, 1),
                     expand = c(0, 0.01)) +
  expand_limits(y = 1.2) +
  scale_x_continuous(breaks = c(0, 100, 200, 300, 400, 500, 600, 642),
                     expand = c(0, 5)) + #ADD THE LAST POSITION TICK
  xlab("Amino Acid Position") +
  ylab("Consevation") +
  theme_pubr() +
  facet_wrap(. ~ variable, ncol = 1) +
  theme(strip.text = element_text(hjust = 0,
                                  size = 15))
LN_PLOT
