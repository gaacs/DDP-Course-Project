library(dplyr)
library(data.table)
library(knitr)

cartera <- fread("~/desktop/TCA/Simulación/Cartera_201506.csv")
cartera <- as.data.frame(cartera)

# Valorización de la garantía en VSM según el año de originación
cartera$GARANTIA_VSM <- cartera$MONTO_ORIGINAL/cartera$IM_SALARIO_MINIMO_MENSUAL

# Ratio de severidad 
cartera$RS <- cartera$GARANTIA_VSM*0.4/cartera$SALDO_VSM
cartera$cRS  <- cut(cartera$RS, breaks = c(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,4e4), include.lowest = TRUE, dig.lab = 10)

# Ratio de pago
cartera$RP <- ifelse(cartera$PAGO_TEORICO_VSM == 0, NA, cartera$PAGO_REQUERIDO_VSM/cartera$PAGO_TEORICO_VSM)
cartera$cRP  <- cut(cartera$RP, breaks = c(0,0.5,0.75,0.9,1.0,1.25,1.5,2.0,4e3), include.lowest = TRUE, dig.lab = 10)

str(cartera, list=300)

base1 <- as.data.frame(summarise(group_by(cartera, COSECHA, SITUACION_AMORTIZACION, REGIMEN, IN_CEDIDA, cRS, cRP)
                                       , N = n()
                                       , SALDO_TOTAL =  sum(SALDO, na.rm = TRUE)
                                       , EPRC_TOTAL =  sum(EPRC, na.rm = TRUE)
                                       , EPRE_TOTAL =  sum(EPRE, na.rm = TRUE)
                                       , RKP_TOTAL =  sum(RKP, na.rm = TRUE)
                                       , COBERTURA_CEK =  sum(EPRC+EPRE+RKP, na.rm = TRUE)/sum(SALDO, na.rm = TRUE)*100
))

write.csv(base1,"~/Documents/DDP-Course-Project/mortgage-dashboard/data/base1.csv")
