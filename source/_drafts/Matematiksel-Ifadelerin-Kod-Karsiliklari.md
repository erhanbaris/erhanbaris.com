---
title: Matematiksel İfadelerin Kod Karşılıkları
lang: tr
tags:
 - Metamatik
 - Yazılım
 - Python
mathjax: true
---
Yazılım geliştirmeye başladığımdan beri sürekli olarak matematiksel ifadeler karşıma çıktı. Her seferinde ne olduklarını ve nasıl yazıldıklarını anlamaktan kaçıp onun yerine hazır yazılmış kodları kullanmak her zaman daha kolay geldi. Kodu okumak matematiksel ifadeyi okumaktan çok daha kolay gelmiştir. 
Bu belkide şu ana kadar matematiği o kadar sevmediğimden kaynalıdır. Bir yazılımcı olarak matematiğe daha fazla önem vermem gerektiğinin farkındayım.
Öncelikle basit matematiksel teoremlerin gösterimi ile başlayalım. Ben kolay anlaşılması için örnekleri Python ile yapacağım.
Her zaman için uzun ve karmaşık teoriler ile boğuşmaktansa basitten zora giden pratikler üzerinde çalışmak çok daha açıklayıcı ve anlamlı geldi. Bende örneklerimde teori yerine pratikler ile anlatmayı tercih ettim.

# Temel İşlemler

| Python Kodu | Matematiksel İfade |
| :-: | :-: |
| {% codeblock lang:python %}
i = 10
j = 20
x = 2 * i * j
{% endcodeblock %} | $$ i:=10\\\\ j:=20\\\\ x:=2ij\\\\ $$ |
| {% codeblock lang:python %}
abs(-128)
{% endcodeblock %} | $$ &#124; -128 &#124; $$ |
| {% codeblock lang:python %}
A = [1, 2, 3, 4, 5, 6]
status = 3 in A
{% endcodeblock %} | $$ A = \\{ 1, 2, 3, 4, 5, 6 \\}, 3 \in A $$ |
| {% codeblock lang:python %}
A = [1, 2, 3, 4, 5, 6]
status = 20 not in A
{% endcodeblock %} | $$ A = \\{ 1, 2, 3, 4, 5, 6 \\}, 20 \notin A $$ |
| {% codeblock lang:python %}
a = [1, 2, 3, 4, 5, 6]
print(a[1] * a[2])
{% endcodeblock %} | $$ a = \\{ 1, 2, 3, 4, 5, 6 \\} \\\\a_1a_2 $$ |


# Kök İşlemi

| Python Kodu | Matematiksel İfade |
| :-: | :-: |
| {% codeblock lang:python %}
import math
x = 10
print(math.pow(math.sqrt(x), 2))
{% endcodeblock %}| $$(\sqrt{x})^2$$ |
| {% codeblock lang:python %}
import math
math.sqrt(9) * 10
{% endcodeblock %} | $$ \sqrt{9} * 10 $$ |

# Fonksiyon

| Python Kodu | Matematiksel İfade |
| :-: | :-: |
| {% codeblock lang:python %}
def f(n):
    return 2 * n
{% endcodeblock %} | $$ f(n) = 2n $$ |
| {% codeblock lang:python %}
import math
def f(n):
    return math.pow(n, 5) + (4 * math.pow(n, 2)) + 2
{% endcodeblock %} | $$f(n) = n^5 + 4n^2 + 2 $$ |
| {% codeblock lang:python %}
import math
def f(n, m):
    return math.pow(n, m)
{% endcodeblock %} | $$f(n, m) = n^m $$ |
| {% codeblock lang:python %}
def f(n, m):
    if n == m:
        return 0
    if n > m:
        return 1
    return -1
{% endcodeblock %} | $$\begin{equation} f(n) = \begin{cases} 0 & n = m\\\\1 & n > m\\\\ -1 & \text{otherwise} \end{cases}\end{equation}$$ |
| Fibonacci fonksiyonu {% codeblock lang:python %}
def f(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return f(n - 1) + f(n - 2)
{% endcodeblock %} | $$\begin{equation} f(n) = \begin{cases} 0               & n = 0\\\\1               & n = 1\\\\ f(n-1) + f(n-2) & \text{otherwise} \end{cases}\end{equation}$$ |

# Toplama İşlemi (Sigma)

| Python Kodu | Matematiksel İfade |
| :-: | :-: |
| 1'den 101'e kadar sayıların toplamı {% codeblock lang:python %}
sum = 0
for i in range(1, 101):
    sum = sum + i
{% endcodeblock %} | $$ \sum_{i=1}^{100} i $$ |
| 1'den 101'e kadar sayıların 2 ile çarpılarak 5 ile toplamının toplamı {% codeblock lang:python %}
sum = 0
for i in range(1, 101):
    sum = sum + (2 * i + 5)
{% endcodeblock %} | $$ \sum_{i=1}^{100} (2i + 5) $$ |
| İç içe iki tane döngünün sayılarının çarpımının toplamı {% codeblock lang:python %}
sum = 0
for i in range(1, 6):
    for j in range(1, 11):
        sum = sum + (i * j)
{% endcodeblock %} | $$ \sum_{i=1}^{5} \sum_{j=1}^{10} ij $$ |
| 1'den 101'e kadar sayıların toplamının 2. kuvveti {% codeblock lang:python %}
import math
sum = 0
for i in range(1, 101):
    sum = sum + i
print(math.pow(sum, 2))
{% endcodeblock %} | $$  \Bigg(\sum_{i=1}^{100} i\Bigg)^2 $$ |
| {% codeblock lang:python %}
import math
sum = 0.0
for i in range(1, 101):
    sum = sum + (1 / math.sqrt(i))
{% endcodeblock %} | $$ \sum_{i=1}^{100} \frac{1}{ \sqrt{i}} $$ |
| {% codeblock lang:python %}
a = [1, 2, 3, 4, 5, 6]
sum = 0.0
for i in range(100):
    sum = sum + a[i]
{% endcodeblock %} | $$ a = \\{ 1, 2, 3, 4, 5, 6 \\} \\\\ \sum_{i=0}^{99} a_i $$ |


Aslında matematik göründüğünden daha basit. Önemli olan gördüğünü okuyabilmek.

https://en.wikibooks.org/wiki/LaTeX/Mathematics
https://github.com/Jam3/math-as-code
http://www.mathcentre.ac.uk/resources/uploaded/mc-ty-limits-2009-1.pdf
