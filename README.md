# R codes and dataset for the dissertation "A New Generalized Birnbaum-Saunders Regression Model: A GAMLSS-Based Approach"  

This repository contains R codes and dataset used in the application and simulations of the dissertation "A New Generalized Birnbaum-Saunders Regression Model: A GAMLSS-Based Approach".

### Application  
The directory Application contains the dataset and the R scripts to replicate the results presented in the application section of the paper.  

* **Application_cheese.R:** R script to replicate the results for the cheese dataset.
* **Application_rent.R:** R script to replicate the results for the rent dataset.
* **BSG_GAMLSS.R:** Computational implementation of the BSG distribution within the architecture of the R package gamlss.

### Simulations  
The directory Simulations contains folders corresponding to the simulation scenarios presented in the Monte Carlo simulation results section of the paper. For example, folder Scenario 1 contains the following files:  

* **Results_Scenario1.txt:**
* **SIMULATION_SCENARIO.R:** An R script implementing the simulation procedure adopted in this dissertation.
* **Estimates_Scenario_1_n40.txt, Estimates_Scenario_1_n80.txt, Estimates_Scenario_1_n160.txt, Estimates_Scenario_1_n320.txt:**
* **SE_Estimates_Scenario_1_n40.txt, SE_Estimates_Scenario_1_180.txt, SE_Estimates_Scenario_1_n160.txt, SE_Estimates_Scenario_1_n320.txt:**
* **SAMPLE.R:** An R script that generates the design matrices and the response variable.
* **BSG_GAMLSS.R:** Computational implementation of the BSG distribution within the architecture of the R package gamlss.
