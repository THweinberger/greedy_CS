# greedy_CS
This is a collection of greedy algorithms for sparse recovery.

In compressed sensing, one of the main objectives is to solve the basis pursuit problem

>$$ \min_{x \in \mathds{R}^N} \|x \|_1 \text{subject to} y = A\hat{x} \label{eq:basisPur} $$

given $y\in \mathds{R}^m$ and $A\in \mathds{R}^{m \times N}$ where $m \ll N$. Under appropriate conditions on the measurement matrix $A$ and the underlying data $\hat{x}$, this optimization is known to have the same optimum as the sparse recovery problem

>$$ \min_{x \in \mathds{R}^N} \|x \|_0 \text{subject to} y = A\hat{x} $$

where $\|\cdot\|_0:=|\{i: x_i \neq 0\}|$ denotes the 'zero norm' of a vector.

Although \eqref{eq:basisPur} is convex, one often wants to avoid to use the usual general-purpose solvers due to the typically large sizes of $m,N$ encountered in many applications. Even though there are more efficient, $\ell_1$-tailored solvers available, oftentimes one instead employs the so-called _greedy algorithms_ which typically take $\mathcal{O}(\|\hat{x}\|_0)$ iterations to return a good estimate of $\hat{x}$. Crucially, these algorithms exploit the fact that $A^\top Ax\approx x$ under appropriate conditions on $A$ and $x$.

Usually the ground truth $\hat{x}$ is not exactly sparse but _compressible_, which means that only a few entries of $\hat{x}$ are significant. For many greedy algorithms, there exists theory that guarantees that stable recovery is possible for the sparse recovery by solving the regularized problem

>$$ \min_{x \in \mathds{R}^N} \|x \|_1 \text{subject to} \|y-A\hat{x}\|\leq \eta $$

for a given error threshold $\eta$.

The performance of the different greedy algorithms can be evaluated by running the included scripts, which give empirical results based on several Monte-Carlo simulations in which different parameters of the estimation problem are varied, respectively. Further, these empirical results can be used to plot the _phase diagrams_ of the respective algorithms, which are two-dimensional figures that visualize the empirical probability of successful recovery while varying two of the dimensions $s:=\|\hat{x}\|_0$, $N$ and $m$, respectively.

## List of algorithms

* `ANM` (_Atomic Norm Minimization_), see [[C+14]](https://ieeexplore.ieee.org/abstract/document/6998075).

## Examples and Usage
The above listed algorithms can be used as stand-alone. For the correct usage, including the input and output of the individual algorithms, refer to the comments provided in the respective source codes.

To perform the Monte-Carlo simulations, run the respective files with the prefix 'script'. Additional information is provided in the source codes.

## About this repository
##### Developer:
* Thomas Weinberger (<t.weinberger@tum.de>)

If you have any problems or questions, please contact me via e-mail.

## References
 - [[S86]](https://ieeexplore.ieee.org/abstract/document/1143830) R. Schmidt, "Multiple emitter location and signal parameter estimation," in IEEE Transactions on Antennas and Propagation, vol. 34, no. 3, pp. 276-280, March 1986, doi: 10.1109/TAP.1986.1143830.
 - [[R+89]](https://ieeexplore.ieee.org/document/32276) R. Roy and T. Kailath, "ESPRIT-estimation of signal parameters via rotational invariance techniques," in IEEE Transactions on Acoustics, Speech, and Signal Processing, vol. 37, no. 7, pp. 984-995, July 1989, doi: 10.1109/29.32276.
 - [[H+90]](https://ieeexplore.ieee.org/document/56027) Y. Hua and T. K. Sarkar, "Matrix pencil method for estimating parameters of exponentially damped/undamped sinusoids in noise," in IEEE Transactions on Acoustics, Speech, and Signal Processing, vol. 38, no. 5, pp. 814-824, May 1990, doi: 10.1109/29.56027.
 - [[C+14]](https://ieeexplore.ieee.org/abstract/document/6998075) Chi, Yuejie, and Yuxin Chen. "Compressive two-dimensional harmonic retrieval via atomic norm minimization." IEEE Transactions on Signal Processing 63.4 (2014): 1030-1042.
 - [[C2+14]](https://ieeexplore.ieee.org/document/6867345) Y. Chen and Y. Chi, "Robust Spectral Compressed Sensing via Structured Matrix Completion," in IEEE Transactions on Information Theory, vol. 60, no. 10, pp. 6576-6601, Oct. 2014, doi: 10.1109/TIT.2014.2343623.
 - [[S+05]](http://user.it.uu.se/~ps/SAS-new.pdf) Stoica, Petre, and Randolph L. Moses. "Spectral analysis of signals." (2005).
 - [[R2+89]](https://ieeexplore.ieee.org/document/45540) Rao, Bhaskar D., and KV Sl Hari. "Performance analysis of root-MUSIC." IEEE Transactions on Acoustics, Speech, and Signal Processing 37.12 (1989): 1939-1949.
 - [[K+20]](https://arxiv.org/abs/2009.02905) Kümmerle, Christian, and Claudio M. Verdun. "Escaping Saddle Points in Ill-Conditioned Matrix Completion with a Scalable Second Order Method." arXiv preprint arXiv:2009.02905 (2020).
 - [[B+91]](https://ieeexplore.ieee.org/document/80967) B. Ottersten, M. Viberg and T. Kailath, "Performance analysis of the total least squares ESPRIT algorithm," in IEEE Transactions on Signal Processing, vol. 39, no. 5, pp. 1122-1135, May 1991, doi: 10.1109/78.80967.
