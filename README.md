# R codes and dataset for the paper "On a new generalized Birnbaum-Saunders regression model"  

This repository contains R scripts and datasets used in the application and simulations presented in the paper "On a new generalized Birnbaum-Saunders regression model" by Milhomem, Ribeiro, Barros and Santos (2026).

### Application  
The directory Application includes the dataset and the R scripts to replicate the results presented in the application section of the paper.  

* **Application_cheese.R:** R script for model fitting and estimation using the cheese dataset.
* **Application_rent.R:** R script for model fitting and estimation using the rent dataset.
* **BSG_GAMLSS.R:** implementation of the Generalized Birnbaum-Saunders (GBS) distribution within the gamlss framework in R.

### Simulations  
The Simulations directory is organized into subfolders corresponding to each Monte Carlo simulation scenario evaluated in the paper. For instance, the Scenario 1 directory contains the following components:  

* **Results_Scenario1.txt:** summary statistics and performance metrics compiled for the scenario.
* **SIMULATION_SCENARIO.R:** R script implementing the simulation procedure adopted in the paper.
* **Estimates_Scenario_1_n40.txt, Estimates_Scenario_1_n80.txt, Estimates_Scenario_1_n160.txt, Estimates_Scenario_1_n320.txt:** Maximum Likelihood Estimates (MLEs) for regression parameters across sample sizes ($n \in \{40, 80, 160, 320\}$).
* **SE_Estimates_Scenario_1_n40.txt, SE_Estimates_Scenario_1_180.txt, SE_Estimates_Scenario_1_n160.txt, SE_Estimates_Scenario_1_n320.txt:** estimated standard errors associated with the parameter estimates across sample sizes.
* **SAMPLE.R:** R script that generates the design matrices and the response variable.
* **BSG_GAMLSS.R:** implementation of the Generalized Birnbaum-Saunders (GBS) distribution within the gamlss framework in R.
