if (!require("pacman")) install.packages("pacman")
pacman::p_load("ggplot2","qqboxplot","GLMsData", "gamlss", "gamlss.ggplots")

#*********** Cheese data application of GBS and BS regression models *********#

source("BSG_GAMLSS.R")

data(cheese); attach(cheese); names(cheese)

# Descritive analysis

# Taste versus Lactic

ggplot(data.frame(Lactic, Taste), aes(x = Lactic, y = Taste)) +
  geom_point(
    size = 2.5,
    shape = 19,
    colour = "#2C3E50",
    alpha = 0.75
  ) +
  xlab("Lactic") +
  ylab("Taste") +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    panel.border = element_rect(
      colour = "black",
      fill = NA,
      linewidth = 0.8
    ),
    axis.text = element_text(
      size = 14,
      colour = "black"
    ),
    axis.title = element_text(
      size = 16,
      colour = "black"
    )
  )


# Taste versus log(H2S)

ggplot(data.frame(log(H2S), Taste), aes(x = log(H2S), y = Taste)) +
  geom_point(
    size = 2.5,
    shape = 19,
    colour = "#2C3E50",
    alpha = 0.75
  ) +
  xlab("log(H2S)") +
  ylab("Taste") +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    panel.border = element_rect(
      colour = "black",
      fill = NA,
      linewidth = 0.8
    ),
    axis.text = element_text(
      size = 14,
      colour = "black"
    ),
    axis.title = element_text(
      size = 16,
      colour = "black"
    )
  )


# Histogram of Taste

df <- data.frame(x = Taste)

ggplot(df, aes(x = x)) +
  geom_histogram(
    aes(y = after_stat(density)),
    colour = "white",
    fill = "#34495E",
    alpha = 0.85,
    bins = 8
  ) +
  labs(
    x = "Taste",
    y = "Density"
  ) +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    panel.border = element_rect(
      colour = "black",
      fill = NA,
      linewidth = 0.8
    ),
    axis.title.y = element_text(
      colour = "black",
      size = 16
    ),
    axis.title.x = element_text(
      colour = "black",
      size = 16
    ),
    axis.text = element_text(
      colour = "black",
      size = 14
    )
  )



#---- BS Fitted model ----#

fit_BS <- gamlss(formula = Taste ~ log(H2S) + Lactic,
                 sigma.formula = ~ 1,
                 nu.formula = ~ 1,
                 data = cheese, 
                 nu.fix = T, i.nu = 0.5, 
                 family = BSG(mu.link = "log", sigma.link ="log", nu.link = "logit"),
                 method = RS())
summary(fit_BS)


#--- Diagnostics ---#

# Worm plot

resid_wp(fit_BS, ylim=2) +
  labs(title = NULL)+
  theme_bw()+
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    strip.text = element_text(size = 14),
    panel.background = element_rect(fill="white")
    )

# Histogram with density estimator

resid_density(fit_BS)+
  labs(title = NULL)+
  theme_bw()+
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    strip.text = element_text(size = 14),
    panel.background = element_rect(fill="white")
    )

# Q-Q plot

resid_qqplot(fit_BS)+
  labs(title = NULL)+
  theme_bw()+
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    strip.text = element_text(size = 14),
    panel.background = element_rect(fill="white")
    )


# qqboxplot 

rq_BS <- resid(fit_BS) #quantile residuals

dataR <-  data.frame(y = rq_BS)
  ggplot(dataR, aes(y = rq_BS)) +                       
  geom_qqboxplot(notch=TRUE, varwidth = TRUE, reference_dist="norm") +
  xlab("reference: normal distribution") +
  ylab("Residuals") +
  theme(
    panel.background = element_rect(fill = "white"),  
    panel.border = element_rect(colour = "black", fill = NA, linewidth = 1),
    panel.grid = element_line(colour = "grey70"),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.x = element_text(size = 16, margin = margin(t = 15)),
    axis.title.y = element_text(size = 16, margin = margin(r = 15)),
    axis.text = element_text(size = 14)
  )


#---- GBS Fitted model ----#

fit_GBS <- gamlss(formula = Taste ~ log(H2S) + Lactic,
                 sigma.formula = ~ 1,
                 nu.formula = ~ 1,
                 data = cheese, 
                 family = BSG(mu.link = "log", sigma.link ="log", nu.link = "logit"),
                 method = RS())
summary(fit_GBS)


#--- Diagnostics ---#

# Worm plot

resid_wp(fit_GBS, ylim=2) +
  labs(title = NULL)+
  theme_bw()+
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    strip.text = element_text(size = 14),
    panel.background = element_rect(fill="white")
    )

# Histogram with density estimator

resid_density(fit_GBS)+
  labs(title = NULL)+
  theme_bw()+
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    strip.text = element_text(size = 14),
    panel.background = element_rect(fill="white")
    )

# Q-Q plot

resid_qqplot(fit_GBS)+
  labs(title = NULL)+
  theme_bw()+
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    strip.text = element_text(size = 14),
    panel.background = element_rect(fill="white")
    )


# qqboxplot 

rq_GBS <- resid(fit_GBS) #quantile residuals

dataR <-  data.frame(y = rq_GBS)
  ggplot(dataR, aes(y = rq_GBS)) +                       
  geom_qqboxplot(notch=TRUE, varwidth = TRUE, reference_dist="norm") +
  xlab("reference: normal distribution") +
  ylab("Residuals") +
  theme(
    panel.background = element_rect(fill = "white"),  
    panel.border = element_rect(colour = "black", fill = NA, linewidth = 1),
    panel.grid = element_line(colour = "grey70"),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.x = element_text(size = 16, margin = margin(t = 15)),
    axis.title.y = element_text(size = 16, margin = margin(r = 15)),
    axis.text = element_text(size = 14)
  )



