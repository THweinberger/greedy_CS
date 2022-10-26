# greedy_CS
This repository offers a collection of **greedy algorithms for sparse recovery** and several scripts to evaluate their empirical performance.

In compressed sensing, one wants to find the solution to the sparse recovery problem

>$$ \min_{x \in \mathbb{R}^N} \|x \|_0 ~~ \text{subject to} ~~ y = A\hat{x} \label{eq:sparseRec} $$

given $y\in \mathbb{R}^m$ and $A\in \mathbb{R}^{m \times N}$ where $m \ll N$ and where $\|\cdot\|_0:=|\{i: x_i \neq 0\}|$ denotes the 'zero norm' of a vector.

As \eqref{sparseRec} is a combinatorially hard problem, one typically instead solves the convex relaxation, known as the _basis pursuit_,

>$$ \min_{x \in \mathbb{R}^N} \|x \|_1 ~~ \text{subject to} ~~ y = A\hat{x}. \label{eq:basisPur} $$

Under appropriate conditions on the measurement matrix $A$ and the underlying data $\hat{x}$, it is well known that \eqref{eq:basisPur} has the same unique solution as \eqref{eq:sparseRec}.

Although \eqref{eq:basisPur} is convex, one often wants to avoid to use the usual general-purpose solvers due to the typically large sizes of $m,N$ encountered in many applications. Even though there are more efficient, $\ell_1$-tailored solvers available, oftentimes one instead employs the so-called _greedy algorithms_ which typically take $\mathcal{O}(\|\hat{x}\|_0)$ iterations to return a good estimate of $\hat{x}$. Crucially, these algorithms exploit the fact that $A^\top Ax\approx x$ under appropriate conditions on $A$ and $x$.

Usually the ground truth $\hat{x}$ is not exactly sparse but _compressible_, which means that only a few entries of $\hat{x}$ are significant. For many greedy algorithms, there exist results that guarantee that stable recovery is possible when solving the regularized problem

>$$ \min_{x \in \mathbb{R}^N} \|x \|_1 ~~ \text{subject to} ~~ \|y-A\hat{x}\|\leq \eta $$

for a given error threshold $\eta$.

The performance of the different greedy algorithms can be evaluated by running the included scripts, which give empirical results based on several Monte-Carlo simulations in which different parameters of the estimation problem are varied, respectively. Further, these empirical results can be used to plot the _phase diagrams_ of the respective algorithms, which are two-dimensional figures that visualize the empirical probability of successful recovery while varying two of the dimensions $s:=\|\hat{x}\|_0$, $N$ and $m$, respectively.

## List of algorithms

* `COSAMP` (_COmpressive SAmpling Matching Pursuit_), see [[N+09]](https://www.sciencedirect.com/science/article/pii/S1063520308000638).
* `CSMPSP` (A hybrid between COSAMP and Subspace Pursuit), see [[B+15]](https://onlinelibrary.wiley.com/doi/abs/10.1002/nla.1948).
* `GOMP` (_Generalized Orthogonal Matching Pursuit_), see [[W+12]](https://ieeexplore.ieee.org/document/6302206).
* `NIHT` (_Normalized Iterative Hard Thresholding_), see [[B+10]](https://ieeexplore.ieee.org/document/5419091).
* `OMP` (_Orthogonal Matching Pursuit_), see [[T+07]](https://ieeexplore.ieee.org/document/4385788).
* `ROMP` (_Regularized Orthogonal Matching Pursuit_), see [[N+09]](https://doi.org/10.1007/s10208-008-9031-3).
* `STOMP` (_STagewise Orthogonal Matching Pursuit_), see [[D+12]](https://ieeexplore.ieee.org/document/6145475).

## Examples and Usage
The above listed algorithms can be used as stand-alone. For the correct usage, including the assignment of the inputs and outputs of the individual algorithms, refer to the comments provided in the respective source codes.

To perform the Monte-Carlo simulations, run the respective files with the prefix 'script'. Additional information is provided in the source codes.

## About this repository
##### Developers:
* The code of 'Sample_measOp_CS.m' is adapted from Claudio M. Verdun, Technical University Munich.
* The remaining code is written by Thomas Weinberger (<t.weinberger@tuta.com>).

If you have any problems or questions, please contact me via e-mail.

## References
 - [[N+09]](https://www.sciencedirect.com/science/article/pii/S1063520308000638) Needell, Deanna, and Joel A. Tropp. "CoSaMP: Iterative signal recovery from incomplete and inaccurate samples." Applied and computational harmonic analysis 26.3 (2009): 301-321.
 - [[B+15]](https://onlinelibrary.wiley.com/doi/abs/10.1002/nla.1948) Blanchard, Jeffrey D., and Jared Tanner. "Performance comparisons of greedy algorithms in compressed sensing." Numerical Linear Algebra with Applications 22.2 (2015): 254-282.
 - [[W+12]](https://ieeexplore.ieee.org/document/6302206) J. Wang, S. Kwon and B. Shim, "Generalized Orthogonal Matching Pursuit," in IEEE Transactions on Signal Processing, vol. 60, no. 12, pp. 6202-6216, Dec. 2012, doi: 10.1109/TSP.2012.2218810.
 - [[B+10]](https://ieeexplore.ieee.org/document/5419091) T. Blumensath and M. E. Davies, "Normalized Iterative Hard Thresholding: Guaranteed Stability and Performance," in IEEE Journal of Selected Topics in Signal Processing, vol. 4, no. 2, pp. 298-309, April 2010, doi: 10.1109/JSTSP.2010.2042411.
  - [[T+07]](https://ieeexplore.ieee.org/document/4385788) J. A. Tropp and A. C. Gilbert, "Signal Recovery From Random Measurements Via Orthogonal Matching Pursuit," in IEEE Transactions on Information Theory, vol. 53, no. 12, pp. 4655-4666, Dec. 2007, doi: 10.1109/TIT.2007.909108.
  - [[N+09]](https://doi.org/10.1007/s10208-008-9031-3) Needell, D., Vershynin, R. Uniform Uncertainty Principle and Signal Recovery via Regularized Orthogonal Matching Pursuit. Found Comput Math 9, 317–334 (2009).
  - [[D+12]](https://ieeexplore.ieee.org/document/6145475) D. L. Donoho, Y. Tsaig, I. Drori and J. Starck, "Sparse Solution of Underdetermined Systems of Linear Equations by Stagewise Orthogonal Matching Pursuit," in IEEE Transactions on Information Theory, vol. 58, no. 2, pp. 1094-1121, Feb. 2012, doi: 10.1109/TIT.2011.2173241.
