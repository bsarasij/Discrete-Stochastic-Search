# Discrete-Stochastic-Search-For-Behavioral-Intervention

Behavioral interventions (such as those developed to increase physical activity, achieve smoking cessation, or weight loss) can be represented as dynamic process systems incorporating a multitude of factors, ranging from cognitive (internal) to environmental (external) influences. This facilitates the application of system identification and control engineering methods to address questions such as: what drives individuals to improve health behaviors (such as engaging in physical activity)?
<br>
<br>
<p align = "center">
  <image src ="https://github.com/user-attachments/assets/c2c63ddd-92ed-48c7-8d56-242da93067e4">
</p>
<br>
<br>
In this work, the goal is to efficiently estimate personalized, dynamic models which in turn will lead to control systems that can optimize this behavior. This problem is examined in system identification applied to the Just Walk study that aimed to increase walking behavior in sedentary adults, and it bases its foundation on a fluid analogy model for behavior change. 
<br>
<br>
<p align = "center">
  <image src = "https://github.com/user-attachments/assets/f2dde400-c748-4c6e-8e18-9da1d9340a14">
</p>
<br>
<br>
The work presents a Discrete Simultaneous Perturbation Stochastic Approximation (DSPSA)-based modeling of the Goal Attainment construct estimated using AutoRegressive with eXogenous inputs (ARX) models. Feature selection of participants and ARX order selection is achieved through the DSPSA algorithm, which efficiently handles computationally expensive calculations. DSPSA can search over large sets of features as well as regressor structures in an informed, principled manner to model behavioral data within reasonable computational time. DSPSA estimation highlights the large individual variability in motivating factors among participants in Just Walk, thus emphasizing the importance of a personalized approach for optimized behavioral interventions.

<br>
<br>
<p align = "center">
  <image width="500" height="500" src ="https://github.com/user-attachments/assets/4f644e1a-a6ec-4de4-9533-1be1496c96ed">
</p>

<br>
<br>

## Implementation of DSPSA
* Initialize input vector 𝜃 at a given step 𝑘.
* Generate random perturbation Δ as per " Bernoulli ±1 distribution"
* Perturb 𝜃 by ±𝑐Δ to generate  $𝜃^+$ , $𝜃^{−}$ 
* Evaluate system (y) at $𝜃^+$ and $𝜃^−$ 
* Approximate gradient:
  
  ```math
  \hat{g_{k}}=\frac{J(\hat{\theta}_{k}^{+})-J(\hat{\theta}_{k}^{-})}{2c_{k}\Delta_{k}}
  ```

* Update input vectors:
  
```math
\hat{\theta}_{k+1} = \hat{\theta}_{k} - a_{k}\hat{g_{k}}
```

* Repeat (2)-(6) for iteration k+1

