---
title: Matematiksel İfadelerin Kod Karşılıkları
lang: tr
tags:
 - Metamatik
 - Yazılım
mathjax: true
---
Yazılım geliştirmeye başladığımdan beri sürekli olarak matematiksel ifadeler karşıma çıktı. Her seferinde ne olduklarını ve nasıl yazıldıklarını anlamaktan kaçıp onun yerine hazır yazılmış kodları kullanmak her zaman daha kolay geldi. Kodu okumak matematiksel ifadeyi okumaktan çok daha kolay gelmiştir. 
Bu belkide şu ana kadar matematiği o kadar sevmediğimden kaynalıdır. Bir yazılımcı olarak matematiğe daha fazla önem vermem gerektiğinin farkındayım.
Öncelikle basit matematiksel teoremlerin gösterimi ile başlayalım. Ben kolay anlaşılması için örnekleri Python ile yapacağım.

Matematiksel olarak atama işlemi.
$$x:=2ij$$

{% codeblock lang:python %}
i = 10
j = 20
x = 2 * i * j
print(x)
{% endcodeblock %}
Python kodunda i ve j değişkenlerinide vermemin nedeni ekrana yazdırma işlemi için gerekli olmasından dolayıdı. Matematiksel denklem sadece 3. satırda ki gibidir.

$$ J(\theta) = \frac{1}{m} \sum^m_{i=1} Cost(h_\theta(x),y) $$

$$(\sqrt{x})^2$$

{% codeblock lang:python %}
import math
x = 10
print(math.sqrt(x) ** 2)
{% endcodeblock %}
yada
{% codeblock lang:python %}
import math
x = 10
print(math.pow(math.sqrt(x), 2))
{% endcodeblock %}

$$\begin{equation*}
    f(n) = \begin{cases}
               0               & n = 0\\
               1               & n = 1\\
               f(n-1) + f(n-2) & \text{otherwise}
           \end{cases}
\end{equation*}$$


$$\cos (2\theta) = \cos^2 \theta - \sin^2 \theta$$

