if (!require("pacman")) install.packages("pacman")
pacman::p_load("ggplot2","qqboxplot","GLMsData", "gamlss", "gamlss.ggplots")

#*********** Rent data application of GBS and BS regression models *********#

source("BSG_GAMLSS.R")

data(rent99); attach(rent99); names(rent99)

# Descritive analysis

ggplot(data.frame(area, rent), aes(x = area, y = rent)) +
  geom_point(
    size = 2.5,
    shape = 19,
    colour = "#2C3E50",
    alpha = 0.75
  ) +
  xlab("Area") +
  ylab("Rent") +
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

# rent versus yearc

ggplot(data.frame(yearc, rent), aes(x = yearc, y = rent)) +
  geom_point(
    size = 2.5,
    shape = 19,
    colour = "#2C3E50",
    alpha = 0.75
  ) +
  xlab("Yearc") +
  ylab("Rent") +
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

# rent versus location

ggplot(data.frame(location, rent), aes(x = location, y = rent)) + 
  geom_boxplot(
    fill = "#3498DB",
    colour = "#21618C",
    alpha = 0.55,
    linewidth = 0.8
  ) +
  xlab("Location") +
  ylab("Rent") +
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
    ),
    axis.title.x = element_text(
      size = 16,
      margin = margin(t = 20)
    )
  )

# rent versus bath

ggplot(data.frame(bath, rent), aes(x = bath, y = rent)) + 
  geom_boxplot(
    fill = "#3498DB",
    colour = "#21618C",
    alpha = 0.55,
    linewidth = 0.8
  ) +
  xlab("Bath") +
  ylab("Rent") +
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
    ),
    axis.title.x = element_text(
      size = 16,
      margin = margin(t = 20)
    )
  )


# rent versus kitchen

ggplot(data.frame(kitchen, rent), aes(x = kitchen, y = rent)) + 
  geom_boxplot(
    fill = "#3498DB",
    colour = "#21618C",
    alpha = 0.55,
    linewidth = 0.8
  ) +
  xlab("Kitchen") +
  ylab("Rent") +
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
    ),
    axis.title.x = element_text(
      size = 16,
      margin = margin(t = 20)
    )
  )


# Histogram of rent

df <- data.frame(x = rent)

ggplot(df, aes(x = x)) +
  geom_histogram(
    aes(y = after_stat(density)),
    colour = "white",
    fill = "#34495E",
    alpha = 0.85,
    bins = 30
  ) +
  labs(
    x = "Rent",
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


fit_BS <- gamlss(formula =  rent ~ area+yearc+location+bath+kitchen,
                 sigma.formula = ~ area+location,
                 data = rent99, 
                 nu.fix = T, i.nu = 0.5, 
                 family = BSG(mu.link = "log", sigma.link ="log", nu.link = "logit"),
                 method = RS(),
              control = gamlss.control(n.cyc = 400, trace = T))
summary(fit_BS)
AIC(fit_BS)
BIC(fit_BS)

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

fit_GBS <- gamlss(rent ~ area+yearc+location+bath+kitchen,
                 sigma.formula = ~ area+location,
                 nu.formula = ~ 1,
                 data = rent99, 
                 family = BSG(mu.link = "log", sigma.link ="log", nu.link = "logit"),
                 method = RS(),
              control = gamlss.control(n.cyc = 400, trace = T))
summary(fit_GBS)
AIC(fit_GBS)
BIC(fit_GBS)

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


#histogram and density estimator of the normalised quantile residuals 

resid_density(fit_GBS)+
  labs(title = NULL)+
  theme_bw()+
  theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    strip.text = element_text(size = 14),
    panel.background = element_rect(fill="white")
    )

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


