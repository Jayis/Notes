# Appendix
## Deductions
### summation(x^k)
```
summation(x^k), k = 0 ~ n  
    = 1 + x + x^2 + ... + x^n

For convenience, abreviate the aforementioned summation to S(n).
It's obvious that
- S(n+1) = S(n) + x^(n+1)
- S(n+1) = S(n)*x + 1

Combine two equations, we got
- S(n) + x^(n+1) = S(n)*x + 1

Some organization
-> S(n) * (1-x) = 1 - x^(n+1)

Then we got
-> S(n) = (1 - x^(n+1)) / (1-x) = (x^(n+1) - 1) / (x-1)
```
### summation(k * x^k)
```
summation(x^k), k = 0 ~ n
    = 1 + x + x^2 + ... + x^n

-> differentiate
summation'(x^k), k = 0 ~ n
    = 0 + 1 + 2 + 3*x^2 + ... + n*x^(n-1) 

-> multiply by x
x * summation'(x^k), k = 0 ~ n
    = 0 + x + 2x + 3*x^3 + ... + n*x^n
which is the summation(k * 2^k)

-> apply the formula of [summation(x^k)](#summationxk)
x * ( (n+1)*x^n/(x-1) - (x^(n+1)-1)/(x-1)^2 )
= x * ( (x-1)*(n+1)*x^n - x^(n+1) + 1) / (x-1)^2 
and this the summation(k * 2^k)
```
